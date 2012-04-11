<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

/**
 */
class Api_LegalController extends Zend_Controller_Action
{
    /** @var Zend_Controller_Request_Http */
    private $request;

    /**
     *
     */
    public function init()
    {
        $this->_helper->layout->disableLayout();
        $this->request = $this->getRequest();
    }

    /**
     */
    public function privacyAction()
    {
        $this->getHelper('contextSwitch')->addActionContext('list', 'json')->initContext();
        $this->_helper->json(array('policy' => 'privacy policy'));
    }
}
