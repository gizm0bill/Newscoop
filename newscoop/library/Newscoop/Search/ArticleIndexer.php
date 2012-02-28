<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

namespace Newscoop\Search;

/**
 * Article indexer
 */
class ArticleIndexer implements IndexerInterface
{
    /**
     * @var Doctrine\ORM\EntityManager
     */
    private $orm;

    /**
     * @param Doctrine\ORM\EntityManager $orm
     */
    public function __construct(\Doctrine\ORM\EntityManager $orm)
    {
        $this->orm = $orm;
    }

    /**
     * Update index
     */
    public function update(Index $index)
    {
        foreach ($this->getArticlesForIndexing() as $article) {
            $index->add($this->index($article));
            $this->orm->flush($article);
        }
    }

    /**
     * Get articles for indexing
     *
     * @return array
     */
    private function getArticlesForIndexing()
    {
        return $this->orm->getRepository('Newscoop\Entity\Article')
            ->createQueryBuilder('a')
            ->andWhere('a.workflowStatus = :published')
            ->andWhere('a.indexed IS NULL OR a.indexed < a.date')
            ->andWhere('a.date <= :delay')
            ->orderBy('a.number', 'desc')
            ->setMaxResults(50)
            ->getQuery()
            ->setParameters(array(
                'published' => \Newscoop\Entity\Article::STATUS_PUBLISHED,
                'delay' => date_create('-5 min')->format(\Newscoop\Entity\Article::DATE_FORMAT),
            ))
            ->getResult();
    }

    /**
     * Index article
     *
     * @param Newscoop\Entity\Article $article
     * @return object
     */
    private function index(\Newscoop\Entity\Article $article)
    {
        $article->setIndexed();
        $doc = array(
            'id' => sprintf('article-%d-%d', $article->getNumber(), $article->getLanguageId()),
            'headline' => $article->getTitle(),
            'lead' => $article->getData('lede'),
            'type' => $article->getType(),
        );

        switch ($article->getType()) {
            case 'blog':
            case 'news':
                $doc['content'] = $article->getData('body');
                break;

            case 'dossier':
                $doc['content'] = $article->getData('history');
                break;
        }

        return $doc;
    }
}
