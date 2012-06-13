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
    /**
     * Get list of products
     */
    public function productsAction()
    {
        $expires = new DateTime('+300 day');
        $lastMod = new DateTime(sprintf('@%d', filemtime(__FILE__)));
        $this->getResponse()->setHeader('Expires', $expires->format(DateTime::RFC1123), true);
        $this->getResponse()->setHeader('Last-Modified', $lastMod->format(DateTime::RFC1123), true);
        $this->getResponse()->setHeader('Cache-Control', 'public', true);

        $this->_helper->json(array(
            'single_issue' => 'ch.tageswoche.issue.2012.test',
            'digital_upgrade' => 'ch.tageswoche.subscription.digital_upgrade',
            'digital_subscriptions' => array(
                'ch.tageswoche.subscription.month',
                'ch.tageswoche.subscription.quarter',
                'ch.tageswoche.subscription.bi_annual',
                'ch.tageswoche.subscription.annual',
            ),
        ));
    }

    /**
     * Validate purchase
     */
    public function validateAction()
    {
        if (!$this->getRequest()->isSecure()) {
            //$this->sendError("Https required");
        }

        if (!$this->_getParam('receipt_data')) {
            //$this->sendError("No 'receipt_data' provided");
        }

        $this->_helper->json($this->_helper->service('mobile.purchase')->validate($this->_getParam('receipt_data')));
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

    /**
     * Send error and exit
     *
     * @param string $body
     * @param int $code
     * @return void
     */
    private function sendError($body = '', $code = 400)
    {
        $this->getResponse()->setHttpResponseCode($code);
        $this->_helper->json(array(
            'code' => $code,
            'message' => $body,
        ));
    }
}
