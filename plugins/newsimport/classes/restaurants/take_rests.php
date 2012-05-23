<?php

function get_rests_access()
{
    return array(
        'api_key' => 'demo',
        'user' => 'demo',
        'password' => 'demo',
    );
}

function take_rest_info($p_action, $p_params)
{

    $access = get_rests_access();

    $command = 'http://www.lunchgate.ch/api/1_0/?api_key=' . urlencode($access['api_key']) . '&action=' . $p_action;
    if (!$p_params) {
        $p_params = array();
    }
    foreach ($p_params as $par_key => $par_value) {
        $command .= '&' . $par_key . '=' . urlencode($par_value);
    }

    $curlHandle = curl_init($command);
    
    curl_setopt($curlHandle, CURLOPT_HTTPAUTH, CURLAUTH_DIGEST);
    curl_setopt($curlHandle, CURLOPT_USERPWD, $access['user'] . ':' . $access['password']);

    curl_setopt($curlHandle, CURLOPT_HTTPHEADER, array ('Accept: application/json'));
    curl_setopt($curlHandle, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($curlHandle, CURLOPT_BINARYTRANSFER, true);
    curl_setopt($curlHandle, CURLOPT_NOSIGNAL, true);
    curl_setopt($curlHandle, CURLOPT_TIMEOUT_MS, 5000);

    $response = curl_exec($curlHandle);
    curl_close($curlHandle);

    try {
        $response = json_decode($response, true);
    }
    catch (Exception $exc) {
        $response = false;
    }

    if (false === $response) {
        return array(
            'success' => false,
        );
    }

    return array(
        'success' => true,
        'result' => $response,
    );

}

//$res = take_rest_info('getRestaurantsByName', array('real_name' => 'Aarbergerhof'));

$res = take_rest_info('getFullProfile', array('url_name' => 'aarbergerhof', 'response' => 'all'));

var_dump($res);

?>
