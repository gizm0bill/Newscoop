<?php
/**
 * @package Newscoop
 * @copyright 2011 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

/**
 */
class CustomContentController extends Zend_Controller_Action
{
    public function backpageAdvertisementAction()
    {
        echo('<html><head><script type="text/javascript" src="http://imagesrv.adition.com/js/secure_tag_head_ad1_adfarm1.js"></script></head>');
        echo('<body><!-- BEGIN ADITIONTAG -->');
        echo('<script type="text/javascript" src="http://imagesrv.adition.com/js/adition.js"></script>');
        echo('<div id="adition_tag_520595"></div>');
        echo('<!-- END ADITIONTAG --><script type="text/javascript" src="http://imagesrv.adition.com/js/secure_tag_before_body_end.js"></script></body></html>');
        die;
    }
}
