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

        $params = $this->request->getParams();
        if (isset($params['section_id'])) {
            $sectionIds = array((int) $params['section_id']);
        } else {
            $sectionIds = array(6, 7, 8, 9, 10); // @todo config
        }

        foreach ($sectionIds as $sectionId) {
            $playlistRepository = $this->_helper->entity->getRepository('Newscoop\Entity\Playlist');
            $playlist = $playlistRepository->findOneBy(array('id' => $sectionId));
            if ($playlist) {
                $articleArray = $playlistRepository->articles($playlist);
                foreach ($articleArray as $articleItem) {
                    $articles = $this->_helper->service('article')->findBy(array('number' => $articleItem['articleId']));
                    $article = $articles[0];
                    $articleData = new ArticleData($article->getType(), $article->getId(), $article->getLanguageId());
                    $comments = Zend_Registry::get('container')->getService('comment')->countBy(array(
                        'language' => $article->getLanguageId(),
                        'thread' => $article->getId(),
                    ));
                    $response[] = array(
                        'article_id' => $article->getNumber(),
                        'url' => '/articles/item?article_id=' . $article->getNumber(),
                        'title' => $article->getTitle(),
                        'section_name' => $playlist->getName(),
                        'section_url' => $this->url.'/api/sections/item?section_id=' . $sectionId,
                        'publish_date' => $article->getPublishDate(),
                        'comment_count' => $comments,
                    );
                }
            }
        }

        $this->_helper->json($response);
    }
}
