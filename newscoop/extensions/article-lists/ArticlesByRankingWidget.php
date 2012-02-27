<?php
/**
 * @package Newscoop
 *
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl.txt
 * @link http://www.sourcefabric.org
 */

require_once LIBS_DIR . '/ArticlePopularityList/ArticlePopularityList.php';

/**
 * @title Articles by popularity 
 */
class ArticlesByRankingListWidget extends Widget
{
    public function __construct()
    {
        $this->title = getGS('Articles by popularity');
    }

    public function beforeRender()
    {
        $this->items = array();
        $service = Zend_Registry::get('container')->getService('article.popularity');
        $items = $service->fetchRanking();

        if (!is_array($items)) {
            return;
        }

        foreach($items as $item) {
            $object = new stdClass();
            foreach($item as $key => $value) {
                $object->{$key} = $value;
            }
            $this->items[] = $object;
        }
    }

    public function render()
    {
        $list = new ArticlePopularityList;

        $list->setItems($this->items);

        $list->setHidden('id');
        if (!$this->isFullscreen()) {
            $list->setHidden('unique_views');
            $list->setHidden('avg_time_on_page');
            $list->setHidden('tweets');
            $list->setHidden('likes');
            $list->setHidden('comments');
        } 

        $list->render();
    }
}
