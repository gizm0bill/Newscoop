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
     * @var Newscoop\Entity\Topic
     */
    private $topic;

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
        if ($this->getRequest()->getActionName() === 'index') {
            if (!$this->_getParam('topic')) {
                $this->_forward('empty');
                return;
            }

            $this->topic = $this->_helper->service('em')->getRepository('Newscoop\Entity\Topic')->findOneBy(array(
                'name' => $this->_getParam('topic'),
            ));

            if ($this->topic === null) {
                $this->_forward('notfound');
                return;
            }
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
        $this->view->topic = (object) array(
            'id' => $this->topic->getTopicId(),
            'name' => $this->topic->getName(),
        );

        return sprintf('topic:("%s")', json_encode($this->_getParam('topic')));
    }

    public function emptyAction()
    {
    }

    public function notfoundAction()
    {
        $this->getResponse()->setHttpResponseCode(404);
    }
}
