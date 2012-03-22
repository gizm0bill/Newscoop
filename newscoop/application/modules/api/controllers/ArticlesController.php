<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

/**
 */
class Api_ArticlesController extends Zend_Controller_Action
{
    /** @var Zend_Controller_Request_Http */
    private $request;


    /**
     * Init controller.
     */
    public function init()
    {
        $this->_helper->layout->disableLayout();
        $this->request = $this->getRequest();
        $this->service = $this->_helper->service('article');
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
        /** @todo */
        $section = $this->request->getParam('section');
    }

    /**
     * Send article info.
     */
    public function itemAction()
    {
        $id = $this->request->getParam('id');
        $article = $this->service->findArticle($id);
        $response = array(
            'title' => $article->getTitle(),
            'publish_date' => $article->getPublishDate(),
            'last_modified' => $article->getDate(),
        );

        $this->_helper->json($response); exit;
        var_dump(Zend_Json::prettyPrint(Zend_Json::encode($response)));
    }
}
