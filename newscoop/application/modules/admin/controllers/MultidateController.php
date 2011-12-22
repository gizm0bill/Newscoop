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
class Admin_MultidateController extends Zend_Controller_Action
{

    /** @var Newscoop\Services\Resource\ResourceId */
    private $resourceId = NULL;
    /** @var Newscoop\Service\IThemeService */
    private $themeService = NULL;
    /** @var Newscoop\Service\IThemeManagementService */
    private $themeManagementService = NULL;
    /** @var Newscoop\Service\IPublicationService */
    private $publicationService = NULL;
    /** @var Newscoop\Service\ILanguageService */
    private $languageService = NULL;
    /** @var Newscoop\Service\IIssueService */
    private $issueService = NULL;
    /** @var Newscoop\Service\ISectionService */
    private $sectionService = NULL;
    /** @var Newscoop\Service\IOutputService */
    private $outputService = NULL;
    /** @var Newscoop\Service\IOutputSettingSectionService */
    private $outputSettingSectionService = NULL;
    /** @var Newscoop\Service\IOutputSettingIssueService */
    private $outputSettingIssueService = NULL;
    /** @var Newscoop\Service\ITemplateSearchService */
    private $templateSearchService = NULL;
    /** @var Newscoop\Service\ISyncResourceService */
    private $syncResourceService = NULL;
    
    /** @var variable set to a timestamp with 0 h and 0 m */
    public $tz;

    public function init()
    {
        $this->tz = mktime(0, 0, 0, 1, 1, 98);
    }

    /* --------------------------------------------------------------- */
    
    public function getDate($full)
    {
    	return date("Y-m-d", $full);
    }
    
    public function getTime($full)
    {
    	return date("H:i",$full);
    }

    public function isAllDay($date)
    {
    	if ( $this->getTime( is_null($date->getStartTime()) ? $this->tz : $date->getStartTime()->getTimestamp() ) == "00:00" && $this->getTime($date->endTime->getTimestamp()) == "23:59" ) {
    		return true;
    	} else {
    		return false;
    	}
    }

    
    public function addAction() 
    {	
    	$date_type = $this->_request->getParam('date-type');
    	$articleId = $this->_request->getParam('article-number');
    	$repo = $this->_helper->entity->getRepository('Newscoop\Entity\ArticleDatetime');
    	$multidateId = $this->_request->getParam('multidateId');
    	
    	//print_r($_REQUEST);
    	
    	if ($date_type == 'specific') {
    		//single date
    		$startDate = $this->_request->getParam('start-date-specific');
    		$startTime = $this->_request->getParam('start-time-specific');
    		$endTime = $this->_request->getParam('end-time-specific');

    		$type = $this->_request->getParam('specific-radio');
    		switch($type) {
    			case 'start-only':
    				$timeSet = array(
    				    "$startDate" => array( "$startTime" => "23:59" )
    				);
    				break;
    			case 'start-and-end':
    				$timeSet = array(
                        "$startDate" => array("$startTime" => "$endTime")
                    );
                    break;
    			case 'all-day':
    				$timeSet = array(
                        "$startDate" => array( "00:00" => "23:59" )
                    );
                    break;
    		}
    		
    		if ( $multidateId > 0) {
    			$repo->update( $multidateId, $timeSet);
    		} else {
    			//add
    			$repo->add($timeSet, $articleId, 'schedule');	
    		}
    		
    		
    	} else {
    		
    		$startDate = $this->_request->getParam('start-date-daterange');
    		if ($this->_request->getParam('cycle-ends') == 'never') {
    			$endDate = "2030-12-31";
    		} else {
    			$endDate = $this->_request->getParam('end-date-daterange');
    		}
    		if ($this->_request->getParam('daterange-all-day') == 1) {
    			$startTime = "00:00";
    			$endTime = "23:59";
    		} else {
    			$startTime = $this->_request->getParam('start-time-daterange');
            	$endTime = $this->_request->getParam('end-time-daterange');	
    		}
    		$recurring = $this->_request->getParam('repeats-cycle');
            $timeSet = array("$startDate $startTime" => "$endDate $endTime - $recurring");
            
            if ( $multidateId > 0) {
            	$repo->update( $multidateId, $timeSet );
            } else {
            	$repo->add($timeSet, $articleId, 'schedule');	
            }
    	}
        echo json_encode(array('code' => 200));
    	die();
    }
    
      
    
