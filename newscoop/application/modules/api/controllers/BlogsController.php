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
        
        $sections = $this->_helper->service('section')->findBy(array('publication' => self::PUBLICATION));
        //$sections = $this->_helper->service('section')->findBy(array('publication' => self::PUBLICATION, 'language' => self::LANGUAGE));
        //$sections = $this->_helper->service('section')->findBy(array('publication' => self::PUBLICATION, 'issue' => self::ISSUE, 'language' => self::LANGUAGE));
        
        $publication = new Publication(self::PUBLICATION);
        $alias = new Alias($publication->getDefaultAliasId());
        
        $rank = 1;
        foreach ($sections as $section) {
            $articles = $this->_helper->service('article')->findBy(array('section' => $section->getNumber(), 'type' => 'bloginfo'));
            if ($articles[0]) {
                $blogInfo = new ArticleData('bloginfo', $articles[0]->getNumber(), self::LANGUAGE);
                $posts = $this->_helper->service('article')->findBy(array('section' => $section->getNumber(), 'type' => 'blog'), array('published' => 'desc'));
                $lastModified = '0000-00-00 00:00:00';
                $articleImages = ArticleImage::GetImagesByArticleNumber($articles[0]->getNumber());
                $imageUrl = $articleImages[0]->getImage()->getImageUrl();
                
                if ($posts[0]) {
                    $lastModified = $posts[0]->getPublishDate();
                    $authors = $posts[0]->getAuthors();
                    
                    $authorList = array();
                    foreach ($authors as $author) {
                        $authorList[] = $author->getfullName();
                    }
                    
                    $authorNames = implode(', ', $authorList);
                }
                
                $response[] = array(
                    'url' => $alias->getName().'/de/blogs/'.$section->getName().'/',
                    'short_name' => $blogInfo->getFieldValue('short_name'),
                    'motto' => $blogInfo->getFieldValue('motto'),
                    'rank' => $rank,
                    'image_url' => $imageUrl,
                    'author_names' => $authorNames,
                    'last_modified' => $lastModified
                );
                
                $rank = $rank + 1;
            }
        }
        
        //die;
        
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
        $parameters = $this->request->getParams();
        $blogId = $parameters['blog_id'];
        
        
        
        echo('list');die;
    }
    
    /**
     * Return post.
     *
     * @return json
     */
    public function postsItemAction()
    {
        $parameters = $this->request->getParams();
        $postId = $parameters['post_id'];
        
        
        
        echo('item');die;
    }
}
