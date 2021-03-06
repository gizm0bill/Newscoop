<?php

$GLOBALS['g_campsiteDir'] = dirname(__FILE__);
require_once($GLOBALS['g_campsiteDir'].'/include/adodb/adodb.inc.php');
require_once($GLOBALS['g_campsiteDir'].'/conf/database_conf.php');

global $g_ado_db;
global $Campsite;

if (!isset($g_ado_db)) {
	$g_ado_db = ADONewConnection($Campsite['db']['type']); # eg 'mysql' or 'postgres'
	//$g_ado_db->debug = true;
	// Set fetch mode to return associative arrays
	$g_ado_db->SetFetchMode(ADODB_FETCH_ASSOC);

    // add port to hostname if set
    $dbhost = $Campsite['DATABASE_SERVER_ADDRESS'];
    if (!empty($Campsite['DATABASE_SERVER_PORT'])) {
        $dbhost .= ':' . $Campsite['DATABASE_SERVER_PORT'];
    }

	$g_ado_db->Connect($dbhost, $Campsite['DATABASE_USER'],
		$Campsite['DATABASE_PASSWORD'], $Campsite['DATABASE_NAME']);
    $g_ado_db->Execute("SET NAMES 'utf8'");

    unset($dbhost);
}

if (!$g_ado_db->IsConnected()) {
	header('Expires: Mon, 26 Jul 1997 05:00:00 GMT');
?>
	<font color="red" size="3">
	<p>ERROR connecting to the MySQL server!</p>
	<p>Please start the MySQL database server and verify if the connection configuration is valid.</p>
	</font>
<?php
	exit(0);
}

?>