    public function geteventAction() 
    {
    	$articleDateTimeId = $this->_request->getParam('id');
        $repo = $this->_helper->entity->getRepository('Newscoop\Entity\ArticleDatetime');
        $jsEvent = array();
        $event = $repo->findDates((object) array('id' => "$articleDateTimeId"));
        if (is_array($event)) {
        	$date = $event[0];
        	$jsEvent['id'] = $date->id;
        	$jsEvent['startDate'] = $this->getDate($date->getStartDate()->getTimestamp());
        	$jsEvent['startTime'] = $this->getTime(is_null($date->getStartTime()) ? $this->tz : $date->getStartTime()->getTimestamp());
        	
	        $endDate = $date->getEndDate();
	        if ( empty($endDate)) {
	        	$jsEvent['endDate'] = $this->getDate($date->getStartDate()->getTimestamp());
	        } else {
	        	$jsEvent['endDate'] = $this->getDate($date->getEndDate()->getTimestamp());
	        }
	        $jsEvent['endTime'] = $this->getTime(is_null($date->getEndTime()) ? $this->tz : $date->getEndTime()->getTimestamp());
	        $jsEvent['allDay'] = $this->isAllDay($date);
	        $jsEvent['isRecurring'] = $date->getRecurring();
        	if ($jsEvent['endDate'] == "2030-12-31") {
	        	$jsEvent['neverEnds'] = 1;
	        } else {
	        	$jsEvent['neverEnds'] = 0;
	        }
        }
        echo json_encode($jsEvent);
        die();
    }
    
    public function removeAction() 
    {
    	
    	
    	
    	$articleDateTimeId = $this->_request->getParam('id');
    	//echo "|".$articleDateTimeId."|";
    	$repo = $this->_helper->entity->getRepository('Newscoop\Entity\ArticleDatetime');
    	
    	$repo->deleteById($articleDateTimeId);
    	
    	echo json_encode(array('code' => 200));
        die();
    }


    public function getdatesAction() 
    {
    	
    	//is_null($date->getStartTime()) ? $this->tz : $date->getStartTime()->getTimestamp();
    	
    	$articleId = $this->_request->getParam('articleId');
        $repo = $this->_helper->entity->getRepository('Newscoop\Entity\ArticleDatetime');
        $return = array();
        $dates = $repo->findDates((object) array('articleId' => "$articleId"));
        foreach( $dates as $date) {
        	
        	$recurring = $date->getRecurring();
        	if (strlen($recurring) > 1 && $recurring != 'daily') {
        		//daterange
        		$start = strtotime( $this->getDate($date->getStartDate()->getTimestamp()).' '.$this->getTime(is_null($date->getStartTime()) ? $this->tz : $date->getStartTime()->getTimestamp()) );
        		$end = strtotime( $this->getDate($date->getEndDate()->getTimestamp()).' '.$this->getTime(is_null($date->getEndTime()) ? $this->tz : $date->getEndTime()->getTimestamp()) );
        		$itemStart = $start;
        		$itemEnd = strtotime( $this->getDate($date->getStartDate()->getTimestamp()).' '.$this->getTime(is_null($date->getEndTime()) ? $this->tz : $date->getEndTime()->getTimestamp()) );
        		
        		switch($recurring) {
        			case 'weekly':
        				$step = "+1 week";
        				break;
        			case 'monthly':
        				$step = "+1 month";
        				break;
        		}
        		
        		while($itemStart < $end) {
        			$calDate = array();
		        	$calDate['id'] = $date->id;
		        	$calDate['title'] = 'Event ';
		        	$calDate['start'] = $itemStart;
		        	$calDate['end'] = $itemEnd;
		        	$calDate['allDay'] = $this->isAllDay($date);
	        		$return[] = $calDate;
		        	
		        	$itemStart = strtotime($step, $itemStart);
		        	$itemEnd = strtotime($step, $itemEnd);
        		}
        		
        	} else {
        		//specific
        		$calDate = array();
	        	$calDate['id'] = $date->id;
	        	$calDate['title'] = 'Event ';
	        	$calDate['start'] = strtotime( $this->getDate($date->getStartDate()->getTimestamp()).' '.$this->getTime( is_null($date->getStartTime()) ? $this->tz : $date->getStartTime()->getTimestamp() ));
	        	$endDate = $date->getEndDate();
	        	if ( empty($endDate)) {
	        		$calDate['end'] = strtotime( $this->getDate($date->getStartDate()->getTimestamp()).' '.$this->getTime(is_null($date->getEndTime()) ? $this->tz : $date->getEndTime()->getTimestamp()) );
	        	} else {
	        		$calDate['end'] = strtotime( $this->getDate($date->getEndDate()->getTimestamp()).' '.$this->getTime(is_null($date->getEndTime()) ? $this->tz : $date->getEndTime()->getTimestamp()) );	
	        	}
	        	$calDate['allDay'] = $this->isAllDay($date);
	        	$return[] = $calDate;
        	}
        	
        }
        echo json_encode($return);
        die();
    }

    //from here on down it's the migration stuff
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    public function migration2Action() {
    	echo "migration 2<br /><br /><br />";
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
        echo "we have ".count($events)." tours<br />";
        mysql_close($connection);        
        $e_mt = explode(" ",microtime());
        $s = (($e_mt[1] + $e_mt[0]) - ($s_mt[1] + $s_mt[0]));
        echo "script executed in ".$s." seconds";
        
        die();
    }
    
