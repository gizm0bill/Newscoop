<?php

require_once(dirname(__FILE__).DIRECTORY_SEPARATOR.'FileLoad.php');

/**
 * RestaurantData Importer class for managing parsing of RestaurantData files.
 */
class RestaurantData_Parser {
/*

I) Loading data from Lunchgate.ch
    A) Asking for restaurants from all zip codes, saving into simple_info DB / once daily should be ok
        * new restaurants set as to be loaded
        * removed restaurants set to be pruned
    B) Asking for full info on single restaurants, saving into single_info DB / we should split the loading into e.g. 50 restaurants per day, then it is updated in (shorter time than) 1 month
        * apart of daily interval, the 'new' restaurants are loaded

II)
    A) Article creation / daily
        * loading all data, where saved flag not set
    B) Pruning
        * removing restaurants with prune flag set on

*/

/*
    $m_rests_loaders = new RestaurantsLoader();

    private function take_day_range()
    {
        $last_max_id = RestaurantsLoader::take_last_max_id();

        return array(
            'start_id' => $last_max_id + 1,
            'count' => 50,
            'sleep' => 1,
        );
    }

    public function prepare_rests_data() // the I) part above
    {
        $this->take_rests_info_basic(); // the I) A) part above
        $this->take_rests_info_single(); // the I) B) part above
    }

    public function take_rests_info_basic()
    {
        $data_old = $m_rests_loaders::read_all_zips_list(); // without those with prune flag set on

        $data_new = $m_rests_loaders::take_all_zips_list();

        foreach ($data_new as $rest_uid => $rest_basic) {
            $this->update_single_info($rest_uid, $rest_basic, 'basic');

            if (array_key_exists($rest_uid, $data_old)) {
                unset($data_old[$rest_uid]);
                continue;
            }
            $this->set_rest_new($rest_uid); // incl. removing a possible prune flag from the past
        }

        foreach ($data_old as $rest_uid => $rest_basic) {
            $this->set_to_prune($rest_uid);
        }
    }

    public function take_rests_info_single()
    {
        $data = RestaurantsLoader::take_single_rests($this->take_day_range()); // stores the data, set status as new

        ;
    }


    public function load_ready_data() // the II) A) part above
    {
        $data_to_save = RestaurantsLoader::load_non_saved_rests(); // stores the data, set status as new

        $rests_data = array();
        foreach ($data_to_save as $one_rest) {

            $single_rest_info = array(
                'event_id' => $one_rest['uid'],
                'tour_id' => $one_rest['uid'],
                'location_id' => $one_rest['uid'],

                'uses_multidates' => true,

                'headline' => '',
            );

            $rests_data[] = $single_rest_info;

        }

        return $rests_data();
    }
*/


    /**
     * What is this.
     * @var array
     */
    var $m_source = null;

    /**
     * Where to take this.
     * @var array
     */
    var $m_dirs = null;

    /**
     * Who provides this.
     * @var integer
     */
    var $m_provider = null;

    /**
     * Mode of (possibly) created directories.
     * @var integer
     */
    var $m_dirmode = 0755;

    /**
     * Suffix parts for json data files
     * @var array
     */
    var $m_saved_parts = array('dif' => 'cin_dif', 'all' => 'cin_set');

    /**
     * constructor
     * @param array $p_source
     *
     * @return void
     */
    public function __construct($p_source)
    {
        $this->m_source = $p_source;
        $this->m_dirs = $p_source['source_dirs'];
        $this->m_provider = $p_source['provider_id'];
    } // fn __construct

	/**
	 * (re)moves files after parsing && importing
	 *
	 * @return bool
	 */
    public function cleanup()
    {
        // moving all the files from the interim into the old dir
        $dir_handle = null;
        try {
            $dir_handle = opendir($this->m_dirs['use']);
        }
        catch (Exception $exc) {
            return false;
        }

        if (!$dir_handle) {
            return false;
        }

        while (false !== ($event_file = readdir($dir_handle))) {
            $one_use_path = $this->m_dirs['use'] . DIRECTORY_SEPARATOR . $event_file;
            $one_old_path = $this->m_dirs['old'] . DIRECTORY_SEPARATOR . $event_file;

            if (!is_file($one_use_path)) {
                continue;
            }

            try {
                rename($one_use_path, $one_old_path);
            }
            catch (Exception $exc) {
                continue;
            }
        }
        closedir($dir_handle);

        return true;
    } // fn cleanup

