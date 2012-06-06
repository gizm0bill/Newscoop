<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

require_once($GLOBALS['g_campsiteDir'].'/classes/ArticleTopic.php');

/**
 */
class Api_EventsController extends Zend_Controller_Action
{
    const API_VERSION = 1;
    const BASE_URL = '/api/events/';

    const PUBLICATION = 1;
    const LANGUAGE = 5;
    const EV_SECTION = 71; // events
    const EV_TYPE = 'event';

    /** @var Zend_Controller_Request_Http */
    private $request;

    /** @var array */
    private $client;

    /** @var Newscoop\Services\AgendaService */
    private $service;

    /**
     *
     */
    public function init()
    {
        global $Campsite;

        $this->service = $this->_helper->service('agenda');

        //$this->_helper->layout->disableLayout();
        //$this->params = $this->getRequest()->getParams();
        //$this->url = $Campsite['WEBSITE_URL'];
/*
        if (empty($this->params['client'])) {
            print Zend_Json::encode(array());
            exit;
        }
        $this->initClient($this->params['client']);
        if (is_null($this->client['type'])) {
            print Zend_Json::encode(array());
            exit;
        }
*/
    }

    /**
     */
    public function indexAction()
    {
        $this->_forward('list');
    }

    /**
     * Serve list of sections.
     */
    public function listAction()
    {
        $event_list = $this->_innerListProcess();
//        echo count($event_list);

        $event_types_reversed = array();
        foreach ($this->service->getEventTypeList(array('country' => 'ch')) as $type_key => $type_info) {
            $event_types_reversed[$type_info['topic']] = $type_key;
        }

        $event_list_data = array();
        foreach ($event_list as $one_event) {
            $one_event_types = array();
            $one_data = $one_event->getArticleData();
            $one_event_topics = \ArticleTopic::GetArticleTopics($one_event->getArticleNumber());
            foreach ($one_event_topics as $one_topic) {
                $one_topic_name = $one_topic->getName(self::LANGUAGE);
                if (array_key_exists($one_topic_name, $event_types_reversed)) {
                    $one_event_types[] = $event_types_reversed[$one_topic_name];
                }
            }
            if (empty($one_event_types)) {
                $one_event_types = null;
            }

            $event_list_data[] = array(
                'title' => $one_data->getProperty('Fheadline'),
                'description' => $one_data->getProperty('Fdescription'),
                'genres' => $one_event_types,
                'street' => $one_data->getProperty('Fstreet'),
                'town' => $one_data->getProperty('Ftown'),
                'country' => ('ch' == strtolower($one_data->getProperty('Fcountry'))) ? 'Schweiz' : $one_data->getProperty('Fcountry'),
                'zipcode' => $one_data->getProperty('Fzipcode'),
                'date_time' => null,
                'web' => $one_data->getProperty('Fweb'),
                'email' => $one_data->getProperty('Femail'),
            );
        }

        $cur_date = date('Y-m-d');
        $cur_date_time = date('Y-m-d H:i:s');

        $output_regions = array();
        $output_region_rank = -1;
        foreach ($this->service->getRegionList(array('country' => 'ch')) as $region_key => $region_info) {
            $output_region_rank += 1;
            $output_regions[] = array(
                'region_id' => $region_key,
                'region_name' => $region_info['label'],
                'rank' => $output_region_rank,
            );
        }

        $output_types = array();
        $output_type_rank = -1;
        foreach ($this->service->getEventTypeList(array('country' => 'ch')) as $type_key => $type_info) {
            $output_type_rank += 1;
            $output_types[] = array(
                'genre_id' => $type_key,
                'genre_name' => $type_info['label'],
                'rank' => $output_type_rank,
            );
        }

        $output_data = array(
            'date' => $cur_date,
            'regions_last_modified' => $cur_date_time,
            'regions' => $output_regions,
            'genres_last_modified' => $cur_date_time,
            'genres' => $output_types,
            'events' => $event_list_data,
        );

        //$output_json = json_encode($output_data);
        $output_json = Zend_Json::encode($output_data);

        header('Content-Type: application/json; charset=utf-8');
        header('Content-Length: ' . strlen($output_json));

        echo $output_json;

        exit(0);

    }

    /**
     * Serve list of sections.
     */
    private function _innerListProcess()
    {
        $empty_res = array();

        $param_date = $this->_request->getParam('date');
        $param_region = $this->_request->getParam('region');
        $param_type = $this->_request->getParam('type'); // not required
        if (empty($param_date) || empty($param_region)) {
            return $empty_res;
        }

        if (!preg_match('/^[\d]{4}-[\d]{2}-[\d]{2}$/', $param_date)) {
            return $empty_res;
        }

        $req_region = null;
        $region_list = $this->service->getRegionList(array('country' => 'ch'));
        foreach ($region_list as $region_key => $region_info) {
            if ($region_key == $param_region) {
                $req_region = $region_info['topic'];
                break;
            }
        }
        if (!$req_region) {
            return $empty_res;
        }

        $req_type = 'Veranstaltung';
        if (!empty($param_type)) {
            $type_list = $this->service->getEventTypeList(array('country' => 'ch'));
            foreach ($type_list as $type_key => $type_info) {
                if ($type_key == $type_type) {
                    $req_type = $type_info['topic'];
                    break;
                }
            }
        }

        $params = array();

        $params['event_date'] = $param_date;
        $params['event_region'] = $req_region;
        $params['event_type'] = $req_type;

        $params['publication'] = self::PUBLICATION;
        $params['language'] = self::LANGUAGE;
        $params['section'] = self::EV_SECTION;
        $params['article_type'] = self::EV_TYPE;

        $events = $this->service->getEventList($params);

        return $events;

/*
        $this->getHelper('contextSwitch')->addActionContext('list', 'json')->initContext();
        print Zend_Json::encode($events);
*/
    }

/*
    private function initClient($client)
    {
        $type = null;
        if (strstr($client, 'ipad')) {
            $type = 'ipad';
        } elseif (strstr($client, 'iphone')) {
            $type = 'iphone';
        }

        $this->client = array(
            'name' => $client,
            'type' => $type,
        );
    }
*/

}

