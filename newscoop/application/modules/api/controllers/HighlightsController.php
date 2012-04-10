<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

/**
 */
class Api_HighlightsController extends Zend_Controller_Action
{
    const PUBLICATION = 1;
    
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
     * Return list of articles.
     *
     * @return json
     */
    public function listAction()
    {
        $this->getHelper('contextSwitch')->addActionContext('list', 'json')->initContext();
        $response = array();
        
        $parameters = $this->request->getParams();
        
        if ($parameters['section_id']) {
            $sectionIdList = array($parameters['section_id']);
        }
        else {
            $sectionIdList = array(10, 20, 30, 40, 50);
        }
        
        foreach ($sectionIdList as $sectionId) {
            $sections = $this->_helper->service('section')->findBy(array('publication' => self::PUBLICATION, 'number' => $sectionId));
            $section = $sections[0];
            
            $response[$sectionId] = array();
            
            $playlistRepository = $this->_helper->entity->getRepository('Newscoop\Entity\Playlist');
            $playlists = $playlistRepository->findBy(array('name' => $section->getName()));
            $playlist = $playlists[0];
            if ($playlist) {
                $articleArray = $playlistRepository->articles($playlist);
                foreach ($articleArray as $articleItem) {
                    $articles = $this->_helper->service('article')->findBy(array('number' => $articleItem['articleId']));
                    $article = $articles[0];
                    $response[$sectionId][] = array('id' => $article->getNumber(), 'title' => $article->getTitle(), 'section_url' => $this->url.'/api/sections/item?section_id='.$sectionId);
                }
            }
        }
        
        $this->_helper->json($response);
    }
}
