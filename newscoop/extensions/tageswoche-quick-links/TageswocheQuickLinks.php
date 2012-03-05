<?php
/**
 * @package Newscoop
 * @copyright 2011 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl.txt
 * @link http://www.sourcefabric.org
 */

/**
 * @title TagesWoche Quick Links
 * @description Quick Links widget.
 * @homepage http://www.sourcefabric.org
 * @author Sourcefabric o.p.s.
 * @version 1.0
 * @license GPLv3
 */
class TageswocheQuickLinks extends Widget
{
    const BASE_LINK = '/admin/articles/add.php';

    /* @var array */
    protected $params = array(
        'f_publication_id' => 'publication',
        'f_issue_number' => 'issue',
        'f_section_number' => 'section',
        'f_language_id' => 'language',
        'f_article_type' => 'type',
    );

    /* @var array */
    protected $items = array();

    /* @var int */
    protected $current_issue = null;


    /**
     * @return array
     */
    public function beforeRender()
    {
        $config = @parse_ini_file(dirname(__FILE__) . DIRECTORY_SEPARATOR . 'quicklinks.ini');

        $items = array();
        foreach ($config as $item) {
            $params = $this->params;

            if ($item['issue'] == '__current__') {
                $item['issue'] = $this->getCurrentIssue($item['publication'], $item['language']);
            }

            if (isset($item['base_link'])) {
                $link = $item['base_link'];
                $params = array(
                    'Pub' => 'publication',
                    'Issue' => 'issue',
                    'Language' => 'language',
                );
            } else {
                $link = self::BASE_LINK;
            }

            $params_query = array();
            foreach ($params as $param => $resource) {
                if (isset($item[$resource]) && $item[$resource]) {
                    $params_query[] = $param . '=' . $item[$resource];
                }
            }

            $link .= '?' . implode('&amp;', $params_query);
            $items[] = array('label' => $item['label'], 'link' => $link);
        }

        $this->items = $items;
    }

    /**
     * @return void
     */
    public function render()
    {
        include_once dirname(__FILE__) . '/quicklinks.php'; 
    }

    /**
     * @return int
     */
    private function getCurrentIssue($publication, $language)
    {
        if (is_null($this->current_issue)) {
            $issue = \Issue::GetCurrentIssue($publication, $language);
            $this->current_issue = $issue->getIssueNumber();
        }

        return $this->current_issue;
    }
}