	/**
	 * prepares files for the parsing
     *
     * @param array $p_categories
     * @param array $p_limits
     * @param array $p_cancels
	 *
	 * @return bool
	 */
    public function prepare($p_categories, $p_limits, $p_cancels, $p_env, $p_regionObj, $p_regionTopics)
    {
/*
        // we need that conf info
        if ((!isset($this->m_dirs['source'])) || (!isset($this->m_dirs['source']['programs']))) {
            return false;
        }
        if ((!isset($this->m_dirs['source']['movies'])) || (!isset($this->m_dirs['source']['genres'])) || (!isset($this->m_dirs['source']['timestamps']))) {
            return false;
        }
*/
        foreach (array($this->m_dirs['use'], /*$this->m_dirs['new'],*/ $this->m_dirs['old']) as $one_dir) {
            if (!is_dir($one_dir)) {
                try {
                    $created = mkdir($one_dir, $this->m_dirmode, true);
                    if (!$created) {
                        return false;
                    }
                }
                catch (Exception $exc) {
                    return false;
                }
            }
        }

        $rests_dir = $this->m_dirs['old'];
        if ( isset($p_env['cache_dir']) && (!empty($p_env['cache_dir'])) ) {
            $rests_dir = $p_env['cache_dir'];
        }

        $cur_time = date('YmdHis');

        // first take and process/store restaurants data,
        // this is an addition wrt the general event import

        $taker_conf = array(
            'auxiliary_db' => $rests_dir . 'restaurants_auxiliary.sqlite',
            'simple_db' => $rests_dir . 'restaurants_simple.sqlite',
            'single_db' => $rests_dir . 'restaurants_single.sqlite',
            'auxiliary_table' => 'settings',
            'simple_table' => 'rests_simple',
            'single_table' => 'rests_single',
            'req_sleep' => 1, // this should be taken from a conf
        );

        $rests_dir = dirname(__FILE__) .DIRECTORY_SEPARATOR. 'restaurants';
        require_once($rests_dir .DIRECTORY_SEPARATOR. 'take_rests.php');

        $rest_taker = new RestaurantsLoader($taker_conf);

        $rest_taker->update_simple_list();
        $rest_taker->process_single_rests();

        $rests_data = $rest_taker->load_single_by_status('new');

        // to put prepared things into a file
        $rests_json = json_encode($rests_data);

        $storage_file_name = $this->m_dirs['use'] . $cur_time . '-' . 'lunchgate_dose.data';
        file_put_contents($storage_file_name, $rests_json);

        $parser = new RestaurantData_Parser_Simple($p_regionObj, $p_regionTopics);
        $rests_data = $parser->prepareRestaurantsEvents(array($storage_file_name), $this->m_provider, $p_categories, $p_limits['past'], $p_limits['next'], null);

        // store the processed $rests_data

        return true;


    } // fn prepare

