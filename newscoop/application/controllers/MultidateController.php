<?php

use Newscoop\ArticleDatetime;
use Doctrine\Common\Util\Debug;
use Newscoop\Service\IThemeManagementService;
use Newscoop\Service\IOutputService;
use Newscoop\Service\ILanguageService;
use Newscoop\Service\ISyncResourceService;
use Newscoop\Service\IPublicationService;
use Newscoop\Service\IThemeService;
use Newscoop\Service\IOutputSettingIssueService;
use Newscoop\Service\IOutputSettingSectionService;
use Newscoop\Service\IIssueService;
use Newscoop\Service\ISectionService;
use Newscoop\Service\ITemplateSearchService;
use Newscoop\Entity\Publication;
use Newscoop\Entity\Theme;
use Newscoop\Entity\Resource;


/**
 * @Acl(resource="theme", action="manage")
 */
class MultidateController extends Zend_Controller_Action
{

    public function migrationAction() {
    	
    	if (PHP_SAPI != 'cli') die('no access');
    	
        echo "\n\n\nmigration \n\n\n";
        $s_mt = explode(" ",microtime());
        require_once($GLOBALS['g_campsiteDir']."/classes/Article.php");
        
        
        $connection = mysql_connect("localhost", "root", "");
        mysql_select_db("newscoop");
        
        
        $this->prepareTables();
        
        $events = array();
        
        $q = "SELECT NrArticle, IdLanguage, IdLanguage, FTour_id, Fdate, Ftime FROM Xevent";
        $r = mysql_query($q);
        
        //create array with all events
        while ($row = mysql_fetch_assoc($r)) {
            $tourId = $row['FTour_id'];
            
            $articleNr = $row['NrArticle'];
            $languageId = $row['IdLanguage'];
            $date = $row['Fdate'];
            $time = str_replace('.',':',$row['Ftime']);
            
            $event = array();
            $event['NrArticle'] = $articleNr;
            $event['IdLanguage'] = $languageId;
            $event['date'] = $date;
            $event['time'] = $time;
            
            $events[$tourId][] = $event; 
        }

        //go over the events grouped by tour id
        foreach($events as $tour_id => $tEvents) {
            $noEvents = count($tEvents);            
            if( $noEvents > 0) {                
                $mainArticleNo = $tEvents[0]['NrArticle'];              
                //insert events inthe multi_date table
                $diff = $this->isDateRange($tEvents);
                if ( $this->atSameTime($tEvents) &&  $diff ) {
                    $this->insertDailyRecurrent($mainArticleNo, $tEvents, $diff);
                } else {
                    $this->insertSingleDates($mainArticleNo, $tEvents);
                }
                //remove duplicate events
                for ($i = 1; $i < $noEvents; $i++) {
                    $this->addToRemoveList($tEvents[$i]['NrArticle'], $tEvents[$i]['IdLanguage']);
                }
            }
        }        
        echo "we have ".count($events)." tour_ids \n";
        mysql_close($connection);        
        $e_mt = explode(" ",microtime());
        $s = (($e_mt[1] + $e_mt[0]) - ($s_mt[1] + $s_mt[0]));
        echo "script executed in ".$s." seconds\n\n\n";
        
        die();
    }
    
    public function addToRemoveList($articleNo, $languagId) {
    	if (PHP_SAPI != 'cli') die('no access');
        $q = "
           INSERT INTO event_delete (articleNo, languageId)
           VALUES ('".$articleNo."', '".$languagId."')
        ";
        mysql_query($q);
    }
    
    public function prepareTables() {
    	if (PHP_SAPI != 'cli') die('no access');
        $q = "DROP TABLE IF EXISTS `event_delete`";
        mysql_query($q);
        $q = "
            CREATE TABLE IF NOT EXISTS `event_delete` (
              `articleNo` int(11) NOT NULL,
              `languageId` int(11) NOT NULL
            ) ENGINE=MyISAM DEFAULT CHARSET=utf8;
        ";
        mysql_query($q);
        $q = "TRUNCATE TABLE article_datetimes";
        mysql_query($q);
    }
    
