<?php
/**
 * @package Newscoop 
 *
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl.txt
 * @link http://www.sourcefabric.org
 */

require_once dirname(__FILE__) . '/../BaseList/BaseList.php';

/**
 * Article popularity list component
 */
class ArticlePopularityList extends BaseList
{
    /**
     */
    public function __construct()
    {
        parent::__construct();
        
        $this->cols = array(
            'id' => NULL,
            'Name' => getGS('URL'),
            'unique_views' => getGS('Unique Views'),
            'avg_time_on_page' => getGS('Average Time on Page'),
            'tweets' => getGS('Re-tweets'),
            'likes' => getGS('Facebook Likes'),
            'comments' => getGS('Comments'),
            'popularity' => getGS('Popularity'),
        );

        $this->defaultSorting = 7;
        $this->defaultSortingDir = 'desc';
        $this->notSortable[] = 1;
        $this->type = 'article.popularity';
    }

    /**
     * Data provider
     * @return array
     */
    public function doData()
    {
        // get args
        $aoData = $this->getArgs();

        return array(
            'iTotalRecords' => sizeof($this->items),
            'iTotalDisplayRecords' => 30,
            'sEcho' => (int) $aoData['sEcho'],
            'aaData' => $this->items,
        );
    }

    /**
     * Process item
     *
     * @param array $item
     * @return array
     */
    public function processItem($item)
    {
        $row['id'] = $item->number;
        $row['Name'] = sprintf('<a href="%s">%s</a>',
            $item->url,
            $item->article_title
        );

        $row['unique_views'] = $item->unique_views;
        $row['avg_time_on_page'] = $item->avg_time_on_page;
        $row['tweets'] = $item->tweets;
        $row['likes'] = $item->likes;
        $row['comments'] = $item->comments;
        $row['popularity'] = $item->popularity;

        return array_values($row);
    }
}
