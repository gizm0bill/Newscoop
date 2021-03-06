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

if (!$g_user->hasPermission('CommentModerate')) {
	camp_html_display_error(getGS("You do not have the right to moderate comments." ));
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
            	// Not allowed to delete first post.
            	if ($comment->getMessageId() != $comment->getThreadId()) {
	                $comment->delete();
	                ArticleComment::Unlink(null, null, $messageId);
            	}
                break;
            case "approve":
                $comment->setStatus(PHORUM_STATUS_APPROVED);
                break;
        }
        $subjectStr = Input::Get('f_subject_'.$messageId, 'string', '', true);
        $comment->setSubject($subjectStr);
        $commentStr = Input::Get('f_comment_'.$messageId, 'string', '', true);
        $comment->setBody($commentStr);
    }
}
camp_html_goto_page("/$ADMIN/comments/index.php");

?>
