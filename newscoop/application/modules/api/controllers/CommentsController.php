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
        global $Campsite;

        $this->_helper->layout->disableLayout();
        $this->request = $this->getRequest();
        $this->service = $this->_helper->service('comment');
        $this->url = $Campsite['WEBSITE_URL'];
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
            $comments = $this->service->findBy(
                array('status' => 0),
                array('time_created' => 'desc'),
                20);
        } else {
            $comments = $this->service->findBy(
                array('article_num' => $id, 'status' => 0),
                array('time_created' => 'desc'));
        }

        if (empty($comments)) {
            $this->_helper->json($response);
            return;
        }

        $rank = 1;
        foreach($comments as $comment) {
            $created_time = $comment->getTimeCreated()->format('Y-m-d H:i:s');
            $last_modified = $created_time;
            if ($comment->getTimeUpdated()->getTimestamp() !== false && $comment->getTimeCreated()->getTimestamp() < $comment->getTimeUpdated()->getTimestamp()) {
                $last_modified = $comment->getTimeUpdated()->format('Y-m-d H:i:s');
            }

            $profile_image = $comment->getCommenter()->getUser()->getImage();
            if (!empty($profile_image)) {
                $profile_image = $this->view->url(array(
                    'src' => $this->getHelper('service')->getService('image')->getSrc('images/' . $profile_image, 125, 125, 'fit'),
                ), 'image', false, false);
                $profile_image = $this->url . $profile_image;
            } else {
                $profile_image = null;
            }

            $this->response[] = array(
                'author_name' => $comment->getCommenterName(),
                'author_id' => $comment->getCommenter()->getLoginName(),
                'author_image_url' => $profile_image,
                'subject' => $comment->getSubject(),
                'message'=> $comment->getMessage(),
                'recommended' => $comment->getRecommended(),
                'created_time' => $created_time,
                'last_modified' => $last_modified,
                'rank' => $rank++,
            );
        }

        $this->_helper->json($this->response);
    }
    
    /**
     */
    public function composeAction()
    {
        $this->getHelper('contextSwitch')->addActionContext('list', 'json')->initContext();

        $response = array();
        
        $parameters = $this->getRequest()->getPost();
        var_dump($parameters);
        die;
    }
}
