<?php
/**
 * @package Campsite
 *
 * @author Martin Saturka <martin.saturka@sourcefabric.org>
 * @copyright 2010 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl.txt
 * @link http://www.sourcefabric.org
 */

require_once($GLOBALS['g_campsiteDir'].'/classes/User.php');
require_once($GLOBALS['g_campsiteDir'].'/classes/Publication.php');
require_once($GLOBALS['g_campsiteDir'].'/classes/Issue.php');
require_once($GLOBALS['g_campsiteDir'].'/classes/Extension/Widget.php');
require_once LIBS_DIR . '/BaseList/BaseList.php';


class PrintdeskArticleList extends BaseList
{

    public function __construct()
    {
        parent::__construct();

        $this->page_size = 1000;
        
        $this->cols = array(
            'id' => NULL,
            'Section' => getGS('Section'),
            'Name' => getGS('Name'),
        );

        $this->defaultSorting = 1;
        $this->defaultSortingDir = 'asc';
        $this->notSortable[] = 0;
        $this->type = 'article.printdesk';
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
            //'iTotalDisplayRecords' => sizeof($this->items),
            'iTotalDisplayRecords' => 1000,
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

        $row = array();
        $row['id'] = $item->id;
        $row['Section'] = $item->Section;
        $row['Name'] = $item->Name;

        return array_values($row);
    }

    public static function SortPubIssues($a, $b) {
        $key_parts_a = explode('-', $a);
        $key_parts_b = explode('-', $b);

        if ($key_parts_a[0] > $key_parts_b[0]) {
            return -1;
        }
        if ($key_parts_a[0] < $key_parts_b[0]) {
            return 1;
        }

        if ($key_parts_a[1] > $key_parts_b[1]) {
            return 1;
        }
        if ($key_parts_a[1] < $key_parts_b[1]) {
            return -1;
        }

        return 0;
    }



