<?php
camp_load_translation_strings("comments");
require_once($GLOBALS['g_campsiteDir']."/include/phorum_load.php");
require_once($GLOBALS['g_campsiteDir'].'/classes/DbReplication.php');
require_once($GLOBALS['g_campsiteDir'].'/classes/Phorum_message.php');
require_once($GLOBALS['g_campsiteDir'].'/classes/ArticleComment.php');
require_once($GLOBALS['g_campsiteDir'].'/classes/Input.php');

if (!SecurityToken::isValid()) {
    camp_html_display_error(getGS('Invalid security token!'));
    exit;
}

$f_language_id = Input::Get('f_language_id', 'int', 0, true);
$f_article_number = Input::Get('f_article_number', 'int', 0);
$f_language_selected = Input::Get('f_language_selected', 'int', 0);

// Check that the article exists.
$articleObj = new Article($f_language_id, $f_article_number);
if (!$articleObj->exists()) {
    exit;
}

if (SystemPref::Get("UseDBReplication") == 'Y') {
    $dbReplicationObj = new DbReplication();
    $connectedToOnlineServer = $dbReplicationObj->connect();
    if ($connectedToOnlineServer == false) {
        camp_html_add_msg(getGS("Comments Disabled: you are either offline or not able to reach the Online server"));
        camp_html_goto_page(camp_html_article_url($articleObj, $f_language_selected, "edit.php"));
    }
}

// Fetch the comments attached to this article
$comments = ArticleComment::GetArticleComments($f_article_number, $f_language_id);

// process all comments
foreach ($_REQUEST as $name => $value) {
    if (strstr($name, "comment_action_")) {
        $parts = explode("_", $name);
        $messageId = $parts[2];
        $comment = new Phorum_message($messageId);
        if (!$comment->exists()) {
            continue;
        }
        switch ($value) {
            case "inbox":
                $comment->setStatus(PHORUM_STATUS_HOLD);
                break;
            case "hide":
                $comment->setStatus(PHORUM_STATUS_HIDDEN);
                break;
            case "delete":
            	// Not allowed to delete base message.
            	if ($comment->getMessageId() != $comment->getThreadId()) {
	                $comment->delete();
	                ArticleComment::Unlink($articleObj->getArticleNumber(),
	                					   $articleObj->getLanguageId(),
	                					   $messageId);
            	}
                break;
            case "approve":
                $comment->setStatus(PHORUM_STATUS_APPROVED);
                break;
        }
    }
}

if (!empty($_REQUEST['isAjax'])) {
    echo json_encode(true);
    exit;
}

camp_html_goto_page(camp_html_article_url($articleObj, $f_language_selected, "edit.php")."#add_comment");

