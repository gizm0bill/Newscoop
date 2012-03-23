<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

/**
 */
class Api_BlogsController extends Zend_Controller_Action
{
    const PUBLICATION = 5;
    const ISSUE = 3;
    const LANGUAGE = 5;
    
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
        
        $response = array();
        
        $sections = $this->_helper->service('section')->findBy(array('publication' => self::PUBLICATION, 'language' => self::LANGUAGE));
        //$sections = $this->_helper->service('section')->findBy(array('publication' => self::PUBLICATION, 'issue' => self::ISSUE, 'language' => self::LANGUAGE));
        
        foreach ($sections as $section) {
            $blogInfo = $this->_helper->service('article')->findBy(array('section' => $section->getId()));
            // tidy bloginfo or whatever...
            // $response[] = $blogInfo;
        }
        
        $this->_helper->json($response);
    }
    
    /**
     * Routes to PostsList or PostsItem
     */
    public function postsAction()
    {
        $parameters = $this->request->getParams();
        if (in_array('blog_id', array_keys($parameters))) {
            $this->_forward('posts-list');
        }
        else if (in_array('post_id', array_keys($parameters))) {
            $this->_forward('posts-item');
        }
    }
    
    /**
     * Return list of posts.
     *
     * @return json
     */
    public function postsListAction()
    {
        echo('list');die;
    }
    
    /**
     * Return post.
     *
     * @return json
     */
    public function postsItemAction()
    {
        echo('item');die;
    }
}
