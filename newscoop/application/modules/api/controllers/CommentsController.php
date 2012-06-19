<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

/**
 */

use Newscoop\Entity\Comment;

require_once($GLOBALS['g_campsiteDir'].'/include/get_ip.php');

class Api_CommentsController extends Zend_Controller_Action
{
    const LANGUAGE = 5;
    
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
        if ($this->request->isPost()) {
            $this->_forward('compose');
        } else {
            $this->_forward('list');
        }
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
                'author_image_url' => $profile_image,
                'subject' => $comment->getSubject(),
                'message'=> $comment->getMessage(),
                'recommended' => $comment->getRecommended() ? true : false,
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
        $this->getHelper('contextSwitch')->addActionContext('list', 'json')->initContext('json');

        $parameters = $this->getRequest()->getPost();
        
        /*
        $parameters = array();
        $parameters['username'] = 'admin';
        $parameters['password'] = 'admin';
        $parameters['article_id'] = 71;
        $parameters['message'] = 'zxczxczxc';
        */
        
        if (isset($parameters['username']) && isset($parameters['password'])) {
            $user = $this->_helper->service('user')->findOneBy(array('username' => $parameters['username']));
            if ($user->checkPassword($parameters['password'])) {
                if (isset($parameters['article_id']) && isset($parameters['message'])) {
                    $acceptanceRepository = $this->getHelper('entity')->getRepository('Newscoop\Entity\Comment\Acceptance');
                    $userIp = getIp();
                    
                    $article = new Article(self::LANGUAGE, $parameters['article_id']);
                    
                    if (!$acceptanceRepository->checkParamsBanned($user->getName(), $user->getEmail(), $userIp, $article->getPublicationId())) {
                        $commentRepository = $this->getHelper('entity')->getRepository('Newscoop\Entity\Comment');
                        $comment = new Comment();
                        
                        $subject = '';
                        if (isset($parameters['subject'])) {
                            $subject = $parameters['subject'];
                        }
                        
                        $values = array(
                            'user' => $user->getId(),
                            'name' => '',
                            'subject' => $subject,
                            'message' => $parameters['message'],
                            'language' => self::LANGUAGE,
                            'thread' => $parameters['article_id'],
                            'ip' => $_SERVER['REMOTE_ADDR'],
                            'status' => 'approved',
                            'time_created' => new DateTime(),
                            'recommended' => '0'
                        );
                        
                        $commentRepository->save($comment, $values);
                        $commentRepository->flush();
                        
                        //echo('comment posted');
                        $this->getResponse()->setHttpResponseCode(201);
                    }
                    else {
                        //echo('not allowed to comment');
                        $this->getResponse()->setHttpResponseCode(500);
                    }
                }
                else {
                    //echo('no article and message');
                    $this->getResponse()->setHttpResponseCode(500);
                }
            }
            else {
                //echo('username password wrong');
                $this->getResponse()->setHttpResponseCode(401);
            }
        }
        else {
            //echo('no username password');
            $this->getResponse()->setHttpResponseCode(401);
        }
        
        $this->_helper->json(array());
    }
}
