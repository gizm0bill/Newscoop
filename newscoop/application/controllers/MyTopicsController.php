<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

require_once __DIR__ . '/AbstractSolrController.php';
require_once __DIR__ . '/TopicController.php';

/**
 */
class MyTopicsController extends TopicController
{
    /** @var Newscoop\Entity\User */
    protected $user;

    public function init()
    {
        $this->user = $this->_helper->service('user')->getCurrentUser();
        if ($this->user === null) {
            $this->_forward('empty');
        }
    }

    public function emptyAction()
    {
    }

    /**
     * Build solr topic filter
     *
     * @return string
     */
    protected function buildSolrTopicParam()
    {
        if ($this->_getParam('topic')) {
            $topics = explode(',', $this->_getParam('topic'));
        } else {
            $topics = array_map(function($topic) {
                return $topic->getName();
            }, $this->_helper->service('user.topic')->getTopics($this->user));
        }

        if (empty($topics)) {
            $topics[] = sha1(__FILE__);
            $this->view->noTopics = true;
        }

        return sprintf('topic:("%s")', implode('" OR "', $topics));
    }
}
