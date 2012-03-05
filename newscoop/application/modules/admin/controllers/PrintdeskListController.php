<?php

require_once($GLOBALS['g_campsiteDir'].'/classes/User.php');


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
                $one_art_info = array();
                $one_art_obj = new stdClass();

                $one_art_obj->id = $one_art->getArticleNumber();
                $one_art_obj->Section = $one_art->getSection() ->getName();
                $one_art_obj->Name = $one_art->getName();

                $items[] = $one_art_obj;
            }
        }

        echo json_encode(array('code' => 200, 'data' => $items));
        die();
    }
}

