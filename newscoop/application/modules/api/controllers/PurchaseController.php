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
    const ERROR_SSL = 'Secure connection required';

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
            //$this->sendError(self::ERROR_SSL);
        }

        $receipt = $this->_getParam('receipt_data');
        if (empty($receipt)) {
            //$this->sendError("No 'receipt_data' provided");
        }

        $this->_helper->json($this->_helper->service('mobile.purchase')->validate($receipt));
    }

    /**
     * Check free upgrade status
     */
    public function freeupgradeAction()
    {
        if (!$this->getRequest()->isSecure()) {
            //$this->sendError(self::ERROR_SSL);
        }

        $username = $this->_getParam('username');
        $password = $this->_getParam('password');
        if (empty($username) || empty($password)) {
            $this->_helper->json(array('status' => 'invalid_credentials'));
        }

        $user = $this->_helper->service('auth.adapter')->findByCredentials($username, $password);
        if (empty($user)) {
            $this->_helper->json(array('status' => 'invalid_credentials'));
        }

        $subscriber = $user->getSubscriber() ?: $this->_getParam('customer_id');
        if (empty($subscriber)) {
            $this->_helper->json(array('status' => 'invalid_customer_id'));
        }

        // @todo validate $subscriber

        $device = $this->_getParam('device_id');
        if (empty($device)) {
            $this->sendError('Param device_id not set');
        }

        $issue = $this->_helper->service('mobile.issue')->getCurrentIssueId();
        if (empty($issue)) {
            $this->sendError('No issue available for upgrading', 500);
        }

        if ($this->_helper->service('mobile.free_upgrade')->addDevice($device, $user, $issue)) {
            $this->_helper->json(array('status' => 'ok'));
        }

        $this->_helper->json(array('status' => 'max_devices_reached'));
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
