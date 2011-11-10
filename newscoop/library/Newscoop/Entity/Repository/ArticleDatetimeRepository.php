<?php
/**
 * @package Newscoop
 * @copyright 2011 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

namespace Newscoop\Entity\Repository;

use Newscoop\Entity\ArticleDatetime,
    Doctrine\ORM\EntityRepository,
    Newscoop\ArticleDatetime as ArticleDatetimeHelper,
    Newscoop\Entity\Article;

class ArticleDatetimeRepository extends EntityRepository
{
    /**
     * Adds time intervals
     * @param array $timeSet
     * 		Complex set of intervals
     *		{
     *			"2011-11-02" = { "12:00" => "18:00", "20:00" => "22:00" } - between these hours on 11-02
     *			"2011-11-03" = "11:00" - at 11:00 this day
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
     */
    public function add( $timeSet, $articleId, $fieldName = null )
    {
        $insertValues = array();
        if (is_array($timeSet)) {
            foreach ($timeSet as $start => $end ) {
                $insertValues[] = new ArticleDatetimeHelper(array( $start => $end ));
            }
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
        var_dump($em->getUnitOfWork()->getScheduledEntityInsertions());
        $em->flush();
        $em->getConnection()->commit();
    }
}
