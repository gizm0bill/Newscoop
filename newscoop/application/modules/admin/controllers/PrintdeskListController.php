<?php

require_once($GLOBALS['g_campsiteDir'].'/classes/User.php');

require_once($GLOBALS['g_campsiteDir'].'/template_engine/classes/CampSite.php');
require_once($GLOBALS['g_campsiteDir'].'/template_engine/metaclasses/MetaArticle.php');
require_once($GLOBALS['g_campsiteDir'].'/template_engine/metaclasses/MetaPublication.php');
require_once($GLOBALS['g_campsiteDir'].'/template_engine/metaclasses/MetaIssue.php');
require_once($GLOBALS['g_campsiteDir'].'/template_engine/metaclasses/MetaSection.php');

/**
 * @Acl(resource="printdesk")
 */
class Admin_PrintdeskListController extends Zend_Controller_Action
{

    public function init()
    {
        $this->LIMIT = 100;
    }

    /* --------------------------------------------------------------- */
    
    public function getissueAction() 
    {
        $publication_number = $this->_request->getParam('publication-number');
        $issue_number = $this->_request->getParam('issue-number');
        $language_number = $this->_request->getParam('language-number');

        $printdesk_user = \User::FetchUserByName('printdesk');
        if (empty($printdesk_user) || (!$printdesk_user->exists())) {
            return array();
        }

        $pd_arts = Article::GetList(array(
            //new ComparisonOperation('published', new Operator('is'), 'true'),
            new ComparisonOperation('iduser', new Operator('is'), $printdesk_user->getUserId()),
            new ComparisonOperation('print', new Operator('is'), '1'),
            new ComparisonOperation('publication', new Operator('is'), $publication_number),
            new ComparisonOperation('issue', new Operator('is'), $issue_number),
            new ComparisonOperation('language', new Operator('is'), $language_number),
            ), array(
                array(
                    'field' => 'bysection',
                    'dir' => 'asc',
                )
            ), 0, $this->LIMIT, $count = 0);

        $items = array();
        if (is_array($pd_arts)) {
            foreach ($pd_arts as $one_art) {
                $data_test = $one_art->getArticleData();
                $print_status = $data_test->getFieldValue('print');
                if (empty($print_status)) {
                    continue;
                }

                $one_art_info = array();
                $one_art_obj = new stdClass();

                $one_art_obj->id = $one_art->getArticleNumber();
                $one_art_obj->Section = $one_art->getSection() ->getName();
                $one_art_obj->Name = $one_art->getName();

                $publication_id = $one_art->getPublicationId();
                $issue_number = $one_art->getIssueNumber();
                $section_number = $one_art->getSectionNumber();
                $language_id = $one_art->getLanguageId();

                $meta_article = new MetaArticle((int) $language_id, $one_art_id);
                $meta_publication = new MetaPublication($publication_id);
                $meta_issue = new MetaIssue($publication_id, $language_id, $issue_number);
                $meta_section = new MetaSection($publication_id, $issue_number, $language_id, $section_number);

                $url = CampSite::GetURIInstance();
                $url->publication = $meta_publication;
                $url->issue = $meta_issue;
                $url->section = $meta_section;
                $url->article = $meta_article;
                $frontendURI = $url->getURI('article');
                $one_art_obj->Uri = $frontendURI;

                $articleLinkParams = '?f_publication_id=' . $one_art->getPublicationId()
                    . '&amp;f_issue_number=' . $one_art->getIssueNumber() . '&amp;f_section_number=' . $one_art->getSectionNumber()
                    . '&amp;f_article_number=' . $one_art->getArticleNumber() . '&amp;f_language_id=' . $one_art->getLanguageId()
                    . '&amp;f_language_selected=' . $one_art->getLanguageId();
                $previewLink = $Campsite['WEBSITE_URL'].'/admin/articles/preview.php' . $articleLinkParams;

                $one_art_obj->Preview = $previewLink;

                $items[] = $one_art_obj;
            }
        }

        echo json_encode(array('code' => 200, 'data' => $items));
        die();
    }
}

