<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

use Newscoop\Entity\Article;

/**
 */
class Api_ArticlesController extends Zend_Controller_Action
{
    const LANGUAGE = 5;
    const ARTICLE_RENDITION = 'topfront';
    const LIST_URI_PATH = 'api/articles/list';
    const ITEM_URI_PATH = 'api/articles/item';

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
        $this->language = $this->_helper->entity->getRepository('Newscoop\Entity\Language')
            ->findOneBy(array('id' => self::LANGUAGE));
        $this->articleService = $this->_helper->service('article');
        $this->url = $Campsite['WEBSITE_URL'];
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

        $start = isset($params['start']) ? (int) $params['start'] : 0;
        $offset = isset($params['offset']) ? (int) $params['offset'] : 0;

        if (!empty($params['section_id'])) {
            $playlist = $this->_helper->entity->getRepository('Newscoop\Entity\Playlist')
                ->find($params['section_id']);
            $articles = $this->_helper->entity->getRepository('Newscoop\Entity\Playlist')
                ->articles($playlist);
        } else {
            if (!empty($params['type'])) {
                $criteria[] = new ComparisonOperation('type', new Operator('is'), (string) $params['type']);
            }
            /*
            if (!empty($params['section_id'])) {
                $criteria[] = new ComparisonOperation('nrsection', new Operator('is'), (int) $params['section_id']);
            }
            */
            if (!empty($params['topic_id'])) {
                /** @todo */
                $criteria[] = new ComparisonOperation('topic', new Operator('is'), $params['topic_id']);
            }

            $articles = \Article::GetList($criteria, null, $start, $offset, $count = 0, false, false);
        }

        $rank = 1;
        foreach ($articles as $item) {
            $articleNumber = isset($playlist) ? $item['articleId'] : $item['number'];
            $article = $this->articleService->find($this->language, $articleNumber);
            $image = $this->getImage($article);
            $imageUrl = !empty($image) ? $image->src : null;

            $comments = Zend_Registry::get('container')->getService('comment')->countBy(array(
                'language' => $this->language->getId(),
                'thread' => $article->getId(),
            ));

            $recommended = Zend_Registry::get('container')->getService('comment')->countBy(array(
                'language' => $article->getLanguageId(),
                'thread' => $article->getId(),
                'recommended' => 1,
            ));

            $articleData = new ArticleData($article->getType(), $article->getId(), self::LANGUAGE);
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

            $this->response[] = array(
                'article_id' => $article->getId(),
                'url' => $this->url . '/' . self::ITEM_URI_PATH . '?article_id=' . $article->getId(),
                'title' => $article->getTitle(),
                'dateline' => $articleData->getFieldValue($datelineField),
                'short_name' => $articleData->getFieldValue('short_name'),
                'teaser' => $articleData->getFieldValue($teaserField),
                'image_url' => $imageUrl,
                'website_url' => $this->_helper->service('article.link')->getLink($article),
                'topics' => $topics,
                'comment_count' => $comments,
                'recommended_comment_count' => $recommended,
                'comment_url' => $this->url . '/api/comments/list?article_id' . $article->getId(),
                'rank' => $rank++,
            );
        }

        print Zend_Json::encode($this->response);
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
            // @todo process backside template
        } else {
            // @todo process frontside template
        }

        $image = $this->getImage($article);
        $imageUrl = !empty($image) ? 'http://tw-reloaded.lab.sourcefabric.org/images/cache/' . $image->src : null;

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

        $this->response = array(
            'article_id' => $article->getId(),
            'title' => $article->getTitle(),
            'dateline' => $articleData->getFieldValue('dateline'),
            'publish_date' => $article->getPublishDate(),
            'last_modified' => $article->getDate(),
            'teaser' => $articleData->getFieldValue($teaserField),
            'body' => $articleData->getFieldValue($bodyField),
            'image_url' => $imageUrl,
            'comment_count' => $comments,
        );

        $smarty = CampTemplate::singleton();
        $smarty->setTemplateDir('/var/www/tw-reloaded/application/modules/api/views');
        $smarty->assign('data', $this->response);
        $smarty->display('scripts/articles/article.phtml');
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
