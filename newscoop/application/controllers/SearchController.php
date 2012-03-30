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
    const LIMIT = 10;

    static $dates = array(
        '24h' => '[NOW-1DAY/HOUR TO NOW]',
        '7d' => '[NOW-7DAY/DAY TO NOW]',
        '1y' => '[NOW-1YEAR/DAY TO NOW]',
    );

    public function init()
    {
        $this->_helper->contextSwitch
            ->addActionContext('index', 'json')
            ->initContext();
    }

    public function indexAction()
    {
        if (!$this->_getParam('q', false)) {
            $this->render('blank');
            return;
        }

        $client = $this->_helper->service('solr.client.select');
        $client->setParameterGet($this->buildSolrParams());

        try {
            $response = $client->request();
        } catch (\Exception $e) {
            var_dump($e); exit;
        }

        if (!$response->isSuccessful()) {
            var_dump($response);
            exit;
        }

        if ($this->_helper->contextSwitch->getCurrentContext() === 'json') {
            $this->_helper->json($this->decodeSolrResponse($response));
        } else {
            $this->view->result = $this->decodeSolrResponse($response);
        }
    }

    /**
     * Build solr params array
     *
     * @return array
     */
    private function buildSolrParams()
    {
        return array(
            'wt' => 'json',
            'q' => $this->buildSolrQuery(),
            'start' => $this->_getParam('page', 0) * self::LIMIT,
            'fq' => implode(' AND ', array_filter(array(
                $this->buildSolrTypeParam(),
                $this->buildSolrDateParam(),
            ))),
        );
    }

    /**
     * Build solr query
     *
     * @return string
     */
    private function buildSolrQuery()
    {
        $q = $this->_getParam('q');
        if ($this->_helper->service('webcoder')->isWebcode($q)) {
            return sprintf('webcode:\%s', $q);
        }

        return $q;
    }

    /**
     * Build solr type param
     *
     * @return string
     */
    private function buildSolrTypeParam()
    {
        return $this->_getParam('type', false) || $this->_getParam('type') === 'undefined' ? sprintf('type:%s', $this->_getParam('type')) : null;
    }

    /**
     * Build solr date param
     *
     * @return string
     */
    private function buildSolrDateParam()
    {
        $date = $this->_getParam('date', false);
        if (!$date) {
            return;
        }

        if (array_key_exists($date, self::$dates)) {
            return sprintf('published:%s', self::$dates[$date]);
        }

        try {
            list($from, $to) = explode(',', $date, 2);
            $fromDate = empty($from) ? null : new \DateTime($from);
            $toDate = empty($to) ? null : new \DateTime($to);
        } catch (\Exception $e) {
            return;
        }

        return sprintf('published:[%s TO %s]',
            $fromDate === null ? '*' : $fromDate->format('Y-m-d\TH:i:s\Z') . '/DAY',
            $toDate === null ? '*' : $toDate->format('Y-m-d\TH:i:s\Z') . '/DAY');
    }

    /**
     * Decode solr response
     *
     * @return array
     */
    private function decodeSolrResponse(\Zend_Http_Response $response)
    {
        $decoded = json_decode($response->getBody(), true);
        $decoded['responseHeader']['params']['q'] = $this->_getParam('q'); // this might be modified, keep users query
        return $decoded;
    }
}
