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
    public function indexAction()
    {
        $form = new Application_Form_SearchForm();
        $form->setMethod('GET');

        if ($form->isValid($this->getRequest()->getQuery())) {
            try {
                $q = $form->q->getValue();
                $client = $this->_helper->service('solr.client.select');
                $client->setParameterGet(array(
                    'q' => $q,
                    'wt' => 'json',
                ));

                $response = $client->request(); if ($response->isSuccessful()) {
                    $this->view->result = json_decode($response->getBody(), true);
                }
            } catch (\Exception $e) {
                var_dump($e);
                exit;
            }
        }

        $this->view->form = $form;
    }
}
