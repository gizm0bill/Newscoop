<?php

require_once($GLOBALS['g_campsiteDir']. "/$ADMIN_DIR/articles/article_common.php");
require_once($GLOBALS['g_campsiteDir']. "/$ADMIN_DIR/articles/editor_load_countable.php");
require_once($GLOBALS['g_campsiteDir']. "/classes/ArticleType.php");

global $Campsite;

$websiteUrl = str_replace('https://', 'http://', $Campsite['WEBSITE_URL']);

if (!$g_user->hasPermission('AddArticle')) {
	camp_html_display_error(getGS("You do not have the right to add articles."));
	exit;
}

$f_comment_id = Input::Get('f_comment_id', 'int', '', true);
$f_article_name = 'good_comment_' . $f_comment_id;
$f_article_type = Input::Get('f_article_type', 'string', '', true);
$f_publication_id = Input::Get('f_publication_id', 'int', 0, true);
$f_issue_number = Input::Get('f_issue_number', 'int', 0, true);
$f_section_number = Input::Get('f_section_number', 'int', 0, true);
$f_article_language = Input::Get('f_article_language', 'int', 0, true);

if (!Input::IsValid()) {
	camp_html_display_error(getGS('Invalid input: $1', Input::GetErrorString()), $_SERVER['REQUEST_URI']);
	exit;
}

// get comment
$commentRepository = Zend_Registry::get('doctrine')->getEntityManager()->getRepository('Newscoop\Entity\Comment');

$comments = $commentRepository->getData(array('sFilter' => $filter = array('id' => $f_comment_id)), array('thread_order' => 'default'));
$comment = $comments[0];
//var_dump($comment->getMessage());die;
$commenter = $comment->getCommenter();
$article = new Article($comment->getLanguage()->getId(), $comment->getArticleNumber());

$articleUrl = Admin_CommentController::getFrontendLink($article);

$commentNote = "<a href='".$websiteUrl."/user/profile/".urlencode($commenter->getName())."'>" . $commenter->getLoginName() . "</a> zu <a href='".$articleUrl."'>".$article->getName()."</a>";

// create article
$articleObj = new Article($f_article_language);
$articleObj->create($f_article_type, $f_article_name, $f_publication_id, $f_issue_number, $f_section_number);

$articleTypeObj = $articleObj->getArticleData();

$articleTypeObj->setProperty('Fcomment_community', $comment->getMessage());
$articleTypeObj->setProperty('Fcomment_on_comment', $commentNote);
ArticleIndex::RunIndexer(3, 10, true);

$articleEditUrl = $Campsite['WEBSITE_URL'].'/admin/articles/edit.php?f_publication_id='.$f_publication_id.'&f_issue_number='.$f_issue_number.'&f_section_number='.$f_section_number.'&f_article_number='.$articleObj->m_data['Number'].'&f_language_id='.$f_article_language.'&f_language_selected='.$f_article_language;
camp_html_goto_page($articleEditUrl);