    /**
     * Loads current or old parsed data
     *
     * @param bool $p_old
     *
     * @return array
     */
    public function load($p_old = false) {

        $dir_type = 'use';
        $set_type = $this->m_saved_parts['dif'];
        if ($p_old) {
            $dir_type = 'old';
            $set_type = $this->m_saved_parts['all'];
        }

        $dir_handle = null;
        try {
            $dir_handle = opendir($this->m_dirs[$dir_type]);
        }
        catch (Exception $exc) {
            return false;
        }

        $search_dir = $this->m_dirs[$dir_type];
        if ( DIRECTORY_SEPARATOR != substr($search_dir, (strlen($search_dir) - strlen(DIRECTORY_SEPARATOR))) ) {
            $search_dir .= DIRECTORY_SEPARATOR;
        }

        $datetime_length = 14;
        $proc_files = array();
        $proc_files_gzipped = array();
        if ($dir_handle) {
            while (false !== ($event_file = readdir($dir_handle))) {

                $event_file_path = $search_dir . $event_file;

                if (!is_file($event_file_path)) {
                    continue;
                }

                $event_file_base_arr = explode('.', $event_file);
                if ((3 == count($event_file_base_arr)) && ('gz' == strtolower($event_file_base_arr[2]))) {
                    $event_file_base_arr = array_slice($event_file_base_arr, 0, 2);
                    $proc_files_gzipped[$event_file_path] = true;
                }

                if (2 != count($event_file_base_arr)) {
                    continue;
                }
                if ('json' != strtolower($event_file_base_arr[count($event_file_base_arr) - 1])) {
                    continue;
                }
                if (strlen($event_file_base_arr[0]) != ($datetime_length + strlen($set_type) + 1)) {
                    continue;
                }
                $event_file_name_arr = explode('-', $event_file_base_arr[0]);
                if (2 != count($event_file_name_arr)) {
                    continue;
                }
                if ($set_type != $event_file_name_arr[1]) {
                    continue;
                }
                if (!is_numeric($event_file_name_arr[0])) {
                    continue;
                }

                $proc_files[] = $event_file_path;
            }
            closedir($dir_handle);
        }

        if (!$p_old) {
            sort($proc_files); // the newest as last to overwrite other ones, for the current
        }
        else {
            if (0 < count($proc_files)) {
                rsort($proc_files); // just the newest one, for the passed
                $proc_files = array($proc_files[0]);
            }
        }

        $events = array();

        foreach ($proc_files as $one_proc_file) {
            if (isset($proc_files_gzipped[$one_proc_file]) && $proc_files_gzipped[$one_proc_file]) {
                $one_proc_file = 'compress.zlib://' . $one_proc_file;
            }

            $one_json = null;
            try {
                $one_json_string = @file_get_contents($one_proc_file);
                if (false !== $one_json_string) {
                    $one_json = json_decode($one_json_string, true);
                    foreach ($one_json as $event_id => $event_info) {
                        if ($p_old) {
                            $event_info = json_encode($event_info);
                        }
                        $events[$event_id] = $event_info;
                    }
                }
            }
            catch (Exception $exc) {
            }
        }
        return $events;
    } // fn load


} // class RestaurantData_Parser

/**
 * RestaurantData Parser.
 */
class RestaurantData_Parser_Simple {

    /**
     * Storage of loaded events of last data dosis
     * @var mixed
     */
    var $m_last_events = null;

    /**
     * Name of table where the movies info are stored
     * @var string
     */
    //var $m_table_name = 'movies';

    /**
     * Specification string of poster images
     * @var string
     */
    //var $m_poster_spec = 'artw';

    var $m_region_info = array();
    var $m_region_topics = array();

    public function __construct($p_regionInfo, $p_regionTopics)
    {
        $this->m_region_info = $p_regionInfo;
        $this->m_region_topics = $p_regionTopics;
    }

    /**
     * Setter of the last used data dosis
     *
     * @param array $p_lastEvents
     * @return void
     */
    public function setLastEvents($p_lastEvents)
    {
        $this->m_last_events = $p_lastEvents;
    } // fn setLastEvents

