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

        $response = array();

        $id = $this->request->getParam('article_id');
        if (is_null($id)) {
            $this->_helper->json($response);
            return;
        }

        $comments = $this->service->findBy(array('article_num' => $id));
        if (empty($comments)) {
            $this->_helper->json($response);
            return;
        }

        foreach($comments as $comment) {
            $created_time = $comment->getTimeCreated()->format('Y-m-d H:i:s');
            $last_modified = $created_time;
            if ($comment->getTimeUpdated()->getTimestamp() !== false && $comment->getTimeCreated()->getTimestamp() < $comment->getTimeUpdated()->getTimestamp()) {
                $last_modified = $comment->getTimeUpdated()->format('Y-m-d H:i:s');
            }

            $this->response[] = array(
                'author_name' => $comment->getCommenterName(),
                'author_id' => $comment->getCommenter()->getLoginName(),
                'subject' => $comment->getSubject(),
                'message'=> $comment->getMessage(),
                'recommended' => $comment->getRecommended(),
                'created_time' => $created_time,
                'last_modified' => $last_modified
            );
        }

        $this->_helper->json($this->response);
    }
}
