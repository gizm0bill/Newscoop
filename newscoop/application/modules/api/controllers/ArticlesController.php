<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

use Newscoop\Entity\Article;
use Newscoop\Webcode\Manager;

require_once($GLOBALS['g_campsiteDir'].'/classes/ArticleTopic.php');
require_once($GLOBALS['g_campsiteDir'].'/classes/ArticleAttachment.php');

/**
 */
class Api_ArticlesController extends Zend_Controller_Action
{
    const API_VERSION = 1;

    const LANGUAGE = 5;

    const LIST_URI_PATH = 'api/articles/list';
    const ITEM_URI_PATH = 'api/articles/item';

    const LIST_LIMIT = 15;

    const IMAGE_STANDARD_RENDITION = 'rubrikenseite';
    const IMAGE_STANDARD_WIDTH = 105;
    const IMAGE_STANDARD_HEIGHT = 70;
    const IMAGE_RETINA_FACTOR = 2;

    private $client;

    /** @var Zend_Controller_Request_Http */
    private $request;

    /** @var array */
    private $response = array();

    /**
     * Init controller
     */
    public function init()
    {
        global $Campsite;

        $this->_helper->layout->disableLayout();
        $this->request = $this->getRequest();
        $this->language = $this->_helper->entity->getRepository('Newscoop\Entity\Language')->findOneBy(array('id' => self::LANGUAGE));
        $this->articleService = $this->_helper->service('article');
        $this->url = $Campsite['WEBSITE_URL'];
        $this->params = $this->request->getParams();

        if (empty($this->params['client'])) {
            $this->_helper->json($this->response);
            exit;
        }

        $this->initClient($this->params['client']);
        if (is_null($this->client['type'])) {
            $this->_helper->json($this->response);
            exit;
        }
    }

    /**
     * Default action controller
     */
    public function indexAction()
    {
        $this->_forward('list');
    }

    /**
     * Return list of articles
     *
     * @return Newscoop\API\Response
     */
    public function listAction()
    {
        $this->getHelper('contextSwitch')->addActionContext('list', 'json')->initContext();

        $criteria = array();
        $params = $this->request->getParams();

        if (!empty($params['section_id'])) {
            $playlist = $this->_helper->entity->getRepository('Newscoop\Entity\Playlist')
                ->find($params['section_id']);
            if (empty($playlist)) {
                $this->_helper->json($this->response);
                exit;
            }

            $articles = $this->_helper->entity->getRepository('Newscoop\Entity\Playlist')
                ->articles($playlist, null, false, self::LIST_LIMIT);
        } else {
            if (!empty($params['type'])) {
                $criteria[] = new ComparisonOperation('type', new Operator('is'), (string) $params['type']);
            }
            if (!empty($params['topic_id'])) {
                /** @todo */
                $criteria[] = new ComparisonOperation('topic', new Operator('is'), $params['topic_id']);
            }

            $articles = \Article::GetList($criteria, null, 0, self::LIST_LIMIT, $count = 0, false, false);
        }

        $rank = 1;
        foreach ($articles as $item) {
            $articleNumber = isset($playlist) ? $item['articleId'] : $item['number'];
            $article = $this->articleService->find($this->language, $articleNumber);
            if (empty($article)) continue;

            $image = $this->getImageUrl($article, self::IMAGE_STANDARD_RENDITION, $this->client['image_width'], $this->client['image_height']);

            // gets article custom data
            $articleData = new ArticleData($article->getType(), $article->getId(), self::LANGUAGE);

            $bodyField = 'body';
            $teaserField = 'teaser';
            $datelineField = 'dateline';
            switch($article->getType()) {
                case 'newswire':
                    $bodyField = 'DataContent';
                    $teaserField = 'DataLead';
                    break;
                case 'blog':
                    $teaserField = 'lede';
                    $datelineField = 'short_name';
                    break;
            }

            $response = array(
                'article_id' => $article->getId(),
                'url' => $this->url . '/' . self::ITEM_URI_PATH . '?article_id=' . $article->getId() . '&client=' . $this->client['name'] . '&version=' . self::API_VERSION,
                'dateline' => $articleData->getFieldValue($datelineField),
                'short_name' => $articleData->getFieldValue('short_name'),
                'teaser' => preg_replace('/(<p>|<p [^>]*>|<\\/p>)/', '', $articleData->getFieldValue($teaserField)),
                'image_url' => $image,
                'website_url' => $this->_helper->service('article.link')->getLink($article),
                'topics' => $this->getTopics($article),
                'comment_count' => $this->getCommentsCount($article),
                'recommended_comment_count' => $this->getCommentsCount($article, true),
                'comment_url' => $this->url . '/api/comments/list?article_id=' . $article->getId() . '&client=' . $this->client['name'] . '&version=' . self::API_VERSION,
                'rank' => $rank++,
            );

            if ($this->client['type'] == 'iphone') {
                unset($response['teaser']);
            }

            $this->response[] = $response;
        }

        $this->_helper->json($this->response);
    }

