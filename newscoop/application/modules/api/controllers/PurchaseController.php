<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

use Guzzle\Http\Client;

/**
 * Purchage API
 */
class Api_PurchaseController extends Zend_Controller_Action
{
    const PRODUCTION_URL = 'https://buy.itunes.apple.com/verifyReceipt';
    const SANDBOX_URL = 'https://sandbox.itunes.apple.com/verifyReceipt';

    const STATUS_SANDBOX = 21007;

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
            $this->sendError("Https required");
        }

        $data = $this->getData(self::PRODUCTION_URL);
        if ($data->status === self::STATUS_SANDBOX) {
            $data = $this->getData(self::SANDBOX_URL);
        }

        $this->_helper->json(array(
            'receipt_valid' => $data->status === 0,
            'product_id' => $data->status === 0 ? $data->receipt->product_id : null,
        ));
    }

    /**
     * Get response for validate request
     *
     * @param string $url
     * @return object
     */
    private function getData($url)
    {
        try {
            $client = new Client();
            $response = $client->post($url, null, json_encode(array(
                'receipt-data' => $this->_getParam('receipt_data'),
                'password' => $this->getInvokeArg('bootstrap')->getOption('itunes_shared_secret'),
            )))->send();
        } catch (\Exception $e) {
            $this->sendError($e->getMessage(), 500);
        }

        if (!$response->isSuccessful()) {
            $this->sendError($response->getStatusCode(), 500);
        }

        return json_decode($response->getBody(true));
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
