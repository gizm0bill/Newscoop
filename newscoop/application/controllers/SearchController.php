<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

require_once __DIR__ . '/AbstractSolrController.php';

/**
 */
class SearchController extends AbstractSolrController
{
    public function indexAction()
    {
        if (!$this->_getParam('q', false)) {
            $this->render('blank');
            return;
        }

        parent::indexAction();
    }

    /**
     * Build solr params array
     *
     * @return array
     */
    protected function buildSolrParams()
    {
        return array_merge(parent::buildSolrParams(), array(
            'q' => $this->buildSolrQuery(),
            'fq' => implode(' AND ', array_filter(array(
                $this->buildSolrTypeParam(),
                $this->buildSolrDateParam(),
            ))),
        ));
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
        $type = $this->_getParam('type', false);
        if (!$type || !array_key_exists($type, $this->types)) {
            return;
        }

        return sprintf('type:(%s)', is_array($this->types[$type]) ? implode(' OR ', $this->types[$type]) : $this->types[$type]);
    }
}