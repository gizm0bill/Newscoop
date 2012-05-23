<?php

function get_basel_zips()
{
    return array(
4000,
4001,
4002,
4003,
4004,
4005,
4007,
4008,
4009,
4010,
4011,
4012,
4013,
4015,
4016,
4017,
4018,
4019,
4020,
4024,
4025,
4030,
4031,
4032,
4033,
4034,
4035,
4039,
4041,
4051,
4052,
4053,
4054,
4055,
4056,
4057,
4058,
4059,
4065,
4070,
4075,
4078,
4080,
4081,
4082,
4083,
4084,
4085,
4086,
4087,
4088,
4089,
4091,
4092,
4093,
4094,
4095,
4096,
4125,
4126,
    );
}

function save_basic_rest_info($p_sqlFile, $p_restInfo)
{
    $sql_cre = 'CREATE TABLE rests_basic (
        id INTEGER PRIMARY KEY NOT NULL,
        real_name TEXT NOT NULL,
        url_name TEXT NOT NULL,
        address TEXT NOT NULL,
        zip TEXT NOT NULL,
        city TEXT NOT NULL,
        gaultmillau INT,
        latitude TEXT,
        longitude TEXT
    );
';

    $sql_ins = 'INSERT INTO rests_basic (id, real_name, url_name, address, zip, city, gaultmillau, latitude, longitude) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)';

    ;

}


function get_rests_access()
{
    return array(
        'api_key' => 'demo',
        'user' => 'demo',
        'password' => 'demo',
    );
}

function take_rest_info($p_action, $p_params, $p_json = false)
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

    if ($p_json) {
        return $response;
    }

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

function take_rests_by_zips($p_zipFile, $p_outFile)
{
    $zip_fh = fopen($p_zipFile, 'r');
    while (!feof($zip_fh)) {
        $one_line = trim(fgets($zip_fh));
        if ('' == $one_line) {
            continue;
        }
        if ('#' == substr($one_line, 0, 4)) {
            continue;
        }

        $res = take_rest_info('getRestaurantsByZipcode', array('zip_from' => $one_line, 'zip_to' => $one_line));

    }
    fclose($zip_fh);
}

function process_rests($p_jsonFile)
{
    $bas_zips = get_basel_zips();

    $in_string = '';

    $in_fh = fopen($p_jsonFile, 'r');
    if (!$in_fh) {
        return;
    }

    while (!feof($in_fh)) {
        $one_line = fgets($in_fh);
        $in_string .= $one_line;
    }
    fclose($in_fh);

    $in_data = json_decode($in_string, true);
//var_dump($in_data);
//return;

    $basel_count = 0;
    $unknown_count = 0;
    $other_count = 0;
    foreach ($in_data as $one_key => $one_rest) {
        if ('profiling' === $one_key) {
            $other_count += 1;
            continue;
        }

        if (!isset($one_rest['zip'])) {
            $unknown_count += 1;
            continue;
        }

        if (in_array($one_rest['zip'], $bas_zips)) {
            $basel_count += 1;
        }
    }
    //var_dump($unknown_count);
    var_dump($basel_count);
    var_dump(count($in_data) - $other_count);
}

process_rests('swiss_rests_all.json');

//$res = take_rest_info('getRestaurantsByZipcode', array('zip_from' => '0000', 'zip_to' => '9999'), true);
//echo $res;

//$res = take_rest_info('getRestaurantsByName', array('real_name' => 'Aarbergerhof'));

//$res = take_rest_info('getFullProfile', array('url_name' => 'aarbergerhof', 'response' => 'all'));

//var_dump($res);

?>
