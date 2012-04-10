<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

/**
 */
class Api_CommentsController extends Zend_Controller_Action
{
    /** @var Zend_Controller_Request_Http */
    private $request;

    /** @var array */
    private $response = array();

    /** @var Newscoop\Services\CommentService */
    private $service;

    /**
     *
     */
    public function init()
    {
        $this->_helper->layout->disableLayout();
        $this->request = $this->getRequest();
        $this->service = $this->_helper->service('comment');
    }

    /**
     */
    public function indexAction()
    {
        $this->_forward('list');
    }

    /**
     */
    public function listAction()
    {
        $this->getHelper('contextSwitch')->addActionContext('list', 'json')->initContext();

        $id = $this->request->getParam('article_id');
        if (is_null($id)) {
            print Zend_Json::encode($this->response);
            return;
        }

        $comments = $this->service->findBy(array('thread' => $id));
        if (empty($comments)) {
            print Zend_Json::encode($this->response);
            return;
        }

        foreach($comments as $comment) {
            $this->response[] = array(
                'author_name' => $comment->getCommenterName(),
                'author_id' => $comment->getCommenter()->getLoginName(),
                'subject' => $comment->getSubject(),
                'message'=> $comment->getMessage(),
                'recommended' => $comment->getRecommended(),
                'created_time' => $comment->getTimeCreated(),
                'last_modified' => $comment->getTimeUpdated()
            );
        }

        print Zend_Json::encode($this->response);
    }
}