    public function removeduplicatesAction() {
    	if (PHP_SAPI != 'cli') die('no access');
        echo "\n\n\nremove action\n";
        $s_mt = explode(" ",microtime());
        $count = 0;
        
        $q = "
           SELECT articleNo, languageId FROM event_delete
        ";
        $r = mysql_query($q);
        while ( $row = mysql_fetch_assoc($r)) {
            $count ++;
            $this->removeSingleEvent($row['articleNo'], $row['languageId']);
            mysql_query("DELETE FROM event_delete WHERE articleNo='".$row['articleNo']."' AND languageId='".$row['languageId']."'");
        }
        
        $rq = "DROP TABLE event_delete";
        
        echo "removed $count duplicates \n";
        
        $e_mt = explode(" ",microtime());
        $s = (($e_mt[1] + $e_mt[0]) - ($s_mt[1] + $s_mt[0]));
        echo "script executed in ".$s." seconds\n\n\n\n";
        
        die();
    }
    
    public function removeSingleEvent($NrArticle, $IdLanguage) {
    	if (PHP_SAPI != 'cli') die('no access');
        $article = new Article($IdLanguage, $NrArticle);
        $article->delete();
    }
    
    
    
    function insertDailyRecurrent($articleNr, $dates, $diff) {
    	if (PHP_SAPI != 'cli') die('no access');
        $noDates = count($dates);
        $startDate = $dates[0]['date'];
        $startTime = $dates[0]['time'];
        $endDate = $dates[$noDates - 1]['date'];
        $startTime = $dates[0]['time'];
        if($diff == '+7') {
            $enum = 'weekly';
        } else {
            $enum = 'daily';
        }
        
        $q3 = "INSERT INTO article_datetimes (start_time, start_date, end_date, recurring, article_id, article_type, field_name)
            VALUES ('".str_replace('.',':',$startTime)."','".$startDate."', '".$endDate."','".$enum."','".$articleNr."', 'event','schedule')";
        mysql_query($q3);
    }
    
    function insertSingleDates($articleNr, $dates) {
        if (PHP_SAPI != 'cli') die('no access');
        foreach($dates as $date) {
           $startDate = $date['date'];
           $startTime = $date['time'];
            
           $q4 = "INSERT INTO article_datetimes (start_time, start_date, article_id, article_type, field_name)
                  VALUES ('".str_replace('.',':',$startTime)."','".$startDate."', '".$articleNr."', 'event','schedule')";
           mysql_query($q4);    
        }
        
    }
    
    function atSameTime($dates) {
    	if (PHP_SAPI != 'cli') die('no access');
        $noDates = count($dates);
        if ($noDates == 1 ||  $noDates == 0) {
            return false;
        } else {
            for ($i=0; $i < $noDates - 1; $i++) {
                if ( $dates[$i]['time'] != $dates[$i + 1]['time'] ) {
                    return false;
                }
            }
        }
        return true;
    }
    
    function isDateRange($dates) {
    	if (PHP_SAPI != 'cli') die('no access');
        $possibleDiff = '';
        $noDates = count($dates);
        if($noDates == 1 || $noDates == 0) {
            return false;
        }
        
        $range = array();
        foreach($dates as $date) {
            $range[] = new DateTime(date($date['date']));
        }
        
        for ($i=0; $i < $noDates - 1; $i++) {
            $interval = $range[$i]->diff($range[$i + 1]);
            $diff = $interval->format('%R%a');
            if ($possibleDiff == '') {
                if ( $diff == '+1' || $diff == '+7') {
                    $possibleDiff = $diff;
                } else {
                    return false;
                }
            }
            if ( $diff != $possibleDiff) {
                return false;
            }
        }
        
        return $possibleDiff;
    }
    
    public function indexAction() 
    {
    	if (PHP_SAPI != 'cli') die('no access');
    }
}

