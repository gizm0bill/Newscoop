#!/usr/bin/env php
<?php
//exit(0);

$plugin_dir = dirname(dirname(dirname(dirname(__FILE__))));
require_once($plugin_dir.DIRECTORY_SEPARATOR.'classes'.DIRECTORY_SEPARATOR.'NewsImportEnv.php');
require_once($plugin_dir.DIRECTORY_SEPARATOR.'classes'.DIRECTORY_SEPARATOR.'NewsImport.php');
require_once($plugin_dir.DIRECTORY_SEPARATOR.'include'.DIRECTORY_SEPARATOR.'news_feeds_conf_inst.php');

if ( ("cli" == php_sapi_name()) && (!isset($GLOBALS['g_cliInited'])) ) {
    NewsImportEnv::BootCli();
    $GLOBALS['g_cliInited'] = true;
}

$newsimport_default_locks = NewsImportEnv::GetLockDir();

// whether we can start now
/*
$locks_path_dir = NewsImportEnv::AbsolutePath($newsimport_default_locks);
if (!NewsImportEnv::Start($locks_path_dir)) {
    exit(1);
    //$msg = 'newsimport_locked';
    //return $msg;
}
*/

$ev_source = $event_data_sources['events_1'];

$ev_limits = array(
                 'dates' => array('past' => -1000),
             );

//var_dump($ev_source);
//var_dump($ev_limits);
set_time_limit(0);
NewsImport::PruneEventData($ev_source, $ev_limits);
/*
NewsImportEnv::Stop($locks_path_dir);
*/
?>