    /**
     * Auxiliary function to prepare data files to the parser
     *
     * @param array $p_fileNamesIn
     * @param array $p_fileNamesOut
     * @param array $p_fileToUnlink
     * @return void
     */
    private function setSourceFiles($p_fileNamesIn, &$p_fileNamesOut, &$p_filesToUnlink)
    {
        if (empty($p_filesToUnlink)) {
            $p_filesToUnlink = array();
        }
        if (empty($p_fileNamesOut)) {
            $p_fileNamesOut = array();
        }
        if (empty($p_fileNamesIn)) {
            return;
        }

        foreach ($p_fileNamesIn as $one_file_name) {
            $one_file_name_arr = explode('.', $one_file_name);
            $one_suffix = strtolower($one_file_name_arr[count($one_file_name_arr) - 1]);

            if ('zip' == $one_suffix) {
                $zip_hnd = zip_open($one_file_name);
                if (is_numeric($zip_hnd)) {continue;}
                while (true) {
                    $zip_entry = zip_read($zip_hnd);
                    if ((!$zip_entry) || is_numeric($zip_entry)) {
                        break;
                    }
                    if (!zip_entry_open($zip_hnd, $zip_entry, 'rb')) {
                        continue;
                    }
                    $entry_content = '';
                    $entry_name = zip_entry_name($zip_entry);
                    $entry_name_arr = explode('.', $entry_name);
                    $entry_name_suff = strtolower($entry_name_arr[count($entry_name_arr) - 1]);
                    $is_valid = false;
                    $add_suffix = '';
                    if ('xml' == $entry_name_suff) {
                        $entry_is_valid = true;
                        $entry_add_suffix = '.xml';
                    }
                    elseif ('gz' == $entry_name_suff) {
                        if (2 <= count($entry_name_arr)) {
                            $entry_name_suff_sub = strtolower($entry_name_arr[count($entry_name_arr) - 2]);
                            if ('xml' == $entry_name_suff_sub) {
                                $entry_is_valid = true;
                                $entry_add_suffix = '.xml.gz';
                            }
                        }
                    }
                    if ($entry_is_valid) {
                        $entry_content = zip_entry_read($zip_entry, zip_entry_filesize($zip_entry));
                    }
                    zip_entry_close($zip_entry);
                    if (!$entry_is_valid) {
                        continue;
                    }

                    try {
                        $zip_temp_name_ini = tempnam(sys_get_temp_dir(), '' . mt_rand(100, 999));
                        $zip_temp_name = $zip_temp_name_ini . $entry_add_suffix;

                        $zip_temp_hnd = fopen($zip_temp_name, 'wb');
                        fwrite($zip_temp_hnd, $entry_content);
                        fclose($zip_temp_hnd);

                        $p_fileNamesOut[] = $zip_temp_name;
                        $p_filesToUnlink[] = $zip_temp_name;
                        if ($zip_temp_name != $zip_temp_name_ini) {
                            $p_filesToUnlink[] = $zip_temp_name_ini;
                        }
                    }
                    catch (Exception $exc) {
                        continue;
                    }

                }
                zip_close($zip_hnd);
                continue;
            }

            if ('gz' == $one_suffix) {
                $p_fileNamesOut[] = 'compress.zlib://' . $one_file_name;
                continue;
            }

            $p_fileNamesOut[] = $one_file_name;
        }

    } // fn setSourceFiles

    /**
     * Parses RestaurantData data
     *
     * @param array $p_restaurantsInfosFiles file name of the restaurant file
     * @return array
     */
    public function parseRestaurantsInfo($p_restaurantsInfosFiles)
    {

        $restaurants_infos_files = array();
        $files_to_unlink = array();

        $restaurants_places = array();

        if (!empty($p_restaurantsInfosFiles)) {
            $this->setSourceFiles($p_restaurantsInfosFiles, $restaurants_infos_files, $files_to_unlink);
        }

        foreach ($restaurants_infos_files as $one_rest_file) {


            $one_rest_data = FileLoad::LoadFixJson($one_rest_file);

            foreach ($one_rest_data as $one_rest) {

                $one_rest_uid = trim('' . $one_rest['uid']);
                //if (empty($one_rest_uid)) {
                //    continue;
                //}
                $one_rest_url_name = trim('' . $one_rest['url_name']);
                $one_rest_zip = trim('' . $one_rest['zip']);
                $one_rest_profile = trim('' . $one_rest['profile']);

                $restaurants_places[] = array(
                    'rest_uid' => $one_rest_uid,
                    'rest_url_name' => $one_url_name,
                    'rest_zip' => $one_rest_zip,
                    'rest_profile' => $one_rest_profile,
                );

            }
        }


        return $restaurants_places;
    } // fn parseRestaurantsInfo

