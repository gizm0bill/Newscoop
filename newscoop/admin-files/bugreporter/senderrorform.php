<?php
require_once "HTTP/Client.php";
require_once($GLOBALS['g_campsiteDir'] . "/classes/BugReporter.php");
require_once($GLOBALS['g_campsiteDir'] . "/classes/Input.php");
camp_load_translation_strings("bug_reporting");

//
// Post the error to server
//

global $Campsite, $ADMIN_DIR, $g_bugReporterDefaultServer;

$server = $g_bugReporterDefaultServer;
//$server = "http://localhost/trac/autotrac";

// REQUIRED INPUT
$f_str = Input::Get("f_str");
$f_num = Input::Get("f_num");
$f_time = Input::Get("f_time");
$f_file = Input::Get("f_file");
$f_line = Input::Get("f_line");
$f_backtrace = Input::Get("f_backtrace");

// OPTIONAL INPUT
$f_isPostFromBugreporter = Input::Get("f_is_post_from_bugreporter", "boolean", false, true);
$f_email = Input::Get("f_email", "string", "", true);
$f_description = Input::Get("f_description", "string", "", true);


// --- If this information is a POST from errormessage.php, send it to
//     the server ---
if ($f_isPostFromBugreporter && ($_SERVER['REQUEST_METHOD'] == "POST") ) {

    $sendWasAttempted = true;

    // --- If not all variables were posted, send a bugreport saying as much to the server ---
    if (!Input::isValid()){

        // -- Create an error description explaining which variables did and didn't get sent --

        $included = "";
        $notIncluded = "";

        $description = "Not all variables are being sent by Bugreporter.  \n\n";

        if (!isset($f_num)) {
            $f_num = 0;
            $notIncluded .= "f_num \n";
        } else {
        	$included .= "f_num:" . urldecode($f_num) . " \n";
        }

        if (!isset($f_str)) {
            $f_str = "";
            $notIncluded .= "f_str \n";
        } else {
        	$included .= "f_str:" . urldecode($f_str) . " \n";
        }

        if (!isset($f_file)) {
            $f_file = "";
            $notIncluded .= "f_file \n";
        } else {
        	$included .= "f_file:" . urldecode($f_file) . " \n";
        }

        if (!isset($f_line)) {
            $f_line = 0;
            $notIncluded .= "f_line \n";
        } else {
        	$included .= "f_line:" . urldecode($f_line) . " \n";
        }

        if (!isset($f_time)) {
            $f_time = date("r");
            $notIncluded .= "f_time \n";
        } else {
        	$included .= "f_time:" . urldecode($f_time) . " \n";
        }

        if (!isset($f_backtrace)) {
            $f_backtrace = "";
            $notIncluded .= "f_backtrace \n";
        } else {
        	$included .= "f_backtrace:" . urldecode($f_backtrace) . " \n";
        }

        $description .= "{{{\nVariables Included: \n$included\n"
            . "Variables not included:\n$notIncluded\n}}}";

        $reporter = new BugReporter(0, "", "", "", "", "", $f_time, " ");
        $reporter->setServer($server);

        if (isset($description)) {
            $reporter->setDescription(urldecode($description));
        }

        $wasSent = $reporter->sendToServer();

        // --- Wait, so as not to create timing problems with two sends ---
        usleep (1000000);
    }

    // -- Attempt to send user's error (regardless of whether above report
    // was also sent) --

    // Remove the code name from the version number.
    $version = explode(" ", $Campsite['VERSION']);
    $version = array_shift($version);

    $reporter = new BugReporter($f_num, $f_str, $f_file, $f_line,
                                "Campsite", $version, $f_time,
                                $f_backtrace);
    $reporter->setServer($server);
    $reporter->setEmail($f_email);
    $reporter->setDescription($f_description);

    $wasSent = $reporter->sendToServer();

    // --- Verify send was successful, and say thank you or sorry
    //     accordingly ---
    if ($wasSent == true) {
        include($Campsite['HTML_DIR'] . "/$ADMIN_DIR/bugreporter/thankyou.php");
    } else {
    	include($Campsite['HTML_DIR'] . "/$ADMIN_DIR/bugreporter/emailus.php");
    }
}

?>