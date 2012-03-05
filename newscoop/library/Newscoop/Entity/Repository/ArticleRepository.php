<?php
/**
 * @package Newscoop
 * @copyright 2011 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl.txt
 */

namespace Newscoop\Entity\Repository;

use DateTime,
    Doctrine\ORM\EntityRepository,
    Doctrine\ORM\QueryBuilder,
    Newscoop\Datatable\Source as DatatableSource;

/**
 * Article repository
 */
class ArticleRepository extends DatatableSource implements \Newscoop\Search\IndexableRepositoryInterface
{
    /**
     * Find indexable articles
     *
     * @return array
     */
    public function findIndexable()
    {
        return $this->createQueryBuilder('a')
            ->andWhere('a.indexed IS NULL OR a.indexed < a.date')
            ->getQuery()
            ->setMaxResults(50)
            ->getResult();
    }

    /**
     * Set indexed now
     *
     * @param array $articles
     * @return void
     */
    public function setIndexedNow(array $articles)
    {
        $groups = array();
        foreach ($articles as $article) {
            if (!array_key_exists($article->getLanguageId(), $groups)) {
                $groups[$article->getLanguageId()] = array();
            }

            $groups[$article->getLanguageId()][] = $article->getNumber();
        }

        foreach ($groups as $languageId => $articleIds) {
            $this->getEntityManager()->createQuery('UPDATE Newscoop\Entity\Article a SET a.indexed = CURRENT_TIMESTAMP() WHERE a.number IN (:ids) AND a.language = :language')
                ->setParameters(array(
                    'ids' => $articleIds,
                    'language' => (int) $languageId,
                ))
                ->execute();
        }
    }

    /**
     * Set indexed null
     *
     * @return void
     */
    public function setIndexedNull()
    {
        $this->getEntityManager()->createQuery('UPDATE Newscoop\Entity\Article a SET a.indexed = NULL')
            ->execute();
    }
}
