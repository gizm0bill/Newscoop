<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

/**
 * Converts bbcodes to html
 *
 * @param string $input
 * @return string
 */
function smarty_modifier_bbcode($input)
{
    static $bbcode;

    if ($bbcode === null) {
        $bbcode = \Zend_Markup::factory('Bbcode');
    }

    return empty($input) ? $input : $bbcode->render($input);
}
