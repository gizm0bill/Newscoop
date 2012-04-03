<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

require_once __DIR__ . '/AbstractSolrController.php';

/**
 */
class TickerController extends AbstractSolrController
{
    /**
     * @var array
     */
    private $sources = array(
        'tageswoche' => array('news', 'dossier'),
        'twitter' => 'tweet',
        'agentur' => 'newswire',
        'link' => 'link',
    );

    /**
     * Build solr params array
     *
     * @return array
     */
    protected function buildSolrParams()
    {
        return array_merge(parent::buildSolrParams(), array(
            'q' => '*:*',
            'fq' => implode(' AND ', array_filter(array(
                $this->buildSolrSourceParam(),
                //$this->buildSolrTypeParam(),
                //$this->buildSolrDateParam(),
            ))),
            'sort' => 'published desc',
        ));
    }

    /**
     * Build solr source filter
     *
     * @return string
     */
    private function buildSolrSourceParam()
    {
        $sources = array();
        foreach (explode(',', $this->_getParam('source')) as $source) {
            if (array_key_exists($source, $this->sources)) {
                $sources = array_merge($sources, (array) $this->sources[$source]);
            }
        }

        if (!empty($sources)) {
            return sprintf('type:(%s)', implode(' OR ', $sources));
        }
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
