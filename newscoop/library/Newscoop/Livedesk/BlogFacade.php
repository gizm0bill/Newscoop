<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

namespace Newscoop\Livedesk;

/**
 * Blog facade
 */
class BlogFacade
{
    const BLOG_PATH = '/resources/LiveDesk/Blog/{id}';
    const POSTS_PATH = '/resources/LiveDesk/Blog/{id}/BlogPost/Published';
    const POSTS_UPDATE_PATH = '/resources/LiveDesk/Blog/{id}/BlogPost/Published'; //?Modified={lastmod}';

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
    public function __construct(\Guzzle\Http\Client $client)
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
        try {
            $this->setClientId($id);
            list($blogResponse, $postsResponse) = $this->client->send(array(
                $this->client->get(self::BLOG_PATH),
                $this->client->get(self::POSTS_PATH, $this->postsHeaders),
            ));

            $blog = array_change_key_case(json_decode($blogResponse->getBody(TRUE), TRUE));
            $blog['posts'] = array_pop(json_decode($postsResponse->getBody(TRUE), TRUE));
            return $this->blogs[$id] = (object) $blog;
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
            $response = $this->client->get(array(self::POSTS_UPDATE_PATH, array(
                'lastmod' => $lastModified->format(\DateTime::W3C),
            )), $this->postsHeaders)->send();
            return json_decode($response->getBody(TRUE))->BlogPostList;
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
}
