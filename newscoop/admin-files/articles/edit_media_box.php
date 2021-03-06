<div class="articlebox" title="<?php putGS('Media'); ?>"><div class="tabs">
    <ul>
        <li><a href="#media-images"><?php putGS('Images'); ?></a></li>
        <li><a href="#media-attachments"><?php putGS('Files'); ?></a></li>
    </ul>
    <div id="media-images">
        <?php if ($inEditMode && $g_user->hasPermission('AttachImageToArticle')) { ?>
        <a class="iframe ui-state-default icon-button right-floated" href="<?php echo camp_html_article_url($articleObj, $f_language_id, "images/popup.php"); ?>"><span class="ui-icon ui-icon-plusthick"></span><?php putGS('Attach'); ?></a>
        <div class="clear"></div>
        <?php } ?>

        <ul class="block-list">
            <?php foreach ((array) $articleImages as $articleImage) {
                $image = $articleImage->getImage();
                $imageEditUrl = "/$ADMIN/articles/images/edit.php?f_publication_id=$f_publication_id&f_issue_number=$f_issue_number&f_section_number=$f_section_number&f_article_number=$f_article_number&f_image_id=".$image->getImageId()."&f_language_id=$f_language_id&f_language_selected=$f_language_selected&f_image_template_id=".$articleImage->getTemplateId();
                $detachUrl = "/$ADMIN/articles/images/do_unlink.php?f_publication_id=$f_publication_id&f_issue_number=$f_issue_number&f_section_number=$f_section_number&f_article_number=$f_article_number&f_image_id=".$image->getImageId()."&f_language_selected=$f_language_selected&f_language_id=$f_language_id&f_image_template_id=".$articleImage->getTemplateId().'&'.SecurityToken::URLParameter();
                $imageSize = getimagesize($image->getImageStorageLocation());
            ?>
            <li>
                <div class="image-thumbnail-container">
                    <?php if ($inEditMode) { ?>
                    <a href="<?php echo $imageEditUrl; ?>"><img src="<?php p($image->getThumbnailUrl()); ?>" /></a>
                    <?php } else { ?>
                    <img src="<?php p($image->getThumbnailUrl()); ?>" />
                    <?php } ?>
                </div>
                <strong><?php echo $articleImage->getTemplateId(); ?></strong><br />
                <?php echo htmlspecialchars($image->getDescription()); ?><br />
                <?php echo $imageSize[0], ' x ', $imageSize[1]; ?>

                <?php if (($inEditMode) && $g_user->hasPermission('AttachImageToArticle')) { ?>
                <a class="corner-button" href="<?php p($detachUrl); ?>" onclick="return confirm('<?php putGS("Are you sure you want to remove the image \\'$1\\' from the article?", camp_javascriptspecialchars($image->getDescription())); ?>');"><span class="ui-icon ui-icon-closethick"></span></a>
                <?php } ?>
            </li>
            <?php } ?>
        </ul>
    </div>

    <div id="media-attachments">
        <?php if ($inEditMode && $g_user->hasPermission('AddFile')) {  ?>
        <a class="iframe ui-state-default icon-button right-floated"
            href="<?php echo camp_html_article_url($articleObj, $f_language_id, "files/popup.php"); ?>"><span
            class="ui-icon ui-icon-plusthick"></span><?php putGS('Attach'); ?></a>
        <div class="clear"></div>
        <?php } ?>

        <ul class="block-list">
            <?php foreach ($articleFiles as $file) {
                $fileEditUrl = "/$ADMIN/articles/files/edit.php?f_publication_id=$f_publication_id&f_issue_number=$f_issue_number&f_section_number=$f_section_number&f_article_number=$f_article_number&f_attachment_id=".$file->getAttachmentId()."&f_language_id=$f_language_id&f_language_selected=$f_language_selected";
                $deleteUrl = "/$ADMIN/articles/files/do_del.php?f_publication_id=$f_publication_id&f_issue_number=$f_issue_number&f_section_number=$f_section_number&f_article_number=$f_article_number&f_attachment_id=".$file->getAttachmentId()."&f_language_selected=$f_language_selected&f_language_id=$f_language_id&".SecurityToken::URLParameter();
                $downloadUrl = $file->getAttachmentUrl()."?g_download=1";
                $previewUrl = null;
                if (strstr($file->getMimeType(), "image/") && (strstr($_SERVER['HTTP_ACCEPT'], $file->getMimeType()) ||
                                        (strstr($_SERVER['HTTP_ACCEPT'], "*/*")))) {
                $previewUrl = $Campsite['SUBDIR']."/attachment/".basename($file->getStorageLocation())."?g_show_in_browser=1";
                }
            ?>
            <li>
                <?php if ($inEditMode) { ?>
                <a class="text-link" href="<?php echo $fileEditUrl; ?>"><?php echo wordwrap($file->getFileName(), "25", "<br />", true); ?></a>
                <?php } else { ?>
                <?php echo wordwrap($file->getFileName(), "25", "<br />", true); ?>
                <?php } ?>

                <span class="info"><?php echo htmlspecialchars($file->getDescription($f_language_selected)), ', ', camp_format_bytes($file->getSizeInBytes()); ?></span>
                <a class="link icon-link" href="<?php p($downloadUrl); ?>"><span class="icon ui-icon-arrowthickstop-1-s"></span><?php putGS('Download'); ?></a>

                <?php if ($inEditMode && $g_user->hasPermission('DeleteFile')) { ?>
                <a class="corner-button" href="<?php p($deleteUrl); ?>" onclick="return confirm('<?php putGS("Are you sure you want to remove the file \\'$1\\' from the article?", camp_javascriptspecialchars($file->getFileName())); ?>');"><span class="ui-icon ui-icon-closethick"></span></a>
                <?php } ?>
            </li>
            <?php } ?>
    </div>
</div></div>
