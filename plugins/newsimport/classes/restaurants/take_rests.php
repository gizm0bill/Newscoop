<?php

/*
 * Restaurant article field types:
 *  number: uid, seats_in, seats_out, smoke, gaultmillau(may be 1 cipher precision), menu_template(?), socialmedia_status(?), preparation(bool?), menu(?)
 *  single line: url_name, real_name, address, zip, city, phone, email, homepage, country(?), lon, lat, fb_url, fb_id, twitteraccount, news, coupon_url,
 *               menucard_pdf, menucard_issuu, winecard_issuu, kidscard_issuu
 *  text: premium, seo_text, hours(multidate?), speciality(?)
 *
 *  topic: typology, ambiance, products, paymentmethods(?), services(?)
 *  images: avatar(?), img(?), images[e.g. 1281941757.jpg => http://files.lunchgate.ch/gastrouploads/472/c_1281941757.jpg (472 is uid)], panos [e.g. 533=> http://pano.lunchgate.ch/533/400x400.jpg]
 *  geo: lon, lat
 *
 */

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

/*
function assure_data_table($p_sqlFile, $p_tableName, $p_tableDef)
{
    ;
    ;
}
*/

function extract_lists($p_dbFile, $p_output, $p_listName)
{
    $sqlite_name = $p_dbFile;

    $list_items = array();

    $sel_req = 'SELECT profile FROM rests_single';

    @$db = new PDO ('sqlite:' . $sqlite_name);

    $stmt = $db->prepare($sel_req);
    $res = $stmt->execute();
    if ($res) {
        while (true) {
            $res = $stmt->fetch(PDO::FETCH_ASSOC);
            if (!$res) {
                break;
            }
            $rest_profile = $res['profile'];

            $rest_profile = json_decode($rest_profile, true);

            if ((!isset($rest_profile[$p_listName])) || (empty($rest_profile[$p_listName]))) {
                continue;
            }

            $rest_list = $rest_profile[$p_listName];
            foreach ($rest_list as $one_item) {
                $id_val = 0 + $one_item['id'];
                $title_val = $one_item['title'];
                if (!array_key_exists($id_val, $list_items)) {
                    $list_items[$id_val] = 'id:' . $id_val . ',title:' . $title_val;
                }
            }

        }
    }

    ksort($list_items);

    $list_string = implode("\n", $list_items);
    file_put_contents($p_output, $list_string);

}

function save_basic_rest_info($p_sqlFile, $p_restInfo)
{
    $table_name = 'rests_basic';

    $cre_req = 'CREATE TABLE IF NOT EXISTS ' . $table_name . ' (
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

    $ins_req = 'INSERT INTO ' . $table_name . ' (id, real_name, url_name, address, zip, city, gaultmillau, latitude, longitude) VALUES (:id, :real_name, :url_name, :address, :zip, :city, :gaultmillau, :latitude, :longitude)';

    //assure_data_table($p_sqlFile, $table_name, $sql_cre);

}

function save_single_rest_info($p_sqlFile, $p_restInfo)
{
    $sqlite_name = $p_sqlFile;
    $table_name = 'rests_single';

    $cre_req = 'CREATE TABLE IF NOT EXISTS ' . $table_name . ' (
        uid INTEGER PRIMARY KEY NOT NULL,
        url_name TEXT NOT NULL DEFAULT "",
        zip TEXT NOT NULL DEFAULT "",
        kanton TEXT NOT NULL DEFAULT "",
        profile TEXT NOT NULL DEFAULT ""
    );
';

    $ins_req = 'INSERT INTO ' . $table_name . ' (uid, url_name, zip, profile) VALUES (:uid, :url_name, :zip, :profile)';

    if ((!isset($p_restInfo['uid'])) || (!is_numeric($p_restInfo['uid']))) {
        return false;
    }

    @$db = new PDO ('sqlite:' . $sqlite_name);
    $stmt = $db->prepare($cre_req);
    $res = $stmt->execute();
    if (!$res) {
        return false;
    }

    $uid_value = 0 + $p_restInfo['uid'];
    $zip_value = (isset($p_restInfo['zip'])) ? trim('' . $p_restInfo['zip']) : '';
    $url_name = (isset($p_restInfo['url_name'])) ? trim('' . $p_restInfo['url_name']) : '';

    $stmt = $db->prepare($ins_req);
    $stmt->bindParam(':uid', $uid_value, PDO::PARAM_INT);
    $stmt->bindParam(':url_name', $url_name, PDO::PARAM_STR);
    $stmt->bindParam(':zip', $zip_value, PDO::PARAM_STR);
    $stmt->bindParam(':profile', json_encode($p_restInfo), PDO::PARAM_STR);

    $res = $stmt->execute();
    if (!$res) {
        return false;
    }

    return true;
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

function process_rests($p_jsonFile, $p_dbProfiles)
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

        if ((!isset($one_rest['url_name'])) || empty($one_rest['url_name'])) {
            continue;
        }

//var_dump($one_rest['url_name']);
        $res = take_rest_info('getFullProfile', array('url_name' => $one_rest['url_name'], 'response' => 'all'), false);
//var_dump($res);
        if ((!isset($res['result'])) || (empty($res['result']))) {
echo 'no data for: ' . $one_rest['url_name'];
var_dump($one_rest['url_name']);
            continue;
        }

        $data = $res['result'];
        $done = save_single_rest_info($p_dbProfiles, $data);
        if (!$done) {
echo 'not done for: ' . $one_rest['url_name'];
            continue;
        }

        //break; // debug
    }
    //var_dump($unknown_count);
    //var_dump($basel_count);
    //var_dump(count($in_data) - $other_count);
}

//process_rests('swiss_rests_all.json', 'rest_profiles.sqlite');
//process_rests('basel_rests_all.json', 'rest_profiles.sqlite');

extract_lists('rest_profiles.sqlite', 'cuisine_list.txt', 'typology');

//$res = take_rest_info('getRestaurantsByZipcode', array('zip_from' => '0000', 'zip_to' => '9999'), true);
//echo $res;

//$res = take_rest_info('getRestaurantsByName', array('real_name' => 'Aarbergerhof'));

//$res = take_rest_info('getFullProfile', array('url_name' => 'aarbergerhof', 'response' => 'all'));

//var_dump($res);

?>