    /**
     * Render actions.
     * @return ArticleList
     */
    public function renderIssues()
    {
        $pubs_info = array();

        $this->beforeRender();

        $pubs = Publication::GetPublications();
        if (empty($pubs)) {
            $pubs = array();
        }

        $allowed_pub_ids = array(1);

        foreach ($pubs as $one_pub) {
            $pub_issues = Issue::GetIssues($one_pub->getPublicationId());
            if (empty($pub_issues)) {
                continue;
            }

            $pub_number = $one_pub->getPublicationId();
            $pub_name = $one_pub->getName();
            $pub_lang = $one_pub->getLanguageId();

            if (!in_array($pub_number, $allowed_pub_ids)) {
                continue;
            }

            $issues = array();
            foreach ($pub_issues as $one_issue) {
                $issue_name = $one_issue->getName();
                $issue_number = $one_issue->getIssueNumber();
                $issue_lang_id = $one_issue->getLanguageId();
                $issue_lang_name = $one_issue->getLanguageName();
                $issue_published = $one_issue->isPublished();
                $issues[$issue_number . '-' . $issue_lang_id] = array('name' => $issue_name, 'number' => $issue_number, 'lang_id' => $issue_lang_id, 'lang_name' => $issue_lang_name, 'current' => false, 'published' => $issue_published);
            }

            uksort($issues, 'self::SortPubIssues');

            $top_issue = null;
            $got_published = false;
            foreach ($issues as $one_key => $one_issue) {
                if ($top_issue === null) {
                    $top_issue = $one_issue;
                }

                if (($one_issue['lang'] == $pub_lang) && $one_issue['published']) {
                    $issues[$one_key]['current'] = true;
                    $got_published = true;
                    break;
                }
            }
            if (!$got_published) {
                foreach ($issues as $one_key => $one_issue) {
                    if ($one_issue['published']) {
                        $issues[$one_key]['current'] = true;
                        $got_published = true;
                        break;
                    }
                }
            }

            $pubs_info[$pub_number] = array('name' => $pub_name, 'issues' => $issues);

        }

        ksort($pubs_info, SORT_NUMERIC);

        $load_pub = 0;
        $load_issue = 0;
        $load_lang = 0;

        $first_pub_cont = array_slice($pubs_info, 0, 1, true);
        foreach ($first_pub_cont as $first_pub_id => $first_pub) {

            $load_pub = $first_pub_id;

            foreach ($first_pub['issues'] as $first_issues) {
                if ((0 == $load_issue) || ($first_issues['current'])) {
                    $load_issue = $first_issues['number'];
                    $load_lang = $first_issues['lang_id'];
                }
            }

        }

        if ((0 != $load_pub) && (0 != $load_issue) && (0 != $load_lang)) {

            echo '
<script type="text/javascript">
$(document).ready(function() {
    setTimeout(\'window.get_printdesk_table("table-' . $this->id . '", "' . $load_pub . '", "' . $load_issue . '", "' . $load_lang . '");\', 10);
});
</script>
';
        }

        echo '
<script type="text/javascript">
window.pub_issues_' . $this->id . ' = {};
';

        $pub_first = null;
        foreach ($pubs_info as $pub_id => $one_pub_info) {
            if ($pub_first === null) {
                $pub_first = $pub_id;
            }

            echo 'window.pub_issues_' . $this->id . '["' . $pub_id . '"] = {}' . "\n";
            echo 'window.pub_issues_' . $this->id . '["' . $pub_id . '"]["name"] = "' . htmlspecialchars($one_pub_info['name']) . '";' . "\n";
            echo 'window.pub_issues_' . $this->id . '["' . $pub_id . '"]["issues"] = ' . json_encode($one_pub_info['issues']) . ';' . "\n";
        }

        echo '
</script>
';

        echo '
<div class="filters">
<style type="text/css">
    .select_hidden {
        display: none;
    }
</style>
<fieldset class="filters"><legend>'. getGS('Filter') . '</legend>
<select name="publication" id="printdesk_publication_filter_' . $this->id . '" class="select_hidden">
';

        foreach ($pubs_info as $pub_id => $pub_info) {
            $selected_pub = '';
            if ($pub_first == $pub_id) {
                $selected_pub = ' selected';
            }

            echo '<option value="' . $pub_id . '"' . $selected_pub . '>' . htmlspecialchars($pub_info['name']) . '</option>' . "\n";
        }
        echo '
</select>
';

        foreach ($pubs_info as $pub_id => $pub_info) {
            $class_spec = '';
            if ($pub_id != $pub_first) {
                $class_spec = ' class="select_hidden"';
            }

            echo '
<select name="issue" id="printdesk_issue_filter_' . $this->id . '_' . $pub_id . '"' . $class_spec . '>
';
            $curr_issues = $pubs_info[$pub_id]['issues'];
            foreach ($curr_issues as $one_issue) {
                $selected_issue = '';
                if ($one_issue['current']) {
                    $selected_issue = ' selected';
                }
                echo '<option value="' . $one_issue['number'] . '-' . $one_issue['lang_id'] . '"' . $selected_issue . '>' . $one_issue['name'] . ' (' . $one_issue['lang_name'] . ')</option>' . "\n";
            }
            echo ';
</select>
<script type="text/javascript">
$(document).ready(function() {
    $("#printdesk_issue_filter_' . $this->id . '_' . $pub_id . '").change(function() {
        var publication_selected = "' . $pub_id . '";
        var issue_selected = "" + $("#printdesk_issue_filter_' . $this->id . '_' . $pub_id . '").val();
        issue_selected = issue_selected.split("-");

        var issue_number = issue_selected[0];
        var issue_language = issue_selected[1];

        window.get_printdesk_table("table-' . $this->id . '", "" + publication_selected, "" + issue_number, "" + issue_language);
    });

});
</script>
';
        }

echo '
</div>
<script type="text/javascript">
$(document).ready(function() {

    $("#printdesk_publication_filter_' . $this->id . '").change(function() {
        var publication_selected = $("#printdesk_publication_filter_' . $this->id . '").val();

        for (var pub_key in window.pub_issues_' . $this->id . ') {
            if (pub_key == publication_selected) {
                continue;
            }

            var pub_issue_sel_hide = "#printdesk_issue_filter_' . $this->id . '_" + pub_key;
            $(pub_issue_sel_hide).addClass("select_hidden");
        }

        var pub_issue_sel_show = "#printdesk_issue_filter_' . $this->id . '_" + publication_selected;
        $(pub_issue_sel_show).removeClass("select_hidden");

        var issue_selected = "" + $(pub_issue_sel_show).val();
        issue_selected = issue_selected.split("-");

        var issue_number = issue_selected[0];
        var issue_language = issue_selected[1];

        window.get_printdesk_table("table-' . $this->id . '", "" + publication_selected, "" + issue_number, "" + issue_language);
    });

});

window.get_printdesk_table = function (table, publication, issue, language) {
    var url = "' . $Campsite['WEBSITE_URL'] . '/admin/printdesklist/getissue";

    callServer(
        {
            url: url,
            method: "GET"
        },
        {
            "publication-number": publication,
            "issue-number": issue,
            "language-number": language
        },
        function(res) {
            window.update_printdesk_table(table, res["data"]);
        },
        true
    );

};

window.update_printdesk_table = function(table, art_data) {

    var data_len = art_data.length;


    var table_obj = $("#" + table);
    var table_dt = table_obj.dataTable();
    table_dt.fnClearTable();

    var insert_data = [];

    for (var dind = 0; dind < data_len; dind++) {
        var one_row_data = art_data[dind];

        var article_link = "<a href=\'" + one_row_data["Preview"] + "\' target=\'_blank\'>" + one_row_data["Name"] + "</a>";

        insert_data.push([
            one_row_data["id"],
            one_row_data["Section"],
            //one_row_data["Name"]
            article_link
        ]);

    }

    table_dt.fnAddData(insert_data);

}

</script>
';

        return $this;
    }

}

/**
 * @title Printdesk Articles
 */
class PrintdeskArticlesWidget extends Widget
{
    public function __construct()
    {
        $this->title = getGS('Printdesk Articles');
    }

    public function beforeRender()
    {
        $this->items = array();
    }

    public function render()
    {
        $articlelist = new PrintdeskArticleList();
        $articlelist->setItems($this->items);

        $articlelist->renderIssues();

        $articlelist->setHidden('id');
        $articlelist->render();

    }

}
