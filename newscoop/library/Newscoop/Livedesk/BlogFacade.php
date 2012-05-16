<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

namespace Newscoop\Livedesk;

use Guzzle\Http\Client,
    Guzzle\Http\Message\Response;

/**
 * Blog facade
 */
class BlogFacade
{
    const BLOG_PATH = '/resources/LiveDesk/Blog/{id}';
    const POSTS_PATH = '/resources/LiveDesk/Blog/{id}/BlogPost/Published';
    const POSTS_UPDATE_PATH = '/resources/LiveDesk/Blog/{id}/BlogPost/Published'; //?ModifiedAfter={lastmod}';

    /**
     * @var array
     */
    private $postsHeaders = array(
        'X-Filter' => 'Id, Content, PublishedOn, UpdatedOn, Creator.Name',
    );

    /**
     * @var Guzzle\Http\Client
     */
    private $client;

    /**
     * @var array
     */
    private $blogs = array();

    /**
     * @param Guzzle\Http\Client $client
     */
    public function __construct(Client $client)
    {
        $this->client = $client;
    }

    /**
     * Find blog by given id
     *
     * @param int $id
     * @return object
     */
    public function find($id)
    {
        if (!empty($id) && isset($this->blogs[$id])) {
            return $this->blogs[$id];
        }

        try {
            $this->setClientId($id);
            list($blogResponse, $postsResponse) = $this->client->send(array(
                $this->client->get(self::BLOG_PATH),
                $this->client->get(self::POSTS_PATH, $this->postsHeaders),
            ));

            $blog = $this->getBlog($blogResponse);
            $blog->posts = $this->getPosts($postsResponse);
            $this->blogs[$id] = $blog;
            return $blog;
        } catch (\Exception $e) {
            $this->handleException($e);
            return NULL;
        }
    }

    /**
     * Find posts changed after last modified
     *
     * @param int $id
     * @param DateTime $lastModified
     * @return array
     */
    public function findPostsAfter(\DateTime $lastModified, $id)
    {
        try {
            $this->setClientId($id);
            $response = $this->client->get(array(
                self::POSTS_UPDATE_PATH, array(
                    'lastmod' => $lastModified->format(\DateTime::W3C),
                ),
            ), $this->postsHeaders)->send();
            return $this->getPosts($response);
        } catch (\Exception $e) {
            $this->handleException($e);
            return NULL;
        }
    }

    /**
     * Set client id
     *
     * @param int $id
     * @return void
     */
    private function setClientId($id)
    {
        if (empty($id) || !is_numeric($id)) {
            throw new \InvalidArgumentException("Id '$id' is not a valid id.");
        }

        $this->client->setConfig(array(
            'id' => (int) $id,
        ));
    }

    /**
     * Handle exception
     *
     * @param Exception $e
     * @return void
     */
    private function handleException(\Exception $e)
    {
        if (APPLICATION_ENV === 'development') {
            echo 'Error:', ' ' , $e->getMessage();
        }
    }

    /**
     * Get posts from response
     *
     * @param Guzzle\Http\Message\Response $response
     * @return array
     */
    private function getPosts(Response $response)
    {
        return (array) json_decode($response->getBody(TRUE))->BlogPostList;
    }

    /**
     * Get blog from response
     *
     * @param Guzzle\Http\Message\Response $response
     * @return object
     */
    private function getBlog(Response $response)
    {
        return (object) array_change_key_case(json_decode($response->getBody(TRUE), TRUE));
    }
}
