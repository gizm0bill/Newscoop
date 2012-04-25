<?php
/**
 * @package Newscoop
 * @copyright 2011 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

class ArticleRecommendationController extends Zend_Controller_Action
{
    public function init()
    {
        
    }

    public function indexAction()
    {
        $this->view->articleNumber = $this->_getParam('article_number');
        
        $user = Zend_Registry::get('container')->getService('user')->getCurrentUser();
        if ($user) {
            $this->view->user = $user;
            $this->view->userRealName = $user->getRealName();
            $this->view->userName = $user->getUsername();
        }
    }
    
    public function sendAction()
    {
        $request = $this->getRequest();
        
        if ($request->isPost()) {
            $parameters = $request->getPost();
            $user = Zend_Registry::get('container')->getService('user')->getCurrentUser();
            
            if ($user) {
                $parameters['sender_email'] = $user->getEmail();
                $parameters['sender_name'] = $user->getRealName();
            }
            
            $articles = $this->_helper->service('article')->findBy(array('number' => $parameters['article_number']));
            $article = $articles[0];
            $link = $this->_helper->service('link')->getLink($article);
            
            $subject = 'Lesetipp: '.$article->getName();
            $body = '';
            $body = $body.$article->getName()."\r\n";
            $body = $body.$article->getData('lede')."\r\n";
            $body = $body."Lesen: <a href='".$link."'>".$link."</a>\r\n";
            $body = $body."Diese Email wurde von ".$parameters['sender_name']." via tageswoche.ch versandt.\r\n";
            
            $this->_helper->service('email')->sendUserEmail($parameters['sender_email'], $parameters['recipient_email'], $subject, $body);
        }
    }
}