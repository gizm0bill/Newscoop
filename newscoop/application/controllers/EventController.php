<?php
/**
 * @package Newscoop
 * @copyright 2011 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

/**
 */
class EventController extends Zend_Controller_Action
{
    const PUBLICATION = 1;
    const LANGUAGE = 5;
    const EV_SECTION = 71; // events
    const EV_TYPE = 'event';

    const EV_TIMEZONE = 'Europe/Zurich';
    const EV_END_TIME = '235959';

    /** @var Newscoop\Services\AgendaService */
    private $m_service = null;

    public function init()
    {
        $this->m_service = $this; // TODO: put a real agenda_service herein
        return;
    }

    public function indexAction()
    {
        $this->render('index');
    }

    public function icalAction()
    {
        //$no_response = '';

        $event_key = $this->_getParam('key');
        $event_date = $this->_getParam('date');
        if ((!$event_key) || (!$event_date)) {
            //echo $no_response;
            $this->_returnNoneIcal();
            exit(0);
        }

        $params = array();

        $params['event_key'] = $event_key;
        $params['event_date'] = $event_date;

        $params['publication'] = self::PUBLICATION;
        $params['language'] = self::LANGUAGE;
        $params['section'] = self::EV_SECTION;
        $params['article_type'] = self::EV_TYPE;

        $ical_info = $this->m_service->getEventIcalInfo($params);

        if ((!isset($ical_info['found'])) || (!$ical_info['found'])) {
            //echo $no_response;
            $this->_returnNoneIcal();
            exit(0);
        }

        $event_date_loc = $ical_info['date'];
        $event_time_loc = $ical_info['time'];

        $event_start_timestamp = strtotime($event_date_loc . ' ' . $event_time_loc . ' ' . self::EV_TIMEZONE);
        $event_start_date_gmt = gmdate('Ymd', $event_start_timestamp);
        $event_start_time_gmt = gmdate('His', $event_start_timestamp);

        $event_end_timestamp = strtotime($event_date_loc . ' ' . self::EV_END_TIME . ' ' . self::EV_TIMEZONE);
        $event_end_date_gmt = gmdate('Ymd', $event_end_timestamp);
        $event_end_time_gmt = gmdate('His', $event_end_timestamp);

        $ical_start = $event_start_date_gmt . 'T'. $event_start_time_gmt . 'Z';
        $ical_end = $event_end_date_gmt . 'T' . $event_end_time_gmt . 'Z';

        // http://stackoverflow.com/questions/1463480/how-can-i-use-php-to-dynamically-publish-an-ical-file-to-be-read-by-google-calen
        // http://stackoverflow.com/questions/5896647/timezone-conversion-in-php
        // http://www.timeanddate.com/worldclock/timezone.html?n=87
        // http://www.php.net/manual/en/timezones.php
        // http://en.wikipedia.org/wiki/ICalendar
        // http://phpicalendar.net/

        //$ical_uid = md5(uniqid(mt_rand(), true)) . '@tageswoche.ch';
        $ical_uid = 'event_' . $ical_info['spec'] . '@tageswoche.ch';

        $ical_name = $ical_info['name'];
        $ical_desc = $ical_info['desc'];
        $ical_location = $ical_info['addr'];
        $ical_organizer = $ical_info['orgn'];

        $ical_str = 'BEGIN:VCALENDAR
VERSION:2.0
PRODID:-//hacksw/handcal//NONSGML v1.0//EN
BEGIN:VEVENT
UID:' . $ical_uid . '
DTSTAMP:' . gmdate('Ymd').'T'. gmdate('His') . 'Z
DTSTART:' . $ical_start . '
SUMMARY:' . $ical_name . '
DESCRIPTION:' . $ical_desc . '
LOCATION:' . $ical_location . '
END:VEVENT
END:VCALENDAR';

// DTEND:' . $ical_end . '
// ORGANIZER:' . $ical_organizer . '

        // http://stackoverflow.com/questions/1395151/content-dispositionwhat-are-the-differences-between-inline-and-attachment
        // header('Content-type: text/html; charset=utf-8');
        header('Content-type: text/calendar; charset=utf-8');
        header('Content-Disposition: inline; filename=calendar.ics');

        echo str_replace("\n", "\r\n", $ical_str);
        exit(0);

    }

