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

    public function indexAction()
    {
        parent::indexAction();
        if ($this->_helper->contextSwitch->getCurrentContext() === 'xml') {
            $this->getResponse()->setHeader('Content-Type', 'application/rss-xml', true);
            $this->render('xml');
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
            'q' => '*:*',
            'fq' => implode(' AND ', array_filter(array(
                $this->buildSolrSourceParam(),
                $this->buildSolrTopicParam(),
            ))),
            'sort' => 'published desc',
            'spellcheck' => 'false',
            'rows' => $this->_getParam('format') === 'xml' ? 20 : null,
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
            return sprintf('topic:("%s")', rawurlencode($this->_getParam('topic')));
        }
    }
}
