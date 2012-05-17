<?php
/**
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

/**
 * Get weather
 *
 * @param array $params
 * @param Smarty_Internal_Template $smarty
 * @return string
 */
function smarty_function_weather(array $params, Smarty_Internal_Template $smarty)
{
    $hour = date('H');
    $temperature = \SystemPref::get('weather_temperature_'.$hour);
    $icon = \SystemPref::get('weather_icon_'.$hour);
    
    $result = '<span class="'.$icon.'">'.$temperature.'°C Basel</span>';
    
    return($result);
}
