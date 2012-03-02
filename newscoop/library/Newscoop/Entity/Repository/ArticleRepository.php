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
        foreach ($articles as $article) {
            $this->getEntityManager()->createQuery('UPDATE Newscoop\Entity\Article a SET a.indexed = CURRENT_TIMESTAMP() WHERE a.number = :number AND a.language = :language')
                ->setParameters(array(
                    'number' => (int) $article->getNumber(),
                    'language' => (int) $article->getLanguageId(),
                ))
                ->execute();
        }
    }
}
