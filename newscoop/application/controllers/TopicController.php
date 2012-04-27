<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

require_once __DIR__ . '/AbstractSolrController.php';

/**
 */
class TopicController extends AbstractSolrController
{
    /**
     * @var array
     */
    protected $sources = array(
        'news', 'newswire', 'blog', 'dossier',
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
                $this->buildSolrTopicParam(),
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
    protected function buildSolrSourceParam()
    {
        return sprintf('type:(%s)', implode(' OR ', $this->sources));
    }

    /**
     * Build solr topic filter
     *
     * @return string
     */
    protected function buildSolrTopicParam()
    {
        if ($this->_getParam('topic')) {
            $this->view->topic = $this->_getParam('topic');
            return sprintf('topic:("%s")', implode('" OR "', explode(',',  $this->_getParam('topic'))));
        }
    }
}
