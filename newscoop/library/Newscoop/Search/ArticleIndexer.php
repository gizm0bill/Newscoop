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
class ArticleIndexer extends IndexerTemplate
{
    /**
     * @var Newscoop\Webcode\Webcoder
     */
    private $webcoder;

    /**
     * @param Doctrine\ORM\EntityManager $orm
     * @param Newscoop\Webcode\Mapper $webcoder
     */
    public function __construct(\Doctrine\ORM\EntityManager $orm, \Newscoop\Webcode\Mapper $webcoder)
    {
        parent::__construct($orm);
        $this->webcoder = $webcoder;
    }

    /**
     * Get articles for indexing
     *
     * @return array
     */
    protected function getIndexable()
    {
        return $this->orm->getRepository('Newscoop\Entity\Article')
            ->createQueryBuilder('a')
            ->andWhere('a.workflowStatus = :published')
            ->andWhere('a.indexed IS NULL OR a.indexed < a.date')
            ->andWhere('a.date <= :delay')
            ->andWhere('a.type IN (:types)')
            ->orderBy('a.number', 'desc')
            ->setMaxResults(50)
            ->getQuery()
            ->setParameters(array(
                'published' => \Newscoop\Entity\Article::STATUS_PUBLISHED,
                'delay' => date_create('-5 min')->format(\Newscoop\Entity\Article::DATE_FORMAT),
                'types' => array('blog', 'news', 'dossier', 'newswire'),
            ))
            ->getResult();
    }

    /**
     * Get article document
     *
     * @param Newscoop\Entity\Article $article
     * @return array
     */
    protected function getDocument(IndexableInterface $article)
    {
        $doc = array(
            'id' => sprintf('article-%d-%d', $article->getNumber(), $article->getLanguageId()),
            'headline' => $article->getTitle(),
            'type' => $article->getType(),
            'published' => gmdate('Y-m-d\TH:i:s\Z', date_create($article->getPublishDate())->getTimestamp()),
            'author' => array_map(function($author) {
                return $author->getFullName();
            }, $article->getAuthors()),
            'webcode' => $this->webcoder->encode($article->getNumber()),
        );

        switch ($article->getType()) {
            case 'blog':
            case 'news':
                $doc['lead'] = $article->getData('lede');
                $doc['content'] = $article->getData('body');
                break;

            case 'dossier':
                $doc['lead'] = $article->getData('lede');
                $doc['content'] = $article->getData('history');
                break;

            case 'newswire':
                $doc['lead'] = $article->getData('DataLead');
                $doc['content'] = $article->getData('DataContent');
                break;
        }

        return array_filter($doc);
    }
}
