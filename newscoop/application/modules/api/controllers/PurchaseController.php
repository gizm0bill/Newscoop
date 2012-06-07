<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

/**
 * Purchage API
 */
class Api_PurchaseController extends Zend_Controller_Action
{
    /** @var array */
    private $methods = array(
        'products' => 'GET',
        'validate' => 'POST',
        'free_upgrade' => 'GET',
    );

    public function init()
    {
        $this->_helper->viewRenderer->setNoRender(true);
    }

    public function preDispatch()
    {
        $action = $this->getRequest()->getActionName();
        if (!isset($this->methods[$action])) {
            $this->getResponse()->setHttpResponseCode(400);
            $this->getResponse()->clearBody();
            $this->getResponse()->sendResponse();
            exit;
        }

        if ($this->methods[$action] !== $this->getRequest()->getMethod()) {
            $this->getResponse()->setHttpResponseCode(405);
            $this->getResponse()->setHeader('Allow', $this->methods[$action]);
            $this->getResponse()->clearBody();
            $this->getResponse()->sendResponse();
            exit;
        }

        if ($this->getRequest()->getMethod() === 'POST' && !$this->getRequest()->isSecure()) {
            $this->getResponse()->setHttpResponseCode(400);
            $this->getResponse()->clearBody();
            $this->getResponse()->sendResponse();
            exit;
        }
    }

    /**
     * Get list of products
     */
    public function productsAction()
    {
        $this->_helper->json(array(
        ));
    }

    /**
     * Validate purchase
     */
    public function validateAction()
    {
        $this->_helper->json(array(
            'receipt_valid' => false,
            'production_id' => uniqid(),
        ));
    }

    /**
     * Check free upgrade status
     */
    public function freeupgradeAction()
    {
        $this->_helper->json(array(
            'status' => 'ok',
        ));
    }
}
