<?php
require_once($GLOBALS['g_campsiteDir'].'/classes/Article.php');

$LiveUser->logout();
// Delete the cookies
setcookie('LoginUserId', '', time() - 86400);
setcookie('LoginUserKey', '', time() - 86400);
setcookie('PHPSESSID', '', time() - 86400);
@session_destroy();

// Unlock all articles that are locked by this user
Article::UnlockByUser($g_user->getUserId());

camp_html_goto_page("/$ADMIN/login.php");
?>
