<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

/**
 */
class SearchController extends Zend_Controller_Action
{
    public function init()
    {
        $this->_helper->contextSwitch
            ->addActionContext('index', 'json')
            ->initContext();
    }

    public function indexAction()
    {
        try {
            $client = $this->_helper->service('solr.client.select');
            $client->setParameterGet(array(
                'q' => $this->_getParam('q', '*'),
                'fq' => $this->_getParam('fq', ''),
                'wt' => 'json',
            ));

            $response = $client->request();
            if ($response->isSuccessful()) {
                $this->view->result = json_decode($response->getBody(), true);
            } else {
                var_dump($response);
                exit;
            }

            if ($this->_helper->contextSwitch->getCurrentContext() === 'json') {
                $this->_helper->json($this->view->result);
            }
        } catch (\Exception $e) {
            var_dump($e);
            exit;
        }
    }
}
