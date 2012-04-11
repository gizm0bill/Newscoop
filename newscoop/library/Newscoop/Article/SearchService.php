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
     * @var Newscoop\Article\LinkService
     */
    private $linkService;

    /**
     * @var array
     */
    private $config = array(
        'type' => array(),
        'rendition' => null,
        'blogs' => array('blog', 'bloginfo'),
    );

    /**
     * @param Newscoop\Webcode\Mapper $webcoder
     * @param Newscoop\Image\RenditionService $renditionService
     * @param Newscoop\Article\LinkService $linkService
     * @param array $config
     */
    public function __construct(\Newscoop\Webcode\Mapper $webcoder, \Newscoop\Image\RenditionService $renditionService, LinkService $linkService, array $config)
    {
        $this->webcoder = $webcoder;
        $this->renditionService = $renditionService;
        $this->linkService = $linkService;
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
        return $article->isPublished() && in_array($article->getType(), $this->config['type']) && $article->getSectionNumber() > 0;
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
            'type' => in_array($article->getType(), $this->config['blogs']) ? 'blog' : $article->getType(),
            'published' => gmdate(self::DATE_FORMAT, date_create($article->getPublishDate())->getTimestamp()),
            'author' => array_map(function($author) {
                return $author->getFullName();
            }, $article->getAuthors()),
            'webcode' => $this->webcoder->encode($article->getNumber()),
            'image' => $image ? $image['src'] : null,
            'link' => $this->linkService->getLink($article),
            'section' => in_array($article->getType(), $this->config['blogs']) ? 'blog' : $this->linkService->getSectionShortName($article),
            'section_name' => in_array($article->getType(), $this->config['blogs']) ? 'Blog' : $article->getSectionName(),
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
                $doc['title'] = array(
                    'value' => $doc['title'],
                    'boost' => 1.5,
                );
                break;

            case 'newswire':
                $doc['lead'] = strip_tags($article->getData('DataLead'));
                $doc['content'] = strip_tags($article->getData('DataContent'));
                break;

            case 'link':
                $doc['link_url'] = $article->getData('link_url');
                $doc['link_description'] = strip_tags($article->getData('link_description'));
                break;

            case 'event':
                $doc['event_organizer'] = $article->getData('organizer');
                $doc['event_town'] = $article->getData('town');
                $doc['event_date'] = $article->getData('date');
                $doc['event_time'] = $article->getData('time');
                break;

            case 'bloginfo':
                $doc['lead'] = strip_tags($article->getData('motto'));
                $doc['content'] = strip_tags($article->getData('infolong'));
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
