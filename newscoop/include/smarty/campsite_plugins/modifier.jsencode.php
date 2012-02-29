<?php
/**
 * Smarty plugin
 * @package Smarty
 * @subpackage plugins
 */


/**
 * Smarty jsencode modifier plugin
 *
 * Type:     modifier<br>
 * Name:     truncate<br>
 * Purpose:  Trim whitespace, encode, and optionally strip tages in string.
 * @author Sebastian G�bel <sebastian.goebel at sourcefabric dot org>
 * @param string
 * @param boolean
 * @param boolean
 * @return string
 */

function smarty_modifier_jsencode($string, $addslashes = false, $keep_tags = '<h4><b><i><em><strong><br><p><a><img>')
{
  if ($keep_tags) {
    $string = strip_tags($string, $keep_tags);
  }
  
  if ($addslashes) {
    $string = addslashes($string);
  }
  
  $string = substr(json_encode($string, JSON_HEX_APOS|JSON_HEX_QUOT), 1, -1);

  return $string;
} // smarty_modifier_jsencode

?>
