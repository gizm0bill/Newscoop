<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

use Doctrine\Common\Cache\ArrayCache as Cache;
use Guzzle\Http\Client;
use Guzzle\Common\Cache\DoctrineCacheAdapter;
use Guzzle\Http\Plugin\CachePlugin;

/**
 */
class LivedeskController extends Zend_Controller_Action
{
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
            $blog = $client->get('/resources/LiveDesk/Blog/{id}')->send();
            $posts = $client->get('/resources/LiveDesk/Blog/{id}/BlogPost/Published', array(
                'X-Filter' => 'Content, PublishedOn, Creator.Name',
            ))->send();
        } catch (Guzzle\Http\Exception\BadResponseException $e) {
            echo 'Error!', ' ' , $e->getMessage();
        }

        $this->view->blog = json_decode($blog->getBody(TRUE));
        $this->view->posts = $posts->getBody(TRUE);
    }

    public function updateAction()
    {
        $client = $this->getClient(1);
        $posts = $client->get('/resources/LiveDesk/Blog/{id}/BlogPost/Published', array(
            'X-Filter' => 'Content, PublishedOn, Creator.Name',
        ))->send();

        $this->_helper->json(json_decode($posts->getBody(TRUE)));
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
        $cache = new CachePlugin($adapter, true);
        $client->getEventDispatcher()->addSubscriber($cache);

        return $client;
    }
}
