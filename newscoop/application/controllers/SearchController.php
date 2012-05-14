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
    public function preDispatch()
    {
        if ($this->_helper->service('webcoder')->isWebcode($this->_getParam('q'))) {
            $this->_helper->redirector->setCode(302);
            $this->_helper->redirector->gotoRoute(array(
                'webcode' => $this->_getParam('q'),
            ), 'webcode', false, false);
        }
    }

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
        $fq = implode(' AND ', array_filter(array(
            $this->buildSolrTypeParam(),
            $this->buildSolrDateParam(),
        )));

        return array_merge(parent::buildSolrParams(), array(
            'q' => $this->buildSolrQuery(),
            'fq' => empty($fq) ? '' : "{!tag=t}$fq",
            'sort' => $this->_getParam('sort') === 'latest' ? 'published desc' : 'score desc',
            'facet' => 'true',
            'facet.field' => '{!ex=t}type',
            'spellcheck' => 'true',
        ));
    }

    /**
     * Build solr query
     *
     * @return string
     */
    private function buildSolrQuery()
    {
        $q = trim($this->_getParam('q'));
        if ($this->_helper->service('webcoder')->isWebcode($q)) {
            return sprintf('webcode:\%s', $q);
        }

        $matches = array();
        if (preg_match('/^(author|topic):([^"]+)$/', $q, $matches)) {
            $q = sprintf('%s:"%s"', $matches[1], json_encode($matches[2]));
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

    public function errorAction()
    {
        $this->getResponse()->setHttpResponseCode(503);
    }
}
