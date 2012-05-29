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

class RestaurantsLoader {

    var $m_region_info = null;

    var $m_sleep_on_request = 0;

    var $m_auxiliary_db_name = '';
    var $m_simple_db_name = '';
    var $m_single_db_name = '';

    var $m_auxiliary_table_name = '';
    var $m_simple_table_name = '';
    var $m_single_table_name = '';

    /**
     * constructor
     * @param array $p_conf
     *
     * @return void
     */
    public function __construct($p_conf = null)
    {
        if (empty($p_conf)) {
            $p_conf = array();
        }

        $class_dir = dirname(dirname(__FILE__));
        require_once($class_dir .DIRECTORY_SEPARATOR. 'RegionInfo.php');

        $this->m_region_info = new RegionInfo();

        if (isset($p_conf['req_sleep'])) {
            $m_sleep_on_request = $p_conf['req_sleep'];
        }

        $this->m_auxiliary_db_name = (isset($p_conf['auxiliary_db'])) ? $p_conf['auxiliary_db'] : '';
        $this->m_simple_db_name = (isset($p_conf['simple_db'])) ? $p_conf['simple_db'] : '';
        $this->m_single_db_name = (isset($p_conf['single_db'])) ? $p_conf['single_db'] : '';

        $this->m_auxiliary_table_name = (isset($p_conf['auxiliary_table'])) ? $p_conf['auxiliary_table'] : '';
        $this->m_simple_table_name = (isset($p_conf['simple_table'])) ? $p_conf['simple_table'] : '';
        $this->m_single_table_name = (isset($p_conf['single_table'])) ? $p_conf['single_table'] : '';

        // assure dbs && tables exist
        $this->assure_tables();

        set_time_limit(0);
    } // fn __construct


    private function get_rests_access()
    {
        return array(
            'api_key' => 'demo',
            'user' => 'demo',
            'password' => 'demo',
        );
    }

    private function take_rest_info($p_action, $p_params, $p_json = false)
    {

        $access = $this->get_rests_access();

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

    private function assure_tables()
    {
        $sqlite_names = array('auxiliary' => $this->m_auxiliary_db_name, 'simple' => $this->m_simple_db_name, 'single' => $this->m_single_db_name);
        $table_names = array('auxiliary' => $this->m_auxiliary_table_name, 'simple' => $this->m_simple_table_name, 'single' => $this->m_single_table_name);

        $cre_reqs = array();

        $cre_reqs['auxiliary'] = 'CREATE TABLE IF NOT EXISTS ' . $table_names['auxiliary'] . ' (
            var TEXT PRIMARY KEY NOT NULL,
            value TEXT NOT NULL DEFAULT ""
        )';

        $cre_reqs['simple'] = 'CREATE TABLE IF NOT EXISTS ' . $table_names['simple'] . ' (
            uid INTEGER PRIMARY KEY NOT NULL,
            url_name TEXT UNIQUE NOT NULL,
            real_name TEXT NOT NULL DEFAULT "",
            address TEXT NOT NULL DEFAULT "",
            zip TEXT NOT NULL DEFAULT "",
            city TEXT NOT NULL DEFAULT "",
            gaultmillau INT,
            latitude TEXT NOT NULL DEFAULT "",
            longitude TEXT NOT NULL DEFAULT "",
            status TEXT NOT NULL DEFAULT "new"
        );';