    public function addToRemoveList($articleNo, $languagId) {
    	$q = "
    	   INSERT INTO event_delete (articleNo, languageId)
    	   VALUES ('".$articleNo."', '".$languagId."')
    	";
    	mysql_query($q);
    }
    
    public function prepareTables() {
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
    	echo "remove action<br />";
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
    	
    	echo "removed $count <br />";
    	
    	$e_mt = explode(" ",microtime());
        $s = (($e_mt[1] + $e_mt[0]) - ($s_mt[1] + $s_mt[0]));
        echo "script executed in ".$s." seconds";
        
        die();
    }
    
    public function removeSingleEvent($NrArticle, $IdLanguage) {
    	$article = new Article($IdLanguage, $NrArticle);
        $article->delete();
    }
    
    public function migrationAction()
    {
    	echo "migration<br /><br /><br />";
    	$s_mt = explode(" ",microtime());
    	/*
		$connection = mysql_connect("localhost", "root", "");
        mysql_select_db("migratia");
        */
        require_once($GLOBALS['g_campsiteDir']."/classes/Article.php");
        $processed = array();
		$q = "SELECT NrArticle, IdLanguage, COUNT(NrArticle) AS nos, IdLanguage, FTour_id FROM Xevent GROUP BY FTour_id";
		$r = mysql_query($q);
		
		while($row = mysql_fetch_array($r)) {
		    $tourId = $row['FTour_id'];
		    $nos = $row['nos'];
		    $q1 = "SELECT Fdate, Ftime FROM Xevent WHERE Ftour_id='".$tourId."' ";
		    $r1 = mysql_query($q1);
		    
		    $articleNr = $row['NrArticle'];
		    $languageId = $row['IdLanguage'];
		    $dates = array();
		    $i = 0;
		    while( $row1 = mysql_fetch_assoc($r1)) {
		        $dates[$i]['date'] = $row1['Fdate'];
		        $dates[$i]['time'] = str_replace('.',':',$row1['Ftime']);
		        $i ++;
		    }
		    
		    $diff = $this->isDateRange($dates);
		    if ($this->atSameTime($dates) && $diff) {
		        $this->insertDailyRecurrent($articleNr, $dates, $diff);
		    } else {
		        $this->insertSingleDates($articleNr, $dates);
		    }
		    if ( $nos > 1) {
                $processed[$tourId] = $articleNr.'-'.$languageId;	
		    }
		}
		
		$this->removeDuplicates($processed);
    	$e_mt = explode(" ",microtime());
		$s = (($e_mt[1] + $e_mt[0]) - ($s_mt[1] + $s_mt[0]));
		echo "script executed in ".$s." seconds";
    	die('<br />no request view');
    }
    
	function insertDailyRecurrent($articleNr, $dates, $diff) {
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
	    
	    foreach($dates as $date) {
	       $startDate = $date['date'];
	       $startTime = $date['time'];
	        
	       $q4 = "INSERT INTO article_datetimes (start_time, start_date, article_id, article_type, field_name)
	              VALUES ('".str_replace('.',':',$startTime)."','".$startDate."', '".$articleNr."', 'event','schedule')";
	       mysql_query($q4);    
	    }
	    
	}
	
	function atSameTime($dates) {
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
	
	function removeEvent($events) {
	    foreach($events as $event) {
	    	$article = new Article($event['IdLanguage'], $event['NrArticle']);
	    	//echo "|".$article->getName()."|<br />";
	    	$article->delete();
	    }
	    
	    /*
	    echo count($events)."<br />";
	    if (count($events)) {
	    	die('we removed some events');
	    }
	    */
	    
	}
	
	function removeDuplicates($processed) {
	    //echopre($processed);
	    foreach($processed as $tour_id => $article) {
	        
	        $toBeRemoved = array();
	        
	        $articleArray = explode('-', $article);
	        $NrArticle = $articleArray[0];
	        $IdLanguage = $articleArray[1];
	        
	        $rmSel = "SELECT NrArticle, IdLanguage FROM Xevent WHERE FTour_id = '".$tour_id."'";
	        $rmRes = mysql_query($rmSel);
	        while($row = mysql_fetch_assoc($rmRes)) {
	            if ($row['NrArticle'] == $NrArticle && $row['IdLanguage'] == $IdLanguage) {
	                //echo $row['NrArticle'] ."== ".$NrArticle." AAND ".$row['IdLanguage'] ."==". $IdLanguage."<br />";
	            } else {
	                $toBeRemoved[] = $row;
	            }
	        }
	        
	        $this->removeEvent($toBeRemoved);
	    }
	    
	}
}

