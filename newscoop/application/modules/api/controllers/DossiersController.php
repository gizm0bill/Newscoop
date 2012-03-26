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
    const PUBLICATION = 5;
    const LANGUAGE = 5;
    
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
     * Return list of dossiers.
     *
     * @return json
     */
    public function listAction()
    {
        $this->getHelper('contextSwitch')->addActionContext('list', 'json')->initContext();
        
        $articles = $this->_helper->service('article')->findBy(array('type' => 'dossier'));
        
        $response = array();
        
        foreach ($articles as $article) {
            $articleData = new ArticleData('dossier', $article->getNumber(), self::LANGUAGE);
            $articleImages = ArticleImage::GetImagesByArticleNumber($article->getNumber());
            if ($articleImages[0]) {
                $imageUrl = $articleImages[0]->getImage()->getImageUrl();
            }
            else {
                $imageUrl = '';
            }
            $response[] = array(
                'id' => $article->getNumber(),
                'url' => $this->url.'/api/dossiers/articles?dossier_id='.$article->getNumber(),
                'title' => $article->getTitle(),
                'teaser' => $articleData->getFieldValue('lede'),
                'image_url' => $imageUrl
            );
        }
        
        $this->_helper->json($response);
    }
    
    /**
     * Return list of articles in given dossier.
     *
     * @return json
     */
    public function articlesAction()
    {
        $this->getHelper('contextSwitch')->addActionContext('articles', 'json')->initContext();
        
        $response = array();
        $parameters = $this->request->getParams();
        
        if ($parameters['dossier_id']) {
            $dossierId = $parameters['dossier_id'];
        }
        else {
            $articles = $this->_helper->service('article')->findBy(array('type' => 'dossier'), array('published' => 'desc'));
            $dossierId = $articles[0]->getNumber();
        }
        
        $dossier = $this->_helper->service('article')->findBy(array('number' => $dossierId, 'language' => self::LANGUAGE));
        var_dump($dossier);die;
        
        $this->_helper->json($response);
    }
}
