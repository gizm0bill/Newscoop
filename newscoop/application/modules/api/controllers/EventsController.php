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
    const BASE_URL = '/api/events';

    const PUBLICATION = 1;
    const LANGUAGE = 5;
    const EV_SECTION = 71; // events
    const EV_TYPE = 'event';

    /** @var Zend_Controller_Request_Http */
    private $request;

    /** @var array */
    private $m_client;

    /** @var Newscoop\Services\AgendaService */
    private $m_service;

    private $req_date;

    /**
     *
     */
    public function init()
    {
        global $Campsite;

        $this->m_service = $this->_helper->service('agenda');

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
        $basically_correct = true;

        $param_version = $this->_request->getParam('version');
        $param_client = $this->_request->getParam('client');
        if (empty($param_version) || empty($param_client)) {
            $basically_correct = false;
        }
        if (!in_array($param_client, array('iphone', 'iphone_retina', 'ipad', 'ipad_retina'))) {
            $basically_correct = false;
        }

        if (!$basically_correct) {

            $output_data = array();
            //$output_json = json_encode($output_data);
            $output_json = Zend_Json::encode($output_data);

            header('Content-Type: application/json; charset=utf-8');
            header('Content-Length: ' . strlen($output_json));

            echo $output_json;
            exit(0);

        }


        $event_list = $this->_innerListProcess();
//        echo count($event_list);

        $event_list_data = array();
        foreach ($event_list as $one_event) {
            $one_event_types = array();
            $one_data = $one_event->getArticleData();

            $one_date_time = null;
            $one_canceled = false;
            $one_description = '';
            $one_date_info = $this->m_service->getEventDateInfo($one_event, $this->req_date);
            if ($one_date_info['found']) {
                $one_date_time = $one_date_info['date'] . ' ' . $one_date_info['time'];
                $one_canceled = $one_date_info['canceled'];
                $one_description = $one_date_info['about'];
            }
            if (empty($one_description)) {
                $one_description = $one_data->getProperty('Fdescription');
            }

            $one_web = $one_data->getProperty('Fweb');
            if (empty($one_web)) {
                $one_web = null;
            }
            $one_email = $one_data->getProperty('Femail');
            if (empty($one_email)) {
                $one_email = null;
            }

            $event_list_data[] = array(
                'title' => $one_data->getProperty('Fheadline'),
                'description' => $one_description,
                'organizer' => $one_data->getProperty('Forganizer'),
                'street' => $one_data->getProperty('Fstreet'),
                'town' => $one_data->getProperty('Ftown'),
                'country' => ('ch' == strtolower($one_data->getProperty('Fcountry'))) ? 'Schweiz' : $one_data->getProperty('Fcountry'),
                'zipcode' => $one_data->getProperty('Fzipcode'),
                'date_time' => $one_date_time,
                'web' => $one_web,
                'email' => $one_email,
                'canceled' => $one_canceled,
            );
        }

        $cur_date = date('Y-m-d');
        $cur_date_time = date('Y-m-d H:i:s');

        $output_regions = array();
        $output_region_rank = -1;
        foreach ($this->m_service->getRegionList(array('country' => 'ch')) as $region_key => $region_info) {
            $output_region_rank += 1;
            $output_regions[] = array(
                'region_id' => $region_key,
                'region_name' => $region_info['label'],
                'rank' => $output_region_rank,
            );
        }

        if (empty($event_list_data)) {
            $event_list_data = null;
        }

        $output_data = array(
            'date' => $cur_date,
            'regions_last_modified' => $cur_date_time,
            'regions' => $output_regions,
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
        $param_type = $this->_request->getParam('genre'); // $this->_request->getParam('type'); // not required ?
        if (empty($param_date) || empty($param_region) || empty($param_type)) {
            return $empty_res;
        }

        $this->req_date = $this->m_service->getRequestDate($param_date);
        if (!$this->req_date) {
            return $empty_res;
        }

        $req_region = null;
        $region_list = $this->m_service->getRegionList(array('country' => 'ch'));
        foreach ($region_list as $region_key => $region_info) {
            if ($region_key == $param_region) {
                $req_region = $region_info['topic'];
                break;
            }
        }
        if (!$req_region) {
            return $empty_res;
        }

        $req_type = $this->m_service->getRequestEventType($param_type);
        if (!$req_type) {
            return $empty_res;
        }

        $params = array();

        $params['event_date'] = $this->req_date;
        $params['event_region'] = $req_region;
        $params['event_type'] = $req_type;

        $params['publication'] = self::PUBLICATION;
        $params['language'] = self::LANGUAGE;
        $params['section'] = self::EV_SECTION;
        $params['article_type'] = self::EV_TYPE;

        $events = $this->m_service->getEventList($params);

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