    /**
     * Send article info
     */
    public function itemAction()
    {
        $this->getHelper('contextSwitch')->addActionContext('item', 'json')->initContext();

        $id = $this->request->getParam('article_id');
        if (is_null($id)) {
            print Zend_Json::encode($this->response);
            return;
        }

        $article = $this->articleService->find($this->language, $this->request->getParam('article_id'));
        if (empty($article)) {
            return $this->_helper->json($response);
        }

        $articleData = new ArticleData($article->getType(), $article->getId(), self::LANGUAGE);
        if ($this->request->getParam('side') == 'back') {
            $data = $this->getBackside($article, $articleData);
            $template = 'article-backside.phtml';
        } else {
            $data = $this->getFrontside($article, $articleData);
            $template = 'article.phtml';
        }

        $smarty = CampTemplate::singleton();
        $smarty->setTemplateDir('/var/www/tw-reloaded/application/modules/api/views');
        $smarty->assign('data', $data);
        $smarty->display('scripts/articles/' . $template);
    }

    private function getBackside(Article $article, \ArticleData $adata)
    {
        $webcode = Manager::getWebcoder('')->encode($article->getId());
        $topics = ArticleTopic::GetArticleTopics($article->getId());
        $attachments = ArticleAttachment::GetAttachmentsByArticleNumber($article->getId(), self::LANGUAGE);
        try {
            $history = $adata->getFieldValue('history');
        } catch (\InvalidPropertyException $e) {
            $history = '';
        }

        try {
            $sources = $adata->getFieldValue('sources');
        } catch (\InvalidPropertyException $e) {
            $sources = '';
        }

        $authors = array();
        $aauthors = ArticleAuthor::GetAuthorsByArticle($article->getId(), self::LANGUAGE);
        foreach ($aauthors as $author) {
            $user = Zend_Registry::get('container')->getService('user')->findByAuthor($author->getId());
            $authors[] = array('user' => $user, 'author' => $author);
        }

        //$comments = Zend_Registry::get('container')->getService('comment')->findUserComments($params, $order, $p_limit, $p_start)

        $data = array(
            'title' => $article->getTitle(),
            'publish_date' => $article->getPublishDate(),
            'last_update' => $article->getDate(),
            'topics' => $topics,
            'history' => $history,
            'attachments' => $attachments,
            'sources' => $sources,
            'base_url' => $this->url,
            'webcode' => $webcode,
            'authors' => $authors,
        );

        return $data;
    }

    private function getFrontside(Article $article, \ArticleData $adata)
    {
        $image = $this->getImageUrl($article, self::IMAGE_STANDARD_RENDITION, $this->client['image_width'], $this->client['image_height']);

        $comments = Zend_Registry::get('container')->getService('comment')->countBy(array(
            'language' => $this->language->getId(),
            'thread' => $article->getId(),
        ));

        $teaserField = 'teaser';
        $bodyField = 'body';
        if ($article->getType() == 'newswire') {
            $teaserField = 'DataLead';
            $bodyField = 'DataContent';
        }

        $data = array(
            'article_id' => $article->getId(),
            'title' => $article->getTitle(),
            'dateline' => $adata->getFieldValue('dateline'),
            'publish_date' => $article->getPublishDate(),
            'last_modified' => $article->getDate(),
            'teaser' => $adata->getFieldValue($teaserField),
            'body' => $adata->getFieldValue($bodyField),
            'image_url' => $image,
            'comment_count' => $comments,
        );

        return $data;
    }

    private function getImageUrl(Article $article, $rendition, $width, $height)
    {
        $image = $this->getImage($article, $rendition);
        if (empty($image)) {
            return null;
        }

        $imageUrl = $this->view->url(array(
            'src' => $this->getHelper('service')->getService('image')->getSrc(basename($image->src), $width, $height, 'crop'),
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

    private function getTopics(Article $article)
    {
        $topics = array();
        $topicList = ArticleTopic::GetArticleTopics($article->getNumber());
        foreach ($topicList as $topic) {
            $topics[] = array(
                'topic_id' => (int) $topic->getTopicId(),
                'topic_name' => $topic->getName(self::LANGUAGE),
            );
        }

        return empty($topics) ? null : $topics;
    }

    private function getCommentsCount(Article $article, $recommended = false)
    {
        $constraints = array('language' => $this->language->getId(), 'thread' => $article->getId());
        if ($recommended == true) {
            $constraints['recommended'] = 1;
        }

        return Zend_Registry::get('container')->getService('comment')->countBy($constraints);
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
