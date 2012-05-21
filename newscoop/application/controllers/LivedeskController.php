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
        if (!is_numeric($this->_getParam('id'))) {
            throw new InvalidArgumentException("Parameter 'id' is not a valid identifier.");
        }

        if (!is_numeric($this->_getParam('cid'))) {
            throw new InvalidArgumentException("Parameter 'cid' is not a valid identifier.");
        }

        try {
            $posts = $this->_helper->service('livedesk.blog')->findPostsAfter($this->_getParam('id'), $this->_getParam('cid'));
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
