<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

/**
 */
class Api_DebatesController extends Zend_Controller_Action
{
    const PUBLICATION = 2;
    const LANGUAGE = 5;
    const SECTION = 81;
    
    /** @var Zend_Controller_Request_Http */
    private $request;
    
    private $url;

    /**
     * Init controller.
     */
    public function init()
    {
        global $Campsite;
        
        $this->_helper->layout->disableLayout();
        $this->request = $this->getRequest();
        $this->url = $Campsite['WEBSITE_URL'];
    }

    /**
     * Default action controller.
     */
    public function indexAction()
    {
        $this->_forward('list');
    }

    /**
     * Return list of debates.
     *
     * @return json
     */
    public function listAction()
    {
        $this->getHelper('contextSwitch')->addActionContext('list', 'json')->initContext();
        $response = array();
        
        $articles = $this->_helper->service('article')->findBy(array('type' => 'deb_moderator', 'publication' => self::PUBLICATION, 'section' => self::SECTION));
        
        $rank = 1;
        foreach ($articles as $article) {
            $response[] = array(
                'id' => $article->getNumber(),
                'url' => $this->url.'/api/debates/item?debate_id='.$article->getNumber(),
                'title' => $article->getName(),
                'year' => '',
                'month' => '',
                'rank' => $rank
            );
            
            $rank = $rank + 1;
        }
        
        $this->_helper->json($response);
    }
    
    /**
     * Returns a single debate.
     *
     * @return json
     */
    public function itemAction()
    {
        $this->getHelper('contextSwitch')->addActionContext('list', 'json')->initContext();
        $response = array();
        
        $parameters = $this->request->getParams();
        
        if ($parameters['debate_id']) {
            $articles = $this->_helper->service('article')->findBy(array('number' => $parameters['debate_id']));
            $article = $articles[0];
        }
        else {
            $articles = $this->_helper->service('article')->findBy(array('type' => 'deb_moderator', 'publication' => self::PUBLICATION, 'section' => self::SECTION), array('published' => 'desc'));
            $article = $articles[0];
        }
        
        $response['id'] = $article->getNumber();
        $response['title'] = $article->getName();
        
        $proArticles = $this->_helper->service('article')->findBy(array('type' => 'deb_statement', 'publication' => self::PUBLICATION, 'section' => self::SECTION, 'name' => 'Pro', 'issueId' => $article->getIssueId()));
        $proArticle = $proArticles[0];
        $proAuthors = $proArticle->getAuthors();
        $proAuthor = $proAuthors[0];
        //$proUser = $this->_helper->service('user')->findBy(array('author' => $proAuthor->getId()));
        //var_dump($proUser);die;
        
        $response['pro'] = array(
            'author' => $proAuthor->getFullName(),
            'description' => '',
            'image_url' => '',
            'votes' => ''
        );
        
        var_dump($proAuthor->getFullName());die;
        
        $conArticles = $this->_helper->service('article')->findBy(array('type' => 'deb_statement', 'publication' => self::PUBLICATION, 'section' => self::SECTION, 'name' => 'Contra', 'issueId' => $article->getIssueId()));
        $conArticle = $conArticles[0];
        $conAuthors = $conArticle->getAuthors();
        $conAuthor = $conAuthors[0];
        
        $this->_helper->json($response);
    }
}
