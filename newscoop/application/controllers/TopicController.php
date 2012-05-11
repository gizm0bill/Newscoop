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

    public function init()
    {
        $this->_helper->contextSwitch
            ->addActionContext('index', 'xml');
        parent::init();
    }

    public function preDispatch()
    {
        if ($this->_getParam('topic') === null && $this->getRequest()->getActionName() === 'index') {
            $this->_forward('empty');
        }
    }

    /**
     * Build solr params array
     *
     * @return array
     */
    protected function buildSolrParams()
    {
        return array_merge(parent::buildSolrParams(), array(
            'q' => $this->buildSolrTopicParam(),
            'fq' => $this->buildSolrSourceParam(),
            'sort' => 'published desc',
            'spellcheck' => 'false',
            'rows' => $this->_getParam('format') === 'xml' ? 20 : 12,
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
            return sprintf('topic:("%s")', json_encode($this->_getParam('topic')));
        }
    }

    public function emptyAction()
    {
    }
}
