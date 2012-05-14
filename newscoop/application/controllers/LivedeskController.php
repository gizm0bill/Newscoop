<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

use Doctrine\Common\Cache\ApcCache as Cache;
use Guzzle\Http\Client;
use Guzzle\Common\Cache\DoctrineCacheAdapter;
use Guzzle\Http\Plugin\CachePlugin;

/**
 */
class LivedeskController extends Zend_Controller_Action
{
    const IF_MODIFIED_SINCE_HEADER = 'If-Modified-Since';
    const BLOG_POSTS_PATH = '/resources/LiveDesk/Blog/{id}/BlogPost/Published';
    const BLOG_INFO_PATH = '/resources/LiveDesk/Blog/{id}';
    const RFC1123_DATE = 'D, d M Y H:i:s \G\M\T';

    public function init()
    {
        $this->_helper->contextSwitch
            ->addActionContext('update', 'json')
            ->initContext();
    }

    public function indexAction()
    {
        try {
            $client = $this->getClient(1);
            list($blog, $posts) = $client->send(array(
                $client->get(self::BLOG_INFO_PATH),
                $client->get(self::BLOG_POSTS_PATH, $this->getPostsHeaders()),
            ));

            $this->view->blog = json_decode($blog->getBody(TRUE));
            $this->view->posts = $posts->getBody(TRUE);
        } catch (Guzzle\Http\Exception\BadResponseException $e) {
            $this->getResponse()->setHttpResponseCode(500);
            echo 'Error!', ' ' , $e->getMessage();
        }
    }

    public function updateAction()
    {
        $this->_helper->viewRenderer->setNoRender();
        try {
            $client = $this->getClient(1);
            $posts = $client->get(self::BLOG_POSTS_PATH, $this->getPostsHeaders())->send();
            if (!$this->isUpdated($posts)) {
                $this->getResponse()->setHttpResponseCode(304);
                $this->getResponse()->clearBody();
                $this->getResponse()->sendResponse();
            } else {
                $this->_helper->json(json_decode($posts->getBody(TRUE)));
            }
        } catch (Exception $e) {
            $this->getResponse()->setHttpResponseCode(500);
            $this->_helper->json(array(
                'errorMessage' => $e->getMessage(),
            ));
        }
    }

    /**
     * Get configured http client
     *
     * @param int $id
     * @return Guzzle\Http\Client
     */
    private function getClient($id)
    {
        $client = new Client('http://localhost:8080/', array(
            'id' => (int) $id,
        ));

        $adapter = new DoctrineCacheAdapter(new Cache());
        $cache = new CachePlugin($adapter, TRUE);
        $client->getEventDispatcher()->addSubscriber($cache);

        return $client;
    }

    /**
     * Get headers for posts request
     *
     * @return array
     */
    private function getPostsHeaders()
    {
        return array_filter(array(
            'X-Filter' => 'Content, PublishedOn, Creator.Name',
            self::IF_MODIFIED_SINCE_HEADER => $this->getIfModifiedSinceHeader(),
        ));
    }

    /**
     * Test if posts are updated after last mod header
     *
     * @return bool
     */
    private function isUpdated($posts)
    {
        if (!$this->getIfModifiedSinceHeader()) {
            return TRUE;
        }

        $items = json_decode($posts->getBody(TRUE))->BlogPostList;
        if (empty($items)) {
            return FALSE;
        }

        $now = new DateTime($this->getIfModifiedSinceHeader());
        $lastPublished = new DateTime($items[0]->PublishedOn);
        return $now->getTimestamp() <= $lastPublished->getTimestamp();
    }

    /**
     * Get If-Modified-Since header
     *
     * @return string
     */
    private function getIfModifiedSinceHeader()
    {
        return $this->getRequest()->getHeader(self::IF_MODIFIED_SINCE_HEADER) ? $this->getRequest()->getHeader(self::IF_MODIFIED_SINCE_HEADER) : null;
    }
}