    private function formatDateText($p_dateTimes)
    {
        $screens = '';

        $line_sep = "\n<br />\n";
        $field_sep = ':';

        foreach ($p_dateTimes as $cur_date => $cur_screenings) {
            $screens .= $cur_date . $line_sep;
            foreach ($cur_screenings as $one_scr) {
                $one_time = (isset($one_scr['time']) ? ('' . $one_scr['time']) : '');
                $one_lang = (isset($one_scr['lang']) ? ('' . $one_scr['lang']) : '');
                $one_flag = (isset($one_scr['flag']) ? ('' . $one_scr['flag']) : '');
                $screens .= $one_time . $field_sep . $one_lang . $field_sep . $one_flag . $line_sep;
            }
            $screens .= $line_sep;
        }

        return $screens;
    }


    /**
     * Puts together info on restaurant events
     *
     * @param array $p_restaurantsInfosFiles
     * @param int $p_providerId
     * @param array $p_categories
     * @param mixed $p_daysPast
     * @param mixed $p_daysNext
     * @param mixed $p_catLimits
     * @return array
     */
    public function prepareRestaurantsEvents($p_restaurantsInfosFiles, $p_providerId, $p_categories, $p_daysPast = null, $p_daysNext = null, $p_catLimits = null)
    {
        $provider_id = $p_providerId;
        $rest_country = 'ch';

        $limit_date_start = null;
        $limit_date_end = null;

        $cur_time = time();
        if (!empty($p_daysPast)) {
            $limit_date_start = date('Y-m-d', ($cur_time - ($p_daysPast * 24 * 60 * 60)));
        }
        if (!empty($p_daysNext)) {
            $limit_date_end = date('Y-m-d', ($cur_time + ($p_daysNext * 24 * 60 * 60)));
        }

        $restaurants_places = $this->parseRestaurantsInfo($p_restaurantsInfosFiles);

        $rests_events_all = array();
        $rests_events_dif = array();

        //$set_date = '';
        //$set_date_times = array();

        foreach ($restaurants_places as $one_rest) {
            // taking basic info from profile
            // creating image links into panorama images
            // finding region, cuisine, ambiance topics
            // putting in datetimes on open days (minus holiday/closed days)

            $one_event = array();

            $one_event[] = '';

            $one_profile = $one_rest['profile'];

            $one_event['provider_id'] = $provider_id;
            $one_event['event_id'] = '' . $one_rest['url_name'] . '-' . $one_screen['uid'];

            $one_event['tour_id'] = $one_rest['uid'];
            $one_event['location_id'] = $one_rest['uid'];

            $one_event['headline'] = $one_profile['real_name'];
            $one_event['organizer'] = $one_profile['real_name'];
            $one_event['keywords'] = $one_rest['url_name'];

            $one_event['country'] = $rest_country;
            $one_event['zipcode'] = $one_rest['zip'];
            $one_event['town'] = $one_profile['city'];
            $one_event['street'] = $one_profile['address'];

/*
            // TODO: put it as a (full) week start of date/time screen listing (lists per days)
            $set_date = $one_screen['start_date'];
            $set_date_obj = new DateTime($set_date);
            $set_date_times = array($set_date => array());
            foreach (array(1, 2, 3, 4, 5, 6) as $cur_day_add) {
                $set_date_obj->add(new DateInterval('P1D'));
                $set_date_times[$set_date_obj->format('Y-m-d')] = array();
            }
*/

            // region info
            $e_region = '';
            $e_subregion = '';

            $topics_regions = array();
            $loc_regions = $this->m_region_info->ZipRegions($one_rest['zip'], $rest_country);
            foreach ($loc_regions as $region_name) {
                if (isset($this->m_region_topics[$region_name])) {
                    $cur_reg_top = $this->m_region_topics[$region_name];
                    $cur_reg_top['key'] = $region_name;
                    $topics_regions[] = $cur_reg_top;
                }
            }

            $event_topics = array();

            $category_conns = array(
                'typology' => 'restaurant_cuisine',
                'ambiance' => 'restaurant_ambiance',
            );

            foreach ($category_conns as $cur_cat_type_name => $cur_cat_defs_name) {
                if (!isset($p_categories[$cur_cat_defs_name])) {
                    continue;
                }

                $c_other = null;
                $topic_found = false;

                foreach ($p_categories[$cur_cat_defs_name] as $one_category) {
                    if (!is_array($one_category)) {
                        continue;
                    }

                    $one_cat_key = $one_category['key'];

                    if (array_key_exists('other', $one_category)) {
                        $c_other = $one_category['other'];
                        continue;
                    }

                    $topic_search = array();
                    foreach ($one_profile[$cur_cat_type_name] as $x_catnam) {
                        $x_catnam = strtolower(trim($x_catnam));
                        if ((array_key_exists('match_xml', $one_category)) && (array_key_exists('match_topic', $one_category))) {
                            $one_cat_match_xml = $one_category['match_xml'];
                            $one_cat_match_topic = $one_category['match_topic'];
                            if ((!is_array($one_cat_match_xml)) || (!is_array($one_cat_match_topic))) {
                                continue;
                            }
                            if (in_array($x_catnam, $one_cat_match_xml)) {
                                $event_topics[] = $one_cat_match_topic;
                                $topic_found = true;
                                continue;
                            }
                        }

                    }

                }

                if (!$topic_found) {
                    if (!empty($c_other)) {
                        $event_topics[] = $c_other;
                    }
                }

            }

            foreach ($topics_regions as $one_regtopic) {
                $event_topics[] = $one_regtopic;
            }

            $one_event['topics'] = $event_topics;


            //$one_rest_genre = '';
            //$one_rest_desc = '';
            $one_rest_images = array();

            foreach ($one_profile['panos'] as $one_panorama_info) {
                $one_pano_id = $one_panorama_info['id'];
                $one_pano_type = $one_panorama_info['type'];
                $one_pano_name = $one_panorama_info['name'];

                $one_pano_url = 'http://pano.lunchgate.ch/'. $one_pano_id . '/400x400.jpg';

                $one_rest_images[] = array(
                    'url' => $one_pano_url,
                    'label' => $one_pano_name,
                );

            }

            $one_event['images'] = $one_rest_images;

            $one_event['datetimes'] = array();

            $day_holiday_start = null;
            $day_holiday_end = null;
            $day_holidays = $one_profile['hours']['holiday'];
            if (!empty($day_holidays)) {
                //$day_holidays = explode('\u2013', $day_holidays); // put from d.m.y into y-d-m
                $day_holidays = takeDays($day_holidays);
            }

            $week_days = array(); // upto 2 intervals (generally array), closed:'geschlossen'; put from d.m.y into y-d-m
            foreach (array('day1', 'day2', 'day3', 'day4', 'day5', 'day6', 'day7') as $one_day_spec) {
                $cur_open = array();
                if (isset($one_profile['hours'][$one_day_spec])) {
                    $cur_open = $this->takeHours($one_profile['hours'][$one_day_spec]);
                }
                $week_days[] = $cur_open;
            }

            $date_obj = new DateTime();
            $date_obj->subtract(new DateInterval('P1D'));
            foreach (array(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12) as $one_week) {
                foreach (array(0, 1, 2, 3, 4, 5, 6) as $one_week_day) {
                    ;
                }
            }

            for ($d_ind = 0; $d_ind < 90; $d_ind++) {
                $date_obj->add(new DateInterval('P1D'));
                $date_str = $date_obj->format('Y-m-d');

                if ($day_holiday_start && $day_holiday_end) {
                    if (($date_str >= $day_holiday_start) && ($date_str <= $day_holiday_end)) {
                        continue;
                    }
                }

                $week_position = $date_obj->week_day;
                if (empty($week_days[$week_position])) {
                    continue;
                }

                foreach ($week_days[$week_position] as $one_day) {
                    // take time on/off; restrict to 00:00-24:00, put into comments otherwise longer (e.g. after midnight)
                    // create date-time def
                }


            }


/*
            $one_use_desc = $one_mov_desc;
            if (empty($one_use_desc)) {
                $one_use_desc = $one_screen['desc'];
            }

            $one_event = array();

            $one_event['date'] = $set_date; // for the older (and probably safer) way of dealing with old data
            //$one_date_max = '0000-00-01';
            $one_date_max = $set_date;

            foreach ($one_screen['dates'] as $one_date => $one_times) {
                if ($one_date_max < $one_date) {
                    $one_date_max = $one_date;
                }

                if (!isset($set_date_times[$one_date])) {
                    $set_date_times[$one_date] = array(); // this shall not occur
                }

                foreach ($one_times as $one_screen_info) {
                    $set_date_times[$one_date][] = $one_screen_info;
                }
                //$one_event_screen[$one_date] = $one_times; // flag, lang, time
            }
            ksort($set_date_times);

            //$one_event['date'] = $one_date_max; // for the newer (but not used) way of dealing with old data
            $one_event['date_time_data'] = $set_date_times;
            $one_event['date_time_text'] = $this->formatDateText($set_date_times);
*/

/*
yyyy-mm-dd
hh.mm:langs:flags
hh.mm:langs:flags
....
yyyy-mm-dd
....
yyyy-mm-dd
hh.mm:langs:flags
hh.mm:langs:flags
....
*/
            {
/*
                $one_event['provider_id'] = $provider_id;
                $one_event['event_id'] = '' . $one_screen['kino_id'] . '-' . $one_screen['movie_id'];

                $one_event['tour_id'] = $one_screen['movie_id'];
                $one_event['location_id'] = $one_screen['kino_id'];

                $one_event['movie_key'] = (isset($one_screen['movie_key']) && (!empty($one_screen['movie_key']))) ? $one_screen['movie_key'] : '';
                $one_event['movie_info'] = $one_movie;

                $one_event['headline'] = $one_screen['title'];
                $one_event['organizer'] = $one_screen['kino_name'];
                $one_event['keywords'] = $one_screen['kino_name'];

                $one_event['country'] = $kino_country;
                $one_event['zipcode'] = $one_screen['kino_zip'];
                $one_event['town'] = $one_screen['kino_town'];
                $one_event['street'] = $one_screen['kino_street'];

                $one_event['region'] = $e_region;
                $one_event['subregion'] = $e_subregion;

                if ($limit_date_start) {
                    if ($one_date < $limit_date_start) {
                        continue;
                    }
                }
                if ($limit_date_end) {
                    if ($one_date > $limit_date_end) {
                        continue;
                    }
                }

                $one_event['time'] = '';

                $one_event['web'] = $this->makeLink($one_screen['kino_url'], null);
                $one_event['email'] = '';
                $one_event['phone'] = $one_screen['kino_phone'];

                $one_event['description'] = str_replace("\n", "\n<br />\n", $one_use_desc);
                $one_event['other'] = $one_screen['other'];

                $one_event['movie_trailers'] = array();
                foreach ($one_mov_trailers as $cur_trailer) {
                    $one_event['movie_trailers'][] = $this->makeLink($cur_trailer, 'Trailer', true, true);
                }
                $one_event['movie_trailer'] = $trailer_official;
                $one_event['movie_trailer_vimeo'] = $trailer_official_vimeo;
                $one_event['movie_trailer_info'] = $trailer_official_info;

                $one_event['genre'] = $one_mov_genre;
                $one_event['languages'] = '';
                $one_event['prices'] = '';
                $one_event['minimal_age'] = $one_screen['allowed_age'];
                $one_event['minimal_age_category'] = $this->getMinAge($one_screen['allowed_age_orig']);

                $one_event['rating_wv'] = $one_screen['rating_wv'];

                $one_event['canceled'] = false;
                $one_event['rated'] = $e_rated;

                $one_event['geo'] = array();
                if ( (!empty($one_screen['kino_latitude'])) && (!empty($one_screen['kino_longitude'])) ) {
                    $one_event['geo']['longitude'] = $one_screen['kino_longitude'];
                    $one_event['geo']['latitude'] = $one_screen['kino_latitude'];
                }
*/


                //$one_event['uses_multidates'] = true;
                //$screening_datetimes = null;
                //$one_event['datetimes'] = $screening_datetimes;

                $rests_events_all[$one_event['event_id']] = $one_event;

                //if (!empty($this->m_last_events)) {
                //    if (isset($this->m_last_events[$one_event['event_id']])) {
                //        if ($this->m_last_events[$one_event['event_id']] == json_encode($one_event)) {
                //            //continue;
                //        }
                //    }
                //}

                $rests_events_dif[$one_event['event_id']] = $one_event;
            }

        }

        return array('events_all' => $rests_events_all, 'events_dif' => $rests_events_dif);
    } // fn prepareRestaurantsEvents

