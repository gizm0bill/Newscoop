<?php
camp_load_translation_strings("plugin_interview");
?>
<html>
<head>
    <META http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<META HTTP-EQUIV="Expires" CONTENT="now">
	<LINK rel="stylesheet" type="text/css" href="<?php echo $Campsite['WEBSITE_URL']; ?>/css/admin_stylesheet.css">
	<title><?php putGS("Edit Interview"); ?></title>
	<?php include_once($GLOBALS['g_campsiteDir']."/$ADMIN_DIR/javascript_common.php"); ?>
</head>
<body>
<?php

// Check permissions
if (!$g_user->hasPermission('plugin_interview_admin')) {
    camp_html_display_error(getGS('You do not have the right to manage interviews.'));
    exit;
}

$f_interview_id = Input::Get('f_interview_id', 'int');

if (!Input::IsValid()) {
    camp_html_display_error(getGS('Invalid input: $1', Input::GetErrorString()), $_SERVER['REQUEST_URI']);
    exit;
}

$Interview = new Interview($f_interview_id);

if (isset($_REQUEST['f_preview'])) {
    $Interview->storeInvitation();
}

if (isset($_REQUEST['f_invite_now'])) {
    $Interview->sendGuestInvitation();
    ?>
    <script language="javascript">
        window.opener.location.reload();
        window.close();
    </script>
    <?php
    exit();
}

?>
<table style="margin-top: 10px; margin-left: 15px; margin-right: 15px;" cellpadding="0" cellspacing="0" width="95%" class="table_input">
    <TR>
    	<TD style="padding: 3px";>
    		<B><?php putGS('Send Invitation') ?></B>
    		<hr style="color: #8baed1";>
    	</TD>
    </TR>
    <tr>
        <td>
            <?php p($Interview->getInvitationForm('invitation.php', array(), true, $g_user->getUserId())); ?>
        </td>
    </tr>
</table>
</body>
</html>
