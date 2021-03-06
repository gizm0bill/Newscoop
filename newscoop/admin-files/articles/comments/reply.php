<?php
require_once($GLOBALS['g_campsiteDir']."/include/phorum_load.php");
require_once($GLOBALS['g_campsiteDir'].'/classes/DbReplication.php');
require_once($GLOBALS['g_campsiteDir'].'/classes/Input.php');
require_once($GLOBALS['g_campsiteDir'].'/classes/Phorum_message.php');
require_once($GLOBALS['g_campsiteDir'].'/classes/ArticleComment.php');
camp_load_translation_strings("globals");
camp_load_translation_strings("articles");

$f_language_id = Input::Get('f_language_id', 'int', 0, true);
$f_article_number = Input::Get('f_article_number', 'int', 0);
$f_language_selected = Input::Get('f_language_selected', 'int', 0);
$f_comment_id = Input::Get('f_comment_id');

if (!Input::IsValid()) {
	camp_html_display_error(getGS('Invalid input: $1', Input::GetErrorString()), $BackLink);
	exit;
}

// Check that the article exists.
$articleObj = new Article($f_language_id, $f_article_number);
if (!$articleObj->exists()) {
	exit;
}
if (!$articleObj->commentsEnabled() || $articleObj->commentsLocked())  {
	camp_html_goto_page(camp_html_article_url($articleObj, $f_language_selected, "edit.php"));
}

$publicationObj = new Publication($articleObj->getPublicationId());
$issueObj = new Issue($articleObj->getPublicationId(), $f_language_id, $articleObj->getIssueNumber());
$sectionObj = new Section($articleObj->getPublicationId(), $articleObj->getIssueNumber(), $f_language_id, $articleObj->getSectionNumber());
$languageObj = new Language($articleObj->getLanguageId());

$topArray = array('Pub' => $publicationObj, 'Issue' => $issueObj,
				  'Section' => $sectionObj, 'Article'=>$articleObj);
camp_html_content_top(getGS("Reply to comment"), $topArray);

if (SystemPref::Get("UseDBReplication") == 'Y') {
    $dbReplicationObj = new DbReplication();
    $connectedToOnlineServer = $dbReplicationObj->connect();
    if ($connectedToOnlineServer == false) {
        camp_html_add_msg(getGS("Comments Disabled: you are either offline or not able to reach the Online server"));
    } else {
        $comment = new Phorum_message($f_comment_id);
    }
} else {
    $comment = new Phorum_message($f_comment_id);
}

?>
<table cellpadding="1" cellspacing="0" class="action_buttons" style="padding-top: 10px;">
<tr>
  <td><img src="<?php echo $Campsite["ADMIN_IMAGE_BASE_URL"]; ?>/left_arrow.png" border="0" /></td>
  <td><a href="<?php echo camp_html_article_url($articleObj, $f_language_id, "edit.php"); ?>"><b><?php putGS('Back to Edit Article'); ?></b></a></td>
</tr>
</table>
<p>
<table cellspacing="0" cellpadding="0" border="0" class="box_table">
<tr>
  <td colspan="2" style="padding-top: 5px; padding-bottom: 5px; border-bottom: 1px solid black;"">
    &nbsp;<b><?php putGS('Comment'); ?></b>
  </td>
<tr>
<?php
if (isset($connectedToOnlineServer)
    && $connectedToOnlineServer == false) {
?>
<tr>
  <td><?php camp_html_display_msgs('0.25em', '0.25em'); ?></td>
</tr>
</table>
<?php
} else {
?>
<tr>
  <td align="right" valign="top" nowrap><?php putGS('From'); ?>:</td>
  <td><?php p(htmlspecialchars($comment->getAuthor())); ?> &lt;<?php p(htmlspecialchars($comment->getEmail())); ?>&gt; (<?php p($comment->getIpAddress()); ?>)</td>
</tr>
<tr>
  <td align="right" valign="top" nowrap><?php putGS('Date'); ?>:</td>
  <td><?php p(date('Y-m-d H:i:s', $comment->getCreationDate())); ?></td>
</tr>
<tr>
  <td align="right" valign="top" nowrap><?php putGS('Subject'); ?>:</td>
  <td><?php p(htmlspecialchars($comment->getSubject())); ?></td>
</tr>
<tr>
  <td align="right" valign="top" nowrap><?php putGS('Comment'); ?>:</td>
  <td><?php p(htmlspecialchars($comment->getBody())); ?></td>
</tr>
</table>
<p>
<form action="/<?php p($ADMIN); ?>/articles/comments/do_add_comment.php" method="GET">
<?php echo SecurityToken::FormParameter(); ?>
<input type="hidden" name="f_language_id" value="<?php p($f_language_id); ?>">
<input type="hidden" name="f_article_number" value="<?php p($f_article_number); ?>">
<input type="hidden" name="f_language_selected" value="<?php p($f_language_selected); ?>">
<input type="hidden" name="f_comment_id" value="<?php p($f_comment_id); ?>">
<table border="0" cellspacing="0" cellpadding="0" class="box_table">
<tr>
  <td colspan="2" style="padding-left: 5px;">
    <b><?php putGS('Reply to comment'); ?></b>
    <hr noshade size="1" color="black" />
  </td>
</tr>
<tr>
  <td valign="middle" align="right">
    <?php putGS('Subject'); ?>:
  </td>
  <td>
    <input type="text" name="f_comment_subject" value="" class="input_text" size="41" <?php print $spellcheck ?> >
  </td>
</tr>
<tr>
  <td valign="top" align="right" style="padding-top: 5px;">
    <?php putGS('Comment'); ?>:
  </td>
  <td>
    <textarea name="f_comment_body" class="input_text_area" rows="10" cols="60" <?php print $spellcheck ?>></textarea>
  </td>
</tr>
<tr>
  <td colspan="2" align="center">
    <input type="submit" value="<?php putGS('Submit'); ?>" class="button">
  </td>
</tr>
</table>
</form>
<?php } // if comment enabled ?>

<?php camp_html_copyright_notice(); ?>