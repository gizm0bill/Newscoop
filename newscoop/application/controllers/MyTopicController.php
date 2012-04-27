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
class MyTopicController extends TopicController
{
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
            $user = $this->_helper->service('user')->getCurrentUser();
            $topics = array_map(function($topic) {
                return $topic->getName();
            }, $this->_helper->service('user.topic')->getTopics($user));
        }

        if (empty($topics)) {
            $topics[] = sha1(__FILE__);
            $this->view->noTopics = true;
        }

        return sprintf('topic:("%s")', implode('" OR "', $topics));
    }
}
