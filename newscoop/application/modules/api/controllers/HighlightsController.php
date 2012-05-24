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

    const LIST_LIMIT = 15;

    const IMAGE_TOP_RENDITION = 'topfront';
    const IMAGE_STANDARD_RENDITION = 'rubrikenseite';
    const IMAGE_TOP_WIDTH = 320;
    const IMAGE_TOP_HEIGHT = 140;
    const IMAGE_STANDARD_WIDTH = 105;
    const IMAGE_STANDARD_HEIGHT = 70;
    const IMAGE_RETINA_FACTOR = 2;

    /** @var Zend_Controller_Request_Http */
    private $request;

    /** @var array */
    private $response = array();

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
        $this->params = $this->request->getParams();

        if (empty($this->params['client'])) {
            print Zend_Json::encode(array());
            exit;
        }

        $this->initClient($this->params['client']);
        if (is_null($this->client['type'])) {
            print Zend_Json::encode(array());
            exit;
        }
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

                    // gets the article image in the proper size
                    if (isset($params['section_id']) && $params['section_id'] == 6 && $rank == 1) {
                        $width = $this->isClientRetina() ? self::IMAGE_TOP_WIDTH * self::IMAGE_RETINA_FACTOR : self::IMAGE_TOP_WIDTH;
                        $height = $this->isClientRetina() ? self::IMAGE_TOP_HEIGHT * self::IMAGE_RETINA_FACTOR : self::IMAGE_TOP_HEIGHT;
                        $image = $this->getImageUrl($article, self::IMAGE_TOP_RENDITION, $width, $height);
                    } else {
                        $image = $this->getImageUrl($article, self::IMAGE_STANDARD_RENDITION, $this->client['image_width'], $this->client['image_height']);
                    }

                    $comments = Zend_Registry::get('container')->getService('comment')->countBy(array(
                        'language' => $article->getLanguageId(),
                        'thread' => $article->getId(),
                    ));

                    $recommended = Zend_Registry::get('container')->getService('comment')->countBy(array(
                        'language' => $article->getLanguageId(),
                        'thread' => $article->getId(),
                        'recommended' => 1,
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
                            'topic_id' => (int) $topic->getTopicId(),
                            'topic_name' => $topic->getName(self::LANGUAGE),
                        );
                    }

                    $bodyField = 'body';
                    $teaserField = 'teaser';
                    switch($article->getType()) {
                        case 'newswire':
                            $bodyField = 'DataContent';
                            $teaserField = 'DataLead';
                            break;
                        case 'blog':
                            $teaserField = 'lede';
                            break;
                    }

                    $response = array(
                        'article_id' => (int) $article->getNumber(),
                        'url' => $this->url . '/api/articles/item?article_id=' . $article->getNumber() . '&client=' . $this->client['name'] . '&version=' . self::API_VERSION,
                        'dateline' => $dateline,
                        'short_name' => empty($short_name) ? $article->getTitle() : $short_name,
                        'teaser' => preg_replace('/(<p>|<p [^>]*>|<\\/p>)/', '', $articleData->getFieldValue($teaserField)),
                        'image_url' => $image,
                        'website_url' => $this->_helper->service('article.link')->getLink($article),
                        'comment_count' => $comments,
                        'recommended_comment_count' => $recommended,
                        'comment_url' => $this->url . '/api/comments/list?article_id=' . $article->getNumber() . '&client=' . $this->client['name'] . '&version=' . self::API_VERSION,
                        'topics' => $topics,
                        'rank' => $rank++,
                        'section_id' => (int) $sectionId,
                        'section_name' => $playlist->getName(),
                        'section_url' => $this->url . '/api/articles/list?section_id=' . $sectionId . '&client=' . $this->client['name'] . '&version=' . self::API_VERSION,
                        'section_rank' => $section_rank,
                    );

                    if ($this->client['type'] == 'iphone') {
                        unset($response['teaser']);
                    }

                    $this->response[] = $response;
                }
                $section_rank++;
            }
        }

        $this->_helper->json($this->response);
    }

    private function getImageUrl(Article $article, $rendition, $width, $height)
    {
        $image = $this->getImage($article, $rendition);
        if (empty($image)) {
            return null;
        }

        $imageUrl = $this->view->url(array(
            'src' => $this->getHelper('service')->getService('image')->getSrc(basename($image->src), $width, $height, 'fit'),
            ),
            'image', false, false);

        return $this->url . $imageUrl;
    }

    /**
     * Return image url
     *
     * @param Article $article
     * @return string $thumbnail
     */
    private function getImage(Article $article, $rendition)
    {
        $renditions = Zend_Registry::get('container')->getService('image.rendition')->getRenditions();
        if (!array_key_exists($rendition, $renditions)) {
            return null;
        }

        $articleRenditions = Zend_Registry::get('container')
            ->getService('image.rendition')->getArticleRenditions($article->getId());
        $articleRendition = $articleRenditions[$renditions[$rendition]];

        if ($articleRendition === null) {
            return null;
        }

        $thumbnail = $articleRendition->getRendition()->
            getThumbnail($articleRendition->getImage(), Zend_Registry::get('container')->getService('image'));

        return $thumbnail;
    }

    private function initClient($client)
    {
        $type = null;
        if (strstr($client, 'ipad')) {
            $type = 'ipad';
        } elseif (strstr($client, 'iphone')) {
            $type = 'iphone';
        }

        $this->client = array(
            'name' => $client,
            'type' => $type,
            'image_width' => self::IMAGE_STANDARD_WIDTH,
            'image_height' => self::IMAGE_STANDARD_HEIGHT,
        );

        if ($this->isClientRetina()) {
            $this->client['image_width'] = $this->client['image_width'] * self::IMAGE_RETINA_FACTOR;
            $this->client['image_height'] = $this->client['image_height'] * self::IMAGE_RETINA_FACTOR;
        }
    }

    private function isClientRetina()
    {
        return $this->client['name'] == 'ipad_retina' || $this->client['name'] == 'iphone_retina';
    }
}
