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
    public function init()
    {
        $this->_helper->contextSwitch
            ->addActionContext('update', 'json')
            ->initContext('json');
    }

    public function indexAction()
    {
    }

    public function updateAction()
    {
        $id = $this->_getParam('id');
        $lastModified = $this->_getParam('lastmod');

        if (!is_numeric($id)) {
            throw new InvalidArgumentException("Parameter 'id' is not a valid identifier.");
        }

        if (!date_create($lastModified)) {
            throw new InvalidArgumentException("Parameter 'lastmod' is not a valid datetime.");
        }

        try {
            $lastModified = new \DateTime($lastModified);
            $posts = $this->_helper->service('livedesk.blog')->findPostsAfter($lastModified, $id);
            if (empty($posts)) {
                $this->getResponse()->setHttpResponseCode(204);
                $this->getResponse()->clearBody();
                $this->getResponse()->sendResponse();
            } else {
                $this->_helper->json($posts);
            }
        } catch (\Exception $e) {
            $this->_helper->json(array(
                'errorCode' => $e->getCode(),
                'errorMessage' => $e->getMessage(),
            ));
        }
    }
}
