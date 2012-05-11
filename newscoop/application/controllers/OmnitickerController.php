<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

require_once __DIR__ . '/AbstractSolrController.php';

/**
 */
class OmnitickerController extends AbstractSolrController
{
    /**
     * @var array
     */
    private $sources = array(
        'tageswoche' => array('news', 'dossier', 'blog'),
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
                $this->buildSolrSectionParam(),
                $this->buildSolrSourceParam(),
                $this->buildSolrDateParam(),
            ))),
            'sort' => 'published desc',
            'spellcheck' => 'false',
        ));
    }

    /**
     * Build solr source filter
     *
     * @return string
     */
    private function buildSolrSourceParam()
    {
        $source = $this->_getParam('source');
        if (!empty($source) && array_key_exists($source, $this->sources)) {
            $sources = (array) $this->sources[$source];
        } else {
            $sources = array();
            foreach ($this->sources as $types) {
                $sources = array_merge($sources, (array) $types);
            }
        }

        return sprintf('type:(%s)', implode(' OR ', $sources));
    }

    /**
     * Build solr section filter
     *
     * @return string
     */
    private function buildSolrSectionParam()
    {
        $section = $this->_getParam('section');
        if (!empty($section)) {
            return sprintf('section:("%s")', json_encode($section));
        }
    }
}
