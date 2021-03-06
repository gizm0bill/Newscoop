<?php
camp_load_translation_strings("article_images");
require_once($GLOBALS['g_campsiteDir']."/$ADMIN_DIR/articles/article_common.php");
require_once($GLOBALS['g_campsiteDir']."/classes/ArticleImage.php");
require_once($GLOBALS['g_campsiteDir']."/classes/Image.php");

if (!$g_user->hasPermission("AddImage")) {
	camp_html_display_error(getGS("You do not have the right to add images" ), null, true);
	exit;
}
$maxId = Image::GetMaxId();
$f_publication_id = Input::Get('f_publication_id', 'int', 0);
$f_issue_number = Input::Get('f_issue_number', 'int', 0);
$f_section_number = Input::Get('f_section_number', 'int', 0);
$f_language_id = Input::Get('f_language_id', 'int', 0);
$f_language_selected = Input::Get('f_language_selected', 'int', 0);
$f_article_number = Input::Get('f_article_number', 'int', 0);

if (!Input::IsValid()) {
	camp_html_display_error(getGS('Invalid input: $1', Input::GetErrorString()), $_SERVER['REQUEST_URI'], true);
	exit;
}

if (!is_writable($Campsite['IMAGE_DIRECTORY'])) {
	camp_html_add_msg(getGS("Unable to add new image."));
	camp_html_add_msg(camp_get_error_message(CAMP_ERROR_WRITE_DIR, $Campsite['IMAGE_DIRECTORY']));
}

$articleObj = new Article($f_language_selected, $f_article_number);
$publicationObj = new Publication($f_publication_id);
$issueObj = new Issue($f_publication_id, $f_language_id, $f_issue_number);
$sectionObj = new Section($f_publication_id, $f_issue_number, $f_language_id, $f_section_number);

$ImageTemplateId = ArticleImage::GetUnusedTemplateId($f_article_number);

$q_now = $g_ado_db->GetOne("SELECT LEFT(NOW(), 10)");

include_once($GLOBALS['g_campsiteDir']."/$ADMIN_DIR/javascript_common.php");

camp_html_display_msgs();
?>
<script>
function checkAddForm(form) {
	retval = ((form.f_image_url.value != '') || (form.f_image_file.value != ''));
	if (!retval) {
	    alert('<?php putGS("You must select an image file to upload."); ?>');
	    return retval;
	}
	retval = retval && <?php camp_html_fvalidate(); ?>;
	return retval;
} // fn checkAddForm
</script>

<P>
<FORM NAME="image_add" METHOD="POST" ACTION="/<?php echo $ADMIN; ?>/articles/images/do_add.php" ENCTYPE="multipart/form-data" onsubmit="return checkAddForm(this);">
<?php echo SecurityToken::FormParameter(); ?>
<TABLE BORDER="0" CELLSPACING="0" CELLPADDING="0" class="box_table">
<TR>
	<TD COLSPAN="2">
		<B><?php  putGS("Add New Image"); ?></B>
		<HR NOSHADE SIZE="1" COLOR="BLACK">
	</TD>
</TR>
<TR>
	<TD ALIGN="RIGHT" ><?php  putGS("Number"); ?>:</TD>
	<TD>
	<INPUT TYPE="TEXT" NAME="f_image_template_id" VALUE="<?php p($ImageTemplateId); ?>" SIZE="5" class="input_text" alt="number|0" emsg="<?php putGS('Please enter a number for the image.'); ?>">
	</TD>
</TR>
<TR>
	<TD ALIGN="RIGHT" ><?php  putGS("Description"); ?>:</TD>
	<TD>
	<INPUT TYPE="TEXT" NAME="f_image_description" VALUE="Image <?php  p($maxId); ?>" SIZE="32" class="input_text" alt="blank" emsg="<?php putGS("Please enter a description for the image."); ?>">
	</TD>
</TR>
<TR>
	<TD ALIGN="RIGHT" ><?php  putGS("Photographer"); ?>:</TD>
	<TD>
	<INPUT TYPE="TEXT" NAME="f_image_photographer" SIZE="32" VALUE="<?php echo $g_user->getRealName(); ?>" class="input_text">
	</TD>
</TR>
<TR>
	<TD ALIGN="RIGHT" ><?php  putGS("Place"); ?>:</TD>
	<TD>
	<INPUT TYPE="TEXT" NAME="f_image_place" SIZE="32" class="input_text">
	</TD>
</TR>
<TR>
	<TD ALIGN="RIGHT" ><?php  putGS("Date"); ?>:</TD>
	<TD>
		<input type="text" name="f_image_date" value="<?php  p($q_now); ?>" class="input_text date" size="11" maxlength="10" />
	</TD>
</TR>
<TR>
	<TD ALIGN="RIGHT" ><?php putGS("URL"); ?>:</TD>
	<TD>
		<INPUT TYPE="TEXT" NAME="f_image_url" VALUE="" class="input_text" SIZE="32">
	</TD>
</TR>
<TR>
	<TD ALIGN="RIGHT" ><?php putGS("Image"); ?>:</TD>
	<TD>
		<INPUT TYPE="FILE" NAME="f_image_file" SIZE="32" class="input_file" alt="file|jpg,jpeg,jpe,gif,png,tif,tiff|bok" emsg="<?php putGS("You must select an image file to upload."); ?>">
	</TD>
</TR>
<TR>
	<TD COLSPAN="2">
	<DIV ALIGN="CENTER">
    <INPUT TYPE="HIDDEN" NAME="f_publication_id" VALUE="<?php  p($f_publication_id); ?>">
    <INPUT TYPE="HIDDEN" NAME="f_issue_number" VALUE="<?php  p($f_issue_number); ?>">
    <INPUT TYPE="HIDDEN" NAME="f_section_number" VALUE="<?php  p($f_section_number); ?>">
    <INPUT TYPE="HIDDEN" NAME="f_article_number" VALUE="<?php  p($f_article_number); ?>">
    <INPUT TYPE="HIDDEN" NAME="f_language_id" VALUE="<?php  p($f_language_id); ?>">
    <INPUT TYPE="HIDDEN" NAME="f_language_selected" VALUE="<?php  p($f_language_selected); ?>">
    <INPUT TYPE="HIDDEN" NAME="BackLink" VALUE="<?php  p($_SERVER['REQUEST_URI']); ?>">
<?php if (is_writable($Campsite['FILE_DIRECTORY'])) { ?>
	<INPUT TYPE="submit" NAME="Save" VALUE="<?php  putGS('Save'); ?>" class="button">
<?php } else { ?>
	<INPUT TYPE="button" NAME="Cancel" VALUE="<?php  putGS('Cancel'); ?>" class="button" onclick="window.close();">
<?php } ?>
	</DIV>
	</TD>
</TR>
</TABLE>
</FORM>
<script>
document.forms.image_add.f_image_template_id.focus();
</script>
<P>&nbsp;</P>
