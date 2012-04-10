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
    const ARTICLE_RENDITION = 'artikel';
    const LIST_URI_PATH = 'articles/list';
    const ITEM_URI_PATH = 'articles/item';

    /** @var Zend_Controller_Request_Http */
    private $request;

    /** @var array */
    private $response = array();

    /**
     * Init controller
     */
    public function init()
    {
        $this->_helper->layout->disableLayout();
        $this->request = $this->getRequest();
        $this->language = $this->_helper->entity->getRepository('Newscoop\Entity\Language')
            ->findOneBy(array('id' => self::LANGUAGE));
        $this->articleService = $this->_helper->service('article');
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

        if (!empty($params['type'])) {
            $criteria[] = new ComparisonOperation('type', new Operator('is'), (string) $params['type']);
        }
        if (!empty($params['section_id'])) {
            $criteria[] = new ComparisonOperation('nrsection', new Operator('is'), (int) $params['section_id']);
        }
        if (!empty($params['topic_id'])) {
            /** @todo */
            $criteria[] = new ComparisonOperation('topic', new Operator('is'), $params['topic_id']);
        }

        $start = isset($params['start']) ? (int) $params['start'] : 0;
        $offset = isset($params['offset']) ? (int) $params['offset'] : 0;

        $articles = \Article::GetList($criteria, null, $start, $offset, $count = 0, false, false);
        foreach ($articles as $item) {
            $article = $this->articleService->find($this->language, $item['number']);
            $image = $this->getImage($article);
            $imageUrl = !empty($image) ? $image->src : null;

            $comments = Zend_Registry::get('container')->getService('comment')->countBy(array(
                'language' => $this->language->getId(),
                'thread' => $article->getId(),
            ));

            $this->response[] = array(
                'article_id' => $article->getId(),
                'url' => self::ITEM_URI_PATH . '?article_id=' . $article->getId(),
                'title' => $article->getTitle(),
                'publish_date' => $article->getPublishDate(),
                'image_url' => $imageUrl,
                'comment_count' => $comments,
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
        $imageUrl = !empty($image) ? $image->src : null;

        $comments = Zend_Registry::get('container')->getService('comment')->countBy(array(
            'language' => $this->language->getId(),
            'thread' => $article->getId(),
        ));

        $this->response = array(
            'article_id' => $article->getId(),
            'title' => $article->getTitle(),
            'publish_date' => $article->getPublishDate(),
            'last_modified' => $article->getDate(),
            'teaser' => $articleData->getFieldValue('teaser'),
            'body' => $articleData->getFieldValue('body'),
            'image_url' => $imageUrl,
            'comment_count' => $comments,
        );

        print Zend_Json::encode($this->response);
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
