<?php

/*

cron outside import 1:
  * look into db for videos that should be downloaded
  * take them one by one:
      * download them, put into a dir, name by movie key
      * fill video table, set state as to_upload


cron outside import 2:
  * look into db for videos that should be uploaded
  * take one by one, cycle:
      * upload into vimeo
      * fill vimeo id into db

*/

$class_dir = dirname(__FILE__);

$vimeolib_path = $class_dir . DIRECTORY_SEPARATOR . 'vimeolib' . DIRECTORY_SEPARATOR . 'vimeo.php';
require_once($vimeolib_path);

class TrailerProcessor {

    static var $m_max_run = 100;
    static var $m_max_errors = 5;

    public function trailerDbExists($p_dbPath)
    {
        $path_mode = 0755;

        $table_name = 'trailers';

        $db_dir = dirname($p_dbPath);
        if (!is_dir($db_dir)) {
            mkdir($db_dir, $path_mode, true);
        }

        $queryStr_cre = 'CREATE TABLE IF NOT EXISTS ' . $table_name . ' (
            movie_key TEXT PRIMARY KEY,
            vimeo_id TEXT DEFAULT "",
            source_timestamp INTEGER DEFAULT 0,
            source_url TEXT DEFAULT "",
            local_name TEXT DEFAULT "",
            video_codec TEXT DEFAULT "",
            video_width TEXT DEFAULT "",
            video_height TEXT DEFAULT "",
            state TEXT DEFAULT "",
            error_count INTEGER DEFAULT 0
        )';


        @$db = new PDO ('sqlite:' . $p_dbPath);
        $stmt = $db->prepare($queryStr_cre);
        $res = $stmt->execute();
        if (!$res) {
            return false;
        }

        if (!is_file($p_dbPath)) {
            return false;
        }

        return true;
    }


    public function downloadOneTrailer($p_moviesDatabase, $p_saveDir, $p_extension = null)
    {
        $sqlite_name = $p_moviesDatabase;
        $table_name = 'trailers';
        $max_error_count = 3;

        $queryStr_sel = 'SELECT movie_key, source_url, error_count FROM ' . $table_name . ' WHERE state = "to_download" AND error_count < ' . $max_error_count . ' ORDER BY movie_key LIMIT 1';
        $queryStr_upd = 'UPDATE ' . $table_name . ' SET local_name = :local_name, state = "to_upload" WHERE movie_key = :movie_key';
        $queryStr_err = 'UPDATE ' . $table_name . ' SET error_count = :error_count WHERE movie_key = :movie_key';


        $movie_key = null;
        $trailer_url = null;

        $stmt = $db->prepare($queryStr_sel);
        ;

        $file_store = $p_saveDir . DIRECTORY_SEPARATOR . $movie_key; // . '-' . $timestamp;

        try {
            file_put_contents($file_store, file_get_contents($trailer_url));
        }
        catch (Exception $exc) {
            ;
        }



    }


/*
    public function downloadAllTrailers($p_moviesDatabase, $p_saveDir)
    {

        while (true) {
            $left = downloadOneTrailer();
            if (!$left) {
                break;
            }

        }


    }
*/


    public function uploadOneTrailer($p_dbPath, $p_videoDir)
    {
        $vimeo_id = null;

        $table_name = 'videos';

        $row_id = 0;
        $video_path = '';

        $queryStr_sel = 'SELECT id, input_name FROM ' . $table_name . ' WHERE vimeo_id = "" LIMIT 1';
        $queryStr_upd = 'UPDATE ' . $table_name . ' SET vimeo_id = :vimeo_id, to_upload = 0 WHERE id = :id';

        if (!videoDbExists($p_dbPath)) {
            return false;
        }

        // take the info from db, with $queryStr_sel
        @$db = new PDO ('sqlite:' . $p_dbPath);
        $stmt = $db->prepare($queryStr_sel);
        $res = $stmt->execute();
        if (!$res) {
            return false;
        }
        $res = $stmt->fetch(PDO::FETCH_ASSOC);
        if (empty($res)) {
            return false;
        }
        $row_id = $res['id'];
        $video_name = $res['input_name'];

        if (empty($video_name)) {
            return false;
        }

        $video_path = $p_videoDir . DIRECTORY_SEPARATOR . $video_name;
        $vimeo = new Vimeo;

        try {
            $vimeo_id = $vimeo->upload();
        }
        catch (Exception $exc) {
            return false;
        }

        if (empty($vimeo_id)) {
            return false;
        }

        // put the vimeo_id into db, with $queryStr_upd
        //$db->beginTransaction();
        $stmt = $db->prepare($queryStr_upd);
        $stmt->bindParam(':id', $row_id, PDO::PARAM_STR);
        $stmt->bindParam(':vimeo_id', $vimeo_id, PDO::PARAM_STR);
        $res = $stmt->execute();
        if (!$res) {
            return false;
        }
        //$db->commit();

        return true;
    }

/*
    public function uploadAllVideos()
    {
        while (true) {
            $uploaded = uploadOneVideo();
            if (!$uploaded) {
                break;
            }
        }

    }
*/

    public function someLeft($p_moviesDatabase, $p_mode) {
        //return true;
        $known_modes = array('download' => 'to_download', 'upload' => 'to_upload');
        if (!array_key_exists($p_mode, $known_modes)) {
            return false;
        }
        $mode_state = $known_modes[$p_mode];

        $table_name = 'trailers';
        $sqlite_name = $p_moviesDatabase;

        $sel_req = 'SELECT count(*) AS count_left FROM ' . $table_name . ' WHERE state = "' . $mode_state . '"';
        if (0 < self::$m_max_errors) {
            $sel_req .= ' AND error_count < ' . self::$m_max_errors . '';
        }

        @$db = new PDO ('sqlite:' . $sqlite_name);
        $stmt = $db->prepare($sel_req);
        $res = $stmt->execute();
        if ($res) {
            $res = $stmt->fetch(PDO::FETCH_ASSOC);
            if (!$res) {
                return false;
            }
            $movie_key_old = $res['count_left'];
            ;
        }


        return true;
    }


    public static function AskForTrailers()
    {
        // process upto $max (... 100) trailers at one run

        $incl_dir = dirname(dirname(__FILE__)) . DIRECTORY_SEPARATOR . 'include';
        $defspool_path = $incl_dir . DIRECTORY_SEPARATOR . 'default_spool.php';
        require_once($defspool_path);
        // $newsimport_default_cache;

        $cache_dir = NewsImportEnv::AbsolutePath($newsimport_default_cache, true);

        $local_trailer_dir = $cache_dir . 'trailers';
        $trailres_db_path = $cache_dir . 'movies_info.sqlite';

        $max_run = self::$m_max_run;

        $trail_proc = new TrailerProcessor();
        $trail_proc->trailerDbExists($trailres_db_path);

        $cur_run = 0;
        while (true) {
            $cur_run += 1;
            if ($cur_run > $max_run) {
                break;
            }

            $trail_proc->downloadOneTrailer($trailres_db_path, $local_trailer_dir);
            if (!$trail_proc->someLeft($trailres_db_path, 'download')) {
                break;
            }

        }

        $cur_run = 0;
        while (true) {
            $cur_run += 1;
            if ($cur_run > $max_run) {
                break;
            }

            $trail_proc->uploadOneTrailer($trailres_db_path, $local_trailer_dir);
            if (!$trail_proc->someLeft($trailres_db_path, 'upload')) {
                break;
            }

        }

    }



}


