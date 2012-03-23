<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

/**
 */
class Api_DossiersController extends Zend_Controller_Action
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
        $this->getHelper('contextSwitch')->addActionContext('list', 'json')->initContext();
        
        $articles = $this->_helper->service('article')->findBy(array('type' => 'dossier'));
        
        $response = array();
        
        foreach ($articles as $article) {
            $response[] = $article->getId();
        }
        
        $this->_helper->json($response);
    }
}
