<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

namespace Newscoop\Article;

/**
 * Search Service
 */
class SearchService implements \Newscoop\Search\ServiceInterface
{
    /**
     * @var Newscoop\Webcode\Mapper
     */
    private $webcoder;

    /**
     * @var Newscoop\Image\RenditionService
     */
    private $renditionService;

    /**
     * @var array
     */
    private $config = array(
        'type' => array(),
        'rendition' => null,
    );

    /**
     * @param Newscoop\Webcode\Mapper $webcoder
     * @param Newscoop\Image\RenditionService $renditionService
     * @param array $config
     */
    public function __construct(\Newscoop\Webcode\Mapper $webcoder, \Newscoop\Image\RenditionService $renditionService, array $config)
    {
        $this->webcoder = $webcoder;
        $this->renditionService = $renditionService;
        $this->config = array_merge($this->config, $config);
    }

    /**
     * Test if article is indexed
     *
     * @param Newscoop\Entity\Article $article
     * @return bool
     */
    public function isIndexed($article)
    {
        return $article->getIndexed() !== null;
    }

    /**
     * Test if article can be indexed
     *
     * @param Newscoop\Entity\Article $article
     * @return bool
     */
    public function isIndexable($article)
    {
        return $article->isPublished() && in_array($article->getType(), $this->config['type']);
    }

    /**
     * Get document representation for article
     *
     * @param Newscoop\Entity\Article $article
     * @return array
     */
    public function getDocument($article)
    {
        $image = $this->renditionService->getArticleRenditionImage($article->getNumber(), $this->config['rendition'], 200, 150);

        $doc = array(
            'id' => $this->getDocumentId($article),
            'title' => $article->getTitle(),
            'type' => $article->getType(),
            'published' => gmdate('Y-m-d\TH:i:s\Z', date_create($article->getPublishDate())->getTimestamp()),
            'author' => array_map(function($author) {
                return $author->getFullName();
            }, $article->getAuthors()),
            'webcode' => $this->webcoder->encode($article->getNumber()),
            'image' => $image ? $image['src'] : null,
            'link' => $article->getLink(),
            'section' => $article->getSectionNumber(),
            'keyword' => explode(',', $article->getKeywords()),
            'topic' => $article->getTopicNames(),
        );

        switch ($article->getType()) {
            case 'blog':
            case 'news':
                $doc['lead'] = strip_tags($article->getData('lede'));
                $doc['content'] = strip_tags($article->getData('body'));
                break;

            case 'dossier':
                $doc['lead'] = strip_tags($article->getData('lede'));
                $doc['content'] = strip_tags($article->getData('history'));
                break;

            case 'newswire':
                $doc['lead'] = strip_tags($article->getData('DataLead'));
                $doc['content'] = strip_tags($article->getData('DataContent'));
                break;
        }

        return array_filter($doc);
    }

    /**
     * Get document id
     *
     * @param Newscoop\Entity\Article $article
     * @return string
     */
    public function getDocumentId($article)
    {
        return sprintf('article-%d-%d', $article->getNumber(), $article->getLanguageId());
    }
}
