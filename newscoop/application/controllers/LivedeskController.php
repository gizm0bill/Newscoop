<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

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

    /**
     * @todo: remove action
     */
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
            $posts = array(array(
                'Content' => 'New post ' . sha1(uniqid()),
                'PublishedOn' => date_create()->format(DateTime::W3C),
                'Id' => mt_rand(0, 21),
                'Creator' => array(
                    'Name' => 'Petr',
                ),
            ));
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
