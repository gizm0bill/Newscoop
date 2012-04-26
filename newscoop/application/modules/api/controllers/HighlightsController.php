<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

use Newscoop\Entity\Article;

/**
 */
class Api_HighlightsController extends Zend_Controller_Action
{
    const API_VERSION = 1;
    const LANGUAGE = 5;
    const PUBLICATION = 1;
    const ARTICLE_RENDITION = 'topfront';

    /** @var Zend_Controller_Request_Http */
    private $request;

    private $url;

    /**
     * Init controller.
     */
    public function init()
    {
        global $Campsite;

        $this->_helper->layout->disableLayout();
        $this->request = $this->getRequest();
        $this->url = $Campsite['WEBSITE_URL'];
    }

    /**
     * Default action controller.
     */
    public function indexAction()
    {
        $this->_forward('list');
    }

    /**
     * Return list of articles.
     *
     * @return json
     */
    public function listAction()
    {
        $this->getHelper('contextSwitch')->addActionContext('list', 'json')->initContext();
        $response = array();

        $params = $this->request->getParams();
        if (isset($params['section_id'])) {
            $sectionIds = array((int) $params['section_id']);
        } else {
            $sectionIds = array(6, 7, 8, 9, 10); // @todo config
        }

        $section_rank = 1;
        foreach ($sectionIds as $sectionId) {
            $playlistRepository = $this->_helper->entity->getRepository('Newscoop\Entity\Playlist');
            $playlist = $playlistRepository->findOneBy(array('id' => $sectionId));
            if ($playlist) {
                $articleArray = $playlistRepository->articles($playlist, null, false, 3);
                $rank = 1;
                foreach ($articleArray as $articleItem) {
                    $articles = $this->_helper->service('article')->findBy(array('number' => $articleItem['articleId']));
                    $article = $articles[0];
                    $articleData = new ArticleData($article->getType(), $article->getId(), $article->getLanguageId());

                    $imageUrl = null;
                    $image = $this->getImage($article);
                    if (!empty($image)) {
                        $imageUrl = $this->url . '/images/cache/' . $image->src;
                    }

                    $comments = Zend_Registry::get('container')->getService('comment')->countBy(array(
                        'language' => $article->getLanguageId(),
                        'thread' => $article->getId(),
                    ));

                    try {
                        $dateline = $articleData->getFieldValue('dateline');
                    } catch (\InvalidPropertyException $e) {
                        $dateline = '';
                    }

                    try {
                        $short_name = $articleData->getFieldValue('short_name');
                    } catch (\InvalidPropertyException $e) {
                        $short_name = $article->getTitle();
                    }

                    $topics = array();
                    $topicList = ArticleTopic::GetArticleTopics($article->getNumber());
                    foreach ($topicList as $topic) {
                        $topics[] = array(
                            'topic_id' => $topic->getTopicId(),
                            'topic_name' => $topic->getName(self::LANGUAGE),
                        );
                    }

                    $response[] = array(
                        'article_id' => $article->getNumber(),
                        'url' => $this->url . '/api/articles/item?article_id=' . $article->getNumber(),
                        'dateline' => $dateline,
                        'short_name' => empty($short_name) ? $article->getTitle() : $short_name,
                        'publish_date' => $article->getPublishDate(),
                        'image_url' => $imageUrl,
                        'website_url' => $this->_helper->service('article.link')->getLink($article),
                        'comment_count' => $comments,
                        'comment_url' => $this->url . '/api/comments/list?article_id=' . $article->getNumber() . '&version=' . self::API_VERSION,
                        'topics' => $topics,
                        'rank' => $rank++,
                        'section_id' => $article->getSectionId(),
                        'section_name' => $playlist->getName(),
                        'section_url' => $this->url . '/api/sections/item?section_id=' . $article->getSectionId() . '&version=' . self::API_VERSION,
                        'section_rank' => $section_rank,
                    );
                }
                $section_rank++;
            }
        }

        $this->_helper->json($response);
    }

    /**
     * Return image url
     *
     * @param Article $article
     * @return string $thumbnail
     */
    private function getImage(Article $article)
    {
        $renditions = Zend_Registry::get('container')->getService('image.rendition')->getRenditions();
        if (!array_key_exists(self::ARTICLE_RENDITION, $renditions)) {
            return null;
        }

        $articleRenditions = Zend_Registry::get('container')
            ->getService('image.rendition')->getArticleRenditions($article->getId());
        $articleRendition = $articleRenditions[$renditions[self::ARTICLE_RENDITION]];

        if ($articleRendition === null) {
            return null;
        }

        $thumbnail = $articleRendition->getRendition()->
            getThumbnail($articleRendition->getImage(), Zend_Registry::get('container')->getService('image'));

        return $thumbnail;
    }
}
