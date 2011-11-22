<?php
/**
 * @package Newscoop
 * @copyright 2011 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

/**
 * Comments controller
 */

use Newscoop\Entity\Comment;
use Newscoop\Entity\CommentRating;

require_once($GLOBALS['g_campsiteDir'].'/include/captcha/php-captcha.inc.php');
require_once($GLOBALS['g_campsiteDir'].'/include/get_ip.php');

class CommentController extends Zend_Controller_Action
{
    public function init()
    {
		$this->getHelper('contextSwitch')->addActionContext('save', 'json')->initContext();
		$this->getHelper('contextSwitch')->addActionContext('rate', 'json')->initContext();
    }

    public function saveAction()
    {
		global $_SERVER;

		$this->_helper->layout->disableLayout();
		$parameters = $this->getRequest()->getParams();
        
        $errors = array();

		$auth = Zend_Auth::getInstance();

		$article = new Article($parameters['f_language'], $parameters['f_article_number']);
		$publication = new Publication($article->getPublicationId());

		if ($auth->getIdentity()) {
			$acceptanceRepository = $this->getHelper('entity')->getRepository('Newscoop\Entity\Comment\Acceptance');
			$user = new User($auth->getIdentity());

			$userIp = getIp();
			if ($acceptanceRepository->checkParamsBanned($user->m_data['Name'], $user->m_data['EMail'], $userIp, $article->getPublicationId())) {
				$errors[] = $this->view->translate('You have been banned from writing comments.');
			}
		}
		else {
			$errors[] = $this->view->translate('You are not logged in.');
		}

		if (!array_key_exists('f_comment_subject', $parameters) || empty($parameters['f_comment_subject'])) {
			//$errors[] = getGS('The comment subject was not filled in.');
			$errors[] = $this->view->translate('The comment subject was not filled in.');
		}
		if (!array_key_exists('f_comment_content', $parameters) || empty($parameters['f_comment_content'])) {
			$errors[] = $this->view->translate('The comment content was not filled in.');
		}

		if (empty($errors)) {
			$commentRepository = $this->getHelper('entity')->getRepository('Newscoop\Entity\Comment');
			$comment = new Comment();

			$values = array(
				'user' => $auth->getIdentity(),
				'name' => $parameters['f_comment_nickname'],
				'subject' => $parameters['f_comment_subject'],
				'message' => $parameters['f_comment_content'],
				'language' => $parameters['f_language'],
				'thread' => $parameters['f_article_number'],
				'ip' => $_SERVER['REMOTE_ADDR'],
				'status' => 'approved',
				'time_created' => new DateTime(),
                'recommended' => '0'
			);

			$commentRepository->save($comment, $values);
            $commentRepository->flush();
            
            $this->view->response = 'OK';
		}
		else {
			$errors = implode('<br>', $errors);
			$errors = $this->view->translate('Following errors have been found:') . '<br>' . $errors;
			$this->view->response = $errors;
		}
        
        $this->getHelper('contextSwitch')->addActionContext('save', 'json')->initContext();
    }
    
    public function rateAction()
    {
		$auth = Zend_Auth::getInstance();
        $this->getHelper('viewRenderer')->setNoRender();
        
        if ($auth->getIdentity()) {
            $commentRatingRepository = $this->getHelper('entity')->getRepository('Newscoop\Entity\CommentRating');
            
            $comment = $this->_getParam('comment');
            $rating = $this->_getParam('rating');
            
            if ($rating == 'like') {
                $rating = 1;
            } else {
                $rating = -1;
            }
            
            $commentRating = new CommentRating();
            
            $values = array(
                'comment' => $comment,
                'user' => $auth->getIdentity(),
                'rating' => $rating
            );
            
            $commentRatingRepository->save($commentRating, $values);
            
            $likes = count($this->_helper->service('comment')->getLikes($comment));
            $dislikes = count($this->_helper->service('comment')->getDislikes($comment));
            
            $this->view->status = 200;
            $this->view->result = "1";
            $this->view->likes = $likes;
            $this->view->dislikes = $dislikes;
        }
        else {
            $this->view->status = 401;
            $this->view->result = "0";
        }
                
        $this->getHelper('contextSwitch')->addActionContext('rate', 'json')->initContext();
	}

    public function indexAction()
    {
		$this->view->param = $this->_getParam('switch');
	}
}
