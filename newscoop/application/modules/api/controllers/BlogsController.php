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
                    'id' => $section->getNumber(),
                    'url' => $this->url.'/api/blogs/posts?blog_id='.$section->getNumber(),
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
        $response = array();
        
        $sections = $this->_helper->service('section')->findBy(array('publication' => self::PUBLICATION, 'number' => $blogId));
        if ($sections[0]) {
            $section = $sections[0];
            $posts = $this->_helper->service('article')->findBy(array('section' => $section->getNumber(), 'type' => 'blog'), array('published' => 'desc'));
            
            foreach ($posts as $post) {
                $postData = new ArticleData('blog', $post->getNumber(), self::LANGUAGE);
                $postImages = ArticleImage::GetImagesByArticleNumber($post->getNumber());
                if ($postImages[0]) {
                    $imageUrl = $postImages[0]->getImage()->getImageUrl();
                }
                else {
                    $imageUrl = '';
                }
                $response[] = array( // add url
                    'url' => $this->url.'/api/blogs/posts?post_id='.$post->getNumber(),
                    'id' => $post->getNumber(),
                    'title' => $post->getTitle(),
                    'short_name' => $postData->getFieldValue('short_name'),
                    'lede' => $postData->getFieldValue('lede'),
                    'image_url' => $imageUrl,
                    'last_modified' => $post->getPublishDate()
                );
            }
        }
                        
        $this->_helper->json($response);
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
        $response = array();
        
        $posts = $this->_helper->service('article')->findBy(array('number' => $postId, 'type' => 'blog'));
        if ($posts[0]) {
            $post = $posts[0];
            $postData = new ArticleData('blog', $post->getNumber(), self::LANGUAGE);
            $postImages = ArticleImage::GetImagesByArticleNumber($post->getNumber());
            if ($postImages[0]) {
                $imageUrl = $postImages[0]->getImage()->getImageUrl();
            }
            else {
                $imageUrl = '';
            }
            
            $response = array(
                'title' => $post->getTitle(),
                'short_name' => $postData->getFieldValue('short_name'),
                'lede' => $postData->getFieldValue('lede'),
                'vimeo_url' => $postData->getFieldValue('vimeo_url'),
                'youtube_shortcode' => $postData->getFieldValue('youtube_shortcode'),
                'body' => $postData->getFieldValue('body'),
                'image_url' => $imageUrl,
                'last_modified' => $post->getPublishDate()
            );
        }
        
        $this->_helper->json($response);
    }
}
