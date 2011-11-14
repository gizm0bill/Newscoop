<?php
/**
 * @package Newscoop
 * @copyright 2011 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

namespace Newscoop\Entity\Repository;

use Doctrine\ORM\Query;

use Doctrine\ORM\Configuration;

use Doctrine\ORM\Query\SqlWalker;

use Doctrine\ORM\Query\Parser;

use Doctrine\ORM\Query\AST\Functions\FunctionNode;

use Doctrine\ORM\Query\ResultSetMapping;

use Newscoop\Entity\ArticleDatetime,
    Doctrine\ORM\EntityRepository,
    Newscoop\ArticleDatetime as ArticleDatetimeHelper,
    Newscoop\Entity\Article;

class ArticleDatetimeRepository extends EntityRepository
{
    /**
     * Adds time intervals
     * @param array|ArticleDatetime $timeSet
     * 		Complex set of intervals
     *		{
     *			"2011-11-02" = { "12:00" => "18:00", "20:00" => "22:00", [ "recurring" => true|false ] } - between these hours on 11-02
     *			"2011-11-03" = "11:00 - recurring:weekly" - at 11:00 this day, and recurring weekly
     *			"2011-11-03 14:00" = "18:00" - from 3rd nov 14:00 until 18:00
	 *			"2011-11-04" = "2011-11-07" - from 4th till 7th nov
	 *			"2011-11-08" = "2011-11-09 12:00" - from 8th till 12:00 9th
	 * 			"2011-11-10 10:30" = "2011-11-11" - from 10th 10:40 until the end of the day
     *			"2011-11-12 12:30" = "2011-11-13 13:00" - self explanatory
     *			"2011-11-14 14:30" = "2011-11-15 15:00" - self explanatory
     *			"2011-11-15 15:30" = "2011-11-17" - self explanatory
     *			"2011-11-30" = true - on the 30th full day
     *		}
     * @param int|Article $articleId
     * @param string $fieldName
     * @param string $recurring
     */
    public function add( $timeSet, $articleId, $fieldName = null, $recurring = null )
    {
        $insertValues = array();
        if (is_array($timeSet)) {
            foreach ($timeSet as $start => $end )
            {
                $insertValues[] = new ArticleDatetimeHelper // some logic to capture the recurring also included
                (
                    array( $start => $end ),
                    is_array($end) && isset($end['recurring'])
                        ? $end['recurring']
                        : (!is_array($end) && ($x = preg_grep('/recurring:\w+/i', explode('-', $end))) && count($x) ?
                            next(preg_split('/\s*:\s*/', current($x))) : $recurring)
                );
            }
        }
        if ($timeSet instanceof ArticleDatetimeHelper) {
            $insertValues[] = $timeSet;
        }
        $em = $this->getEntityManager();
        // check article
        if (is_numeric($articleId)) {
            $article = $em->getRepository('Newscoop\Entity\Article')->findOneBy(array('number' => $articleId));
            /* @var $article Newscoop\Entity\Article */
        }
        elseif ($articleId instanceof Article) {
            $article = $articleId;
        }
        if (is_null($article)) {
            return false;
        };

        try // delete all entries and add new ones
        {
            $em->getConnection()->beginTransaction();
            foreach ($this->findBy(array('articleId' => $articleId)) as $entry) {
                $em->remove($entry);
            }
            foreach ($insertValues as $dateValue) {
                foreach (array_merge(array($dateValue), $dateValue->getSpawns()) as $dateValue)
                {
                    $articleDatetime = new ArticleDatetime();
                    $articleDatetime->setValues($dateValue, $article, $fieldName);
                    $em->persist($articleDatetime);
                }
            }
            $em->flush();
            $em->getConnection()->commit();
        }
        catch (\Exception $e) // rollback on commit
        {
            $em->getConnection()->rollback();
            $em->close();
            return $e;
        }
    }

    /**
     * Find dates
     * @param object $search
     * 		{
     * 			fromDate : dateFormat,
     * 			toDate : dateFormat,
     * 			fromTime : dateFormat,
     * 			toTime : dateFormat,
     * 			daily : bool|dateFormat,
     * 			weekly : dateFormat,
     *			monthly : dateFormat,
     *			yearly : dateFormat
     *		}
     */
    public function findDates($search)
    {
        $qb = $this->createQueryBuilder('dt');

        // date interval
        if (isset($search->fromDate) && isset($search->toDate))
        {
            $qb->add('where',
                $qb->expr()->andx
                (
					'dt.startDate <= ?1',
                    $qb->expr()->orx('dt.endDate >= ?2', 'dt.endDate is null')
                ));
            $qb->setParameter(1, new \DateTime($search->fromDate));
            $qb->setParameter(2, new \DateTime($search->toDate));
        }
        if (isset($search->fromTime))
        {
            $qb->andWhere('dt.startTime <= ?3');
            $qb->setParameter(3, new \DateTime($search->fromTime));
        }
        if (isset($search->toTime))
        {
            $qb->andWhere('dt.endTime >= ?4');
            $qb->setParameter(4, new \DateTime($search->toTime));
        }
        if (isset($search->daily))
        {
            $qb->andWhere('dt.recurring = ?5');
            $qb->setParameter(5, 'daily');

            if (is_string($search->daily)) // replace start time with daily string value
            {
                $qb->setParameter(3, new \DateTime(key($search->daily)));
            }
            if (is_array($search->daily)) // replace time with daily key values
            {
                $paraCount = 10;
                $orSqlParts = array();
                foreach ($search->daily as $startTime => $endTime)
                {
                    $orSqlParts[] = "( dt.startTime <= ?$paraCount and (dt.endTime >= ?".($paraCount+1)." or dt.endTime is null) )";
                    $qb->setParameter($paraCount++, new \DateTime($startTime));
                    $qb->setParameter($paraCount++, new \DateTime($endTime));
                }
                $qb->andWhere(implode(" or ", $orSqlParts));
            }
        }
        if (isset($search->weekly))
        {
            $qb->andWhere($qb->expr()->andx
            (
        		'DAYOFWEEK(dt.startDate) = ?6',
        		'dt.recurring = ?7'
            ));
            $qb->setParameter(7, 'weekly');
            if (is_string($search->weekly))
            {
                $dayOfWeek = new \DateTime($search->weekly);
                $dayOfWeek = $dayOfWeek->format('w')+1;
                $qb->setParameter(6, $dayOfWeek);
            }
        }
        if (isset($search->monthly))
        {
            $qb->andWhere($qb->expr()->andx
            (
                'DAYOFMONTH(dt.startDate) = ?8',
                'dt.recurring = ?9'
            ));
            if (is_string($search->monthly))
            {
                $dayOfMonth = new \DateTime($search->monthly);
                $dayOfMonth = $dayOfMonth->format('d');
                $qb->setParameter(8, $dayOfMonth);
                $qb->setParameter(9, 'monthly');
            }
        }

        if (isset($search->yearly))
        {
            return false;
            $qb->add('where', $qb->expr()->andx
            (
                'DAYOFYEAR(dt.startDate) = ?10',
                'dt.recurring = ?10'
            ));
            if (is_string($search->yearly))
            {
                $dayOfYear = new \DateTime($search->yearly);
                $dayOfYear = $dayOfYear->format('z');
                $qb->setParameter(10, $dayOfYear);
            }
        }
        /*var_dump($qb->getQuery()->getParameters());
        var_dump($qb->getQuery()->getSQL());
        var_dump($qb->getQuery()->getResult());
        die;*/
        return $qb->getQuery()->getResult();

        // $search->fromDate;

        // $search->fromDate $search->toDate

        // $search->weekly = 'monday' $search->fromTime
        // $search->daily = '12:00'
        // $search->monthly = '3rd'
        // $search->yearly = 112

        // $search->fromTime $search->toTime $search->dates = array(11, 12, 15)
    }
}