    private function _returnNoneIcal()
    {
        header('Status: 404 Not Found');
        echo 'The requested event was not found.';
    }

    public function getEventIcalInfo($p_params)
    {
        $no_event = array('found' => false);
        $max_desc_len = 60;

        $use_publication = $p_params['publication'];
        $use_language = $p_params['language'];
        $use_section = $p_params['section'];
        $use_article_type = $p_params['article_type'];
        $use_event_id = $p_params['event_key'];

        $use_event_date = $p_params['event_date'];
        if (!preg_match('/^[\d]{4}-[\d]{2}-[\d]{2}$/', $use_event_date)) {
            return $no_event;
        }

        $event_list = Article::GetList(array(
            new ComparisonOperation('published', new Operator('is', 'string'), 'true'),
            new ComparisonOperation('IdPublication', new Operator('is', 'integer'), $use_publication),
            new ComparisonOperation('idlanguage', new Operator('is', 'integer'), $use_language),
            new ComparisonOperation('section', new Operator('is', 'integer'), $use_section),
            new ComparisonOperation('type', new Operator('is', 'string'), $use_article_type),
            new ComparisonOperation($use_article_type . '.event_id', new Operator('is', 'string'), $use_event_id),
        ), null, null, 0, $p_count, true);

        if (empty($event_list)) {
            return $no_event;
        }

        $found_event = null;
        $found_event_data = null;
        foreach ($event_list as $one_event) {
            $one_event_data = $one_event->getArticleData();
            if (($one_event_data->getFieldValue('event_id')) == $use_event_id) {
                $found_event = $one_event;
                $found_event_data = $one_event_data;
                break;
            }
        }

        if ((!$found_event) || (!$found_event_data)) {
            return $no_event;
        }
        $em = \Zend_Registry::get('container')->getService('em');
        $repo = $em->getRepository('Newscoop\Entity\ArticleDatetime');
        $dt_list = $repo->findBy(array('articleId'=>$found_event->getArticleNumber()));

        if (empty($dt_list)) {
            return $no_event;
        }

        $event_address = $found_event_data->getProperty('Fstreet') . ', ' . $found_event_data->getProperty('Ftown') . ' ' . $found_event_data->getProperty('Fzipcode');

        $event_desc = '';
        $event_desc_array = explode("\n", '' . $found_event_data->getProperty('Fdescription'));
        if (0 < count($event_desc_array)) {
            $event_desc = $event_desc_array[0];
            if (strlen($event_desc) > $max_desc_len) {
                $event_desc = mb_substr($event_desc, 0, $max_desc_len) . '...';
            }
        }

        $event_ical_info = array(
            'found' => false,
            'date' => $use_event_date,
            'time' => '',
            'spec' => 'e' . $use_event_id . '_d' . $use_event_date,
            'name' => str_replace(array("\n"), array(' '), $found_event_data->getProperty('Fheadline')),
            'addr' => str_replace(array("\n"), array(' '), $event_address),
            'orgn' => str_replace(array("\n"), array(' '), $found_event_data->getProperty('Forganizer')),
            'desc' => $event_desc,
        );

        $regular_types = array('schedule');
        foreach ($dt_list as $one_date_entry) {
            $date_part = date_format($one_date_entry->getStartDate(), 'Y-m-d');
            if ($date_part != $use_event_date) {
                continue;
            }

            if (in_array($one_date_entry->getFieldName(), $regular_types)) {
                $event_ical_info['time'] = date_format($one_date_entry->getStartTime(), 'H:i:s');
                $event_ical_info['found'] = true;

                $event_about = $one_date_entry->getEventComment();
                if (!empty($event_about)) {
                    $event_about_array = explode("\n", '' . $event_about);
                    if (0 < count($event_about_array)) {
                        $event_ical_info['desc'] = $event_about_array[0];
                        if (strlen($event_ical_info['desc']) > $max_desc_len) {
                            $event_ical_info['desc'] = mb_substr($event_ical_info['desc'], 0, $max_desc_len) . '...';
                        }
                    }
                }

            }

        }

        return $event_ical_info;

    }

}