    /**
     * Creates (html) link on given (partial) link and label
     *
     * @param string $p_target
     * @param mixed $p_label
     * @param bool $p_fullLink
     *
     * @return string
     */
    private function makeLink($p_target, $p_label = '', $p_fullLink = true, $p_remote = false) {
        $link = trim('' . $p_target);
        if (empty($link)) {
            return '';
        }
        if ($p_fullLink) {
            if ('http' != substr($link, 0, strlen('http'))) {
                $link = 'http://' . $link;
            }
        }
        if (!empty($p_label)) {
            $target_part = '';
            if ($p_remote) {
                $target_part = ' target="_blank"';
            }

            $link = '<a href="' . $link . $target_part . '">' . $p_label . '</a>';
        }

        return $link;
    } // fn makeLink

    private function takeHours($p_day)
    {
        $open_hours = array();

        $not_open = array();
        if (!isset($p_day['open1'])) {
            return $not_open;
        }

        $open_hours_1 = strtolower(trim($p_day['open1']));
        if ('geschlossen' == $open_hours_1) {
            return $not_open;
        }

        $use_intervals = array($open_hours_arr_1);
        foreach (array('open2', 'open3', 'open4') as $one_more_open) {
            if (isset($p_day[$one_more_open])) {
                $open_hours_more = strtolower(trim($p_day[$one_more_open]));
                if ('geschlossen' == $open_hours_more) {
                    $use_intervals[] = $open_hours_more;
                }
            }
        }

        foreach ($use_intervals as $cur_open_hours) {

            $cur_open_hours_arr = explode('\u2013', $cur_open_hours);
            $cur_open = array();

            if (2 == count($cur_open_hours_arr)) {
                $cur_open_start = explode(':', $cur_open_hours_arr[0]);
                $cur_open_end = explode(':', $cur_open_hours_arr[1]);

                if (2 == count($cur_open_start)) {
                    $cur_open_start_hour = ltrim($cur_open_start[0], '0');
                    $cur_open_start_min = ltrim($cur_open_start[1], '0');
                    if (is_numeric($cur_open_start_hour) && is_numeric($cur_open_start_min)) {
                        $cur_open['start'] = array('hour' => $cur_open_start_hour, 'min' => $cur_open_start_min);
                    }
                }

                if (2 == count($cur_open_end)) {
                    $cur_open_end_hour = ltrim($cur_open_end[0], '0');
                    $cur_open_end_min = ltrim($cur_open_end[1], '0');
                    if (is_numeric($cur_open_end_hour) && is_numeric($cur_open_end_min)) {
                        $cur_open['end'] = array('hour' => $cur_open_end_hour, 'min' => $cur_open_end_min);
                    }
                }

                if (isset($cur_open['start']) && isset($cur_open['end'])) {
                    $open_hours[] = $cur_open;
                }

            }

        }

        return $open_hours;
    } // takeHours


} // class RestaurantData_Parser_Simple