        $cre_reqs['single'] = 'CREATE TABLE IF NOT EXISTS ' . $table_names['single'] . ' (
            uid INTEGER PRIMARY KEY NOT NULL,
            url_name TEXT NOT NULL DEFAULT "",
            zip TEXT NOT NULL DEFAULT "",
            kanton TEXT NOT NULL DEFAULT "",
            profile TEXT NOT NULL DEFAULT "",
            status TEXT NOT NULL DEFAULT "new"
        );';

        $success = true;
        foreach (array('simple', 'single') as $one_type) {

            @$db = new PDO ('sqlite:' . $sqlite_names[$one_type]);
            $stmt = $db->prepare($cre_reqs[$one_type]);
            $res = $stmt->execute();
            if (!$res) {
                $success = false;
            }

        }

        return $success;
    }

    private function load_last_min()
    {
        $last_min = 0;
        $table_name = $this->m_auxiliary_table_name;
        $sqlite_name = $this->m_auxiliary_db_name;

        $sel_req = 'SELECT value FROM ' . $table_name . ' WHERE var="last_min_taken"';

        @$db = new PDO ('sqlite:' . $sqlite_name);
        $stmt = $db->prepare($sel_req);
        $res = $stmt->execute();
        if (!$res) {
            $success = false;
        }

        if ($res) {
            while (true) {
                $res = $stmt->fetch(PDO::FETCH_ASSOC);
                if (!$res) {
                    break;
                }
                $last_min = $res['value'];
            }
        }

        return $last_min;
    }

    private function save_last_min($p_lastMin)
    {
        $table_name = $this->m_auxiliary_table_name;
        $sqlite_name = $this->m_auxiliary_db_name;

        $upd_req = 'INSERT OR REPLACE INTO ' . $table_name . ' (var, value) VALUES ("last_min_taken", :value)';

        @$db = new PDO ('sqlite:' . $sqlite_name);
        $stmt = $db->prepare($upd_req);
        $stmt->bindParam(':value', '' . $p_lastMin, PDO::PARAM_STR);
        $res = $stmt->execute();
        if (!$res) {
            $success = false;
        }

        return true;
    }

    private function load_all_zips_list()
    {
        //$table_name = 'rests_basic';
        $table_name = $this->m_simple_table_name;
        $sqlite_name = $this->m_simple_db_name;

        $read_rests = array();

        $sel_req = 'SELECT uid, url_name, real_name, address, zip, city, gaultmillau, latitude, longitude, status FROM ' . $table_name . ' WHERE status != "prune"';
        $simple_keys = array('uid', 'url_mname', 'real_name', 'url_name', 'address', 'zip', 'city', 'gaultmillau', 'latitude', 'longitude', 'status');

        @$db = new PDO ('sqlite:' . $sqlite_name);

        $stmt = $db->prepare($sel_req);
        $res = $stmt->execute();
        if ($res) {
            while (true) {
                $res = $stmt->fetch(PDO::FETCH_ASSOC);
                if (!$res) {
                    break;
                }
                $one_simple = array();
                foreach ($simple_keys as $one_key) {
                    $one_simple[$one_key] = $res[$one_key];
                }
                $read_rests[$res['uid']] = $one_simple;
            }
        }

        return $read_rests;
    }


    private function save_simple_rest_info($p_restInfo)
    {
        //$table_name = 'rests_basic';
        $table_name = $this->m_simple_table_name;
        $sqlite_name = $this->m_simple_db_name;

        $ins_req = 'INSERT OR REPLACE INTO ' . $table_name . ' (uid, url_name, real_name, address, zip, city, gaultmillau, latitude, longitude, status) VALUES (:uid, :url_name, :real_name, :address, :zip, :city, :gaultmillau, :latitude, :longitude, :status)';

        if (empty($p_restInfo)) {
            return false;
        }

        if (!isset($p_restInfo['status'])) {
            $p_restInfo['status'] = 'new';
        }

        @$db = new PDO ('sqlite:' . $sqlite_name);

        $stmt = $db->prepare($ins_req);
        $stmt->bindParam(':uid', $p_restInfo['uid'], PDO::PARAM_INT);
        $stmt->bindParam(':url_name', $p_restInfo['url_name'], PDO::PARAM_STR);
        $stmt->bindParam(':real_name', $p_restInfo['real_name'], PDO::PARAM_STR);
        $stmt->bindParam(':address', $p_restInfo['address'], PDO::PARAM_STR);
        $stmt->bindParam(':zip', $p_restInfo['zip'], PDO::PARAM_STR);
        $stmt->bindParam(':city', $p_restInfo['city'], PDO::PARAM_STR);
        $stmt->bindParam(':gaultmillau', $p_restInfo['gaultmillau'], PDO::PARAM_STR);
        $stmt->bindParam(':latitude', $p_restInfo['latitude'], PDO::PARAM_STR);
        $stmt->bindParam(':longitude', $p_restInfo['longitude'], PDO::PARAM_STR);
        $stmt->bindParam(':status', $p_restInfo['status'], PDO::PARAM_STR);

        $res = $stmt->execute();
        if (!$res) {
            return false;
        }

        return true;
    }

    private function save_single_rest_info($p_restInfo)
    {
        //$table_name = 'rests_single';
        $table_name = $this->m_single_table_name;
        $sqlite_name = $this->m_single_db_name;


        $ins_req = 'INSERT OR REPLACE INTO ' . $table_name . ' (uid, url_name, zip, profile) VALUES (:uid, :url_name, :zip, :profile)';

        if ((!isset($p_restInfo['uid'])) || (!is_numeric($p_restInfo['uid']))) {
            return false;
        }

        @$db = new PDO ('sqlite:' . $sqlite_name);

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

    public function set_simple_status($p_urlName, $p_satuts)
    {
        //$table_name = 'rests_simple';
        $table_name = $this->m_simple_table_name;
        $sqlite_name = $this->m_simple_db_name;

        $upd_req = 'UPDATE ' . $table_name . ' SET status=:status WHERE url_name=:url_name';

        @$db = new PDO ('sqlite:' . $sqlite_name);
        $stmt = $db->prepare($upd_req);
        $stmt->bindParam(':url_name', $p_urlName, PDO::PARAM_STR);
        $stmt->bindParam(':status', $p_status, PDO::PARAM_STR);

        $res = $stmt->execute();
        if (!$res) {
            return false;
        }

        return true;
    }

    public function set_single_status($p_urlName, $p_satuts)
    {
        //$table_name = 'rests_single';
        $table_name = $this->m_single_table_name;
        $sqlite_name = $this->m_single_db_name;

        $upd_req = 'UPDATE ' . $table_name . ' SET status=:status WHERE url_name=:url_name';

        @$db = new PDO ('sqlite:' . $sqlite_name);
        $stmt = $db->prepare($upd_req);
        $stmt->bindParam(':url_name', $p_urlName, PDO::PARAM_STR);
        $stmt->bindParam(':status', $p_status, PDO::PARAM_STR);

        $res = $stmt->execute();
        if (!$res) {
            return false;
        }

        return true;
    }

    private function load_simple_below($p_upperBound, $p_countToTake)
    {
        $table_name = $this->m_simple_table_name;
        $sqlite_name = $this->m_simple_db_name;

        $read_rests = array();

        //$sel_req_common_start = 'SELECT uid, url_name, real_name, address, zip, city, gaultmillau, latitude, longitude, status FROM ' . $table_name . ' ';
        $sel_req_common_start = 'SELECT url_name FROM ' . $table_name . '  WHERE status != "new" ';

        $limit = 0;
        if (is_numeric($p_countToTake)) {
            $limit = 0 + $p_countToTake;
        }
        $sel_req_below = ' AND uid < :uid ORDER BY uid DESC LIMIT ' . $limit;
        $sel_req_top = ' ORDER BY uid DESC LIMIT ' . $limit;
        $sel_req_all = $sel_req_common_start . ' ORDER BY uid DESC';


        @$db = new PDO ('sqlite:' . $sqlite_name);

        $requests = array();

        if (empty($p_countToTake)) {
            $requests[] = array('req' => $sel_req_all, 'bind' => array());
        }
        else {
            $requests[] = array('req' => $sel_req_below, 'bind' => array(
                array('var' => ':uid', 'value' => $p_upperBound, 'type' => PDO::PARAM_INT),
            ));
            $requests[] = array('req' => $sel_req_top, 'bind' => array());
        }

        foreach ($requests as $sel_info) {
            $stmt = $db->prepare($sel_info['req']);
            foreach ($sel_info['bind'] as $one_param) {
                $stmt->bindParam($one_param['var'], $one_param['value'], $one_param['type']);
            }

            $res = $stmt->execute();
            if ($res) {
                while (true) {
                    $res = $stmt->fetch(PDO::FETCH_ASSOC);
                    if (!$res) {
                        break;
                    }
                    //$one_single = array();
                    //foreach ($single_keys as $one_key) {
                    //    $one_single[$one_key] = $res[$one_key];
                    //}
                    //$read_rests[] = $one_single;
                    $read_rests[] = $res['url_name'];
                }
            }

            if ($limit && (count($read_rests) >= $limit)) {
                break;
            }
        }

        return $read_rests;
    }

    private function load_simple_new()
    {
        $table_name = $this->m_simple_table_name;
        $sqlite_name = $this->m_simple_db_name;

        $read_rests = array();

        $sel_req = 'SELECT url_name FROM ' . $table_name . '  WHERE status = "new"';

        @$db = new PDO ('sqlite:' . $sqlite_name);
        $res = $stmt->execute();
        if ($res) {
            while (true) {
                $res = $stmt->fetch(PDO::FETCH_ASSOC);
                if (!$res) {
                    break;
                }
                $read_rests[] = $res['url_name'];
            }
        }

        return $read_rests;
    }

    public function load_single_by_status($p_status) // used for 'new' to put into articles, 'prune' to delete articles of abandoned restaurants
    {
        //$table_name = 'rests_single';
        $table_name = $this->m_single_table_name;
        $sqlite_name = $this->m_single_db_name;

        $sel_req = 'SELECT uid, url_name, zip, profile FROM ' . $table_name . ' WHERE status=:status';

        $single_keys = array('uid', 'url_name', 'zip', 'profile');
        $read_rests = array();

        @$db = new PDO ('sqlite:' . $sqlite_name);
        $stmt = $db->prepare($sel_req);
        $stmt->bindParam(':status', $p_status, PDO::PARAM_STR);

        $res = $stmt->execute();
        if ($res) {
            while (true) {
                $res = $stmt->fetch(PDO::FETCH_ASSOC);
                if (!$res) {
                    break;
                }
                $one_single = array();
                foreach ($single_keys as $one_key) {
                    $one_single[$one_key] = $res[$one_key];
                }
                $read_rests[$res['uid']] = $one_single;
            }
        }

        return $read_rests;
    }

    public function prune_abandoned()
    {
        $success = true;

        $table_name = $this->m_simple_table_name;
        $sqlite_name = $this->m_simple_db_name;

        $del_req = 'DELETE FROM ' . $table_name . ' WHERE status="prune"';

        @$db = new PDO ('sqlite:' . $sqlite_name);
        $stmt = $db->prepare($del_req);
        $res = $stmt->execute();
        if (!$res) {
            $success = false;
        }

        $table_name = $this->m_single_table_name;
        $sqlite_name = $this->m_single_db_name;

        $del_req = 'DELETE FROM ' . $table_name . ' WHERE status="prune"';

        @$db = new PDO ('sqlite:' . $sqlite_name);
        $stmt = $db->prepare($del_req);
        $res = $stmt->execute();
        if (!$res) {
            $success = false;
        }

        return $success;
    }


    public function process_single_rests()
    {
        // first take a dose of old restaurant data, to update that if some changes there
        $count_to_take = $this->$m_one_dose_count;
        $upper_bound = $this->load_last_min();
        if (empty($count_to_take) || (0 > $count_to_take)) {
            $count_to_take = 0;
            $upper_bound = 0;
        }
        $last_uid_taken = 0;
        //while (true) {
            $url_names = $this->load_simple_below($upper_bound, $count_to_take); // should add data from the greatest uids if not enough below
            foreach ($url_names as $one_single_name) {
                if ($count_to_take) {
                    $count_to_take -= 1;
                }

                $single_res = $this->take_rest_info('getFullProfile', array('url_name' => $one_single_name, 'response' => 'all'), false);
                if (0 < $this->m_sleep_on_request) {
                    sleep($this->m_sleep_on_request);
                }
                if ((!isset($single_res['result'])) || (empty($single_res['result']))) {
                    continue;
                }

                $single_data = $single_res['result'];
                $single_data['status'] = 'new';
                $single_done = $this->save_single_rest_info($single_data);
                if (!$single_done) {
                    continue;
                }
                $this->set_simple_status($one_single_name, 'read');
                $last_uid_taken = $single_data['uid'];

            }
            //if (!$count_to_take) {
            //    break;
            //}
        //}
        $this->save_last_min($last_uid_taken);

        // second take new (or changed even at the simple data) restaurants
        $url_names = $this->load_simple_new();
        foreach ($url_names as $one_single_name) {

            $single_res = $this->take_rest_info('getFullProfile', array('url_name' => $one_single_name, 'response' => 'all'), false);
            if (0 < $this->m_sleep_on_request) {
                sleep($this->m_sleep_on_request);
            }
            if ((!isset($single_res['result'])) || (empty($single_res['result']))) {
                continue;
            }

            $single_data = $single_res['result'];
            $single_data['status'] = 'new';
            $single_done = $this->save_single_rest_info($single_data);
            if (!$single_done) {
                continue;
            }
            $this->set_simple_status($one_single_name, 'read');

        }

    }


    public function update_simple_list()
    {

        $data_old = $this->load_all_zips_list(); // without those with prune flag set on

        // the '0000' is used for a test restaurant by Lunchgate
        $data_new = $this->take_rest_info('getRestaurantsByZipcode', array('zip_from' => '0001', 'zip_to' => '9999'), false);
        if (empty($data_new)) {
            $data_new = array();
        }

        $simple_keys = array('uid', 'url_name', 'real_name', 'address', 'zip', 'city', 'gaultmillau', 'latitude', 'longitude');
        foreach ($data_new as $one_rank => $one_rest) {
            if ('profiling' === $one_rank) {
                continue;
            }

            if (empty($one_rest)) {
                continue;
            }

            if ((!isset($one_rest['uid'])) || (empty($one_rest['uid']))) {
                continue;
            }

            $is_new = true;

            $one_uid = $one_rest['uid'];
            $old_simple = null;
            if (array_key_exists($one_uid, $data_old)) {
                $is_new = false;
                $one_old_simple = $data_old[$one_uid];
                foreach ($simple_keys as $one_key) {
                    if (!isset($one_rest[$one_key])) {
                        $one_rest[$one_key] = '';
                    }
                    if (empty($one_rest[$one_key]) && (!empty($one_old_simple[$one_key]))) {
                        $is_new = true;
                        break;
                    }
                    if (!empty($one_rest[$one_key]) && (empty($one_old_simple[$one_key]))) {
                        $is_new = true;
                        break;
                    }
                    if (!empty($one_rest[$one_key]) && (!empty($one_old_simple[$one_key])) && ($one_rest[$one_key] != $one_old_simple[$one_key])) {
                        $is_new = true;
                        break;
                    }
                }
                unset($data_old[$one_uid]);
            }

            if ($is_new) {
                $one_rest['status'] = 'new';
                $this->save_simple_rest_info($one_rest);
            }
        }


        foreach ($data_old as $rest_uid => $rest_basic) {
            //$this->set_single_to_prune($rest_uid);
            $this->set_simple_status($url_name, 'prune');
            $this->set_single_status($url_name, 'prune');
        }

    }




    // auxiliary thing for taking the possible values of 'cuisine' and alike
    public function extract_lists($p_output, $p_listName)
    {
        $table_name = $this->m_single_table_name;
        $sqlite_name = $this->m_single_db_name;

        $list_items = array();

        $sel_req = 'SELECT profile FROM ' . $table_name;

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

    // simple auxiliary
    private function get_basel_zips()
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


} // class RestaurantsLoader



//process_rests('swiss_rests_all_new.json', 'rest_profiles_swiss.sqlite');
//process_rests('swiss_rests_all.json', 'rest_profiles.sqlite');
//process_rests('basel_rests_all.json', 'rest_profiles.sqlite');

//extract_lists('rest_profiles_swiss.sqlite', 'cuisine_list_swiss.txt', 'typology');
//extract_lists('rest_profiles_swiss.sqlite', 'ambiance_list_swiss.txt', 'ambiance');

//$res = take_rest_info('getRestaurantsByZipcode', array('zip_from' => '0000', 'zip_to' => '9999'), true);
//echo $res;

//$res = take_rest_info('getRestaurantsByName', array('real_name' => 'Aarbergerhof'));

//$res = take_rest_info('getFullProfile', array('url_name' => 'aarbergerhof', 'response' => 'all'));
//var_dump($res);

?>
