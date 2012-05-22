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
        echo('<script type="text/javascript" src="http://imagesrv.adition.com/js/secure_tag_head_ad1_adfarm1.js"></script><script type="text/javascript" src="http://imagesrv.adition.com/js/adition.js"></script><div id="adition_tag_520595"></div>');
        die;
    }
}
