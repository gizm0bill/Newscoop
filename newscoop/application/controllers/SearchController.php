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
        try {
            $client = $this->_helper->service('solr.client.select');
            $client->setParameterGet($this->buildSolrParams());

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

    /**
     * Build solr params array
     *
     * @return array
     */
    private function buildSolrParams()
    {
        return array(
            'wt' => 'json',
            'q' => $this->_getParam('q'),
            'start' => $this->_getParam('page', 0) * self::LIMIT,
            'fq' => implode(' AND ', array_filter(array(
                $this->buildSolrTypeParam(),
                $this->buildSolrDateParam(),
            ))),
        );
    }

    /**
     * Build solr type param
     *
     * @return string
     */
    private function buildSolrTypeParam()
    {
        return $this->_getParam('type', false) ? sprintf('type:%s', $this->_getParam('type')) : null;
    }

    /**
     * Build solr date param
     *
     * @return string
     */
    private function buildSolrDateParam()
    {
        $date = $this->_getParam('date', false);
        if (!$date || !array_key_exists($date, self::$dates)) {
            return;
        }

        return sprintf('published:%s', self::$dates[$date]);
    }
}
