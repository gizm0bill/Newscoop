<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

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

        $event_list_data = array();
        foreach ($event_list as $one_event) {
            $one_data = $one_event->getArticleData();

            $event_list_data[] = array(
                'title' => $one_data->getProperty('Fheadline'),
                'description' => $one_data->getProperty('Fdescription'),
                'genres' => array(),
                'street' => $one_data->getProperty('Fstreet'),
                'town' => $one_data->getProperty('Ftown'),
                'country' => ('ch' == strtolower($one_data->getProperty('Fcountry'))) ? 'Schweiz' : $one_data->getProperty('Fcountry'),
                'zipcode' => $one_data->getProperty('Fzipcode'),
                'date_time' => '',
                'web' => $one_data->getProperty('Fweb'),
                'email' => $one_data->getProperty('Femail'),
            );
        }

        $cur_date = date('Y-m-d');
        $cur_date_time = date('Y-m-d H:i:s');

        $output_data = array(
            'date' => $cur_date,
            'regions_last_modified' => $cur_date_time,
            'regions' => array(),
            'genres_last_modified' => $cur_date_time,
            'genres' => array(),
            'events' => $event_list_data,
        );

        echo json_encode($output_data);

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
        switch ($param_region) {
            case 'region-basel':
                $req_region = 'Region Basel';
                break;
            case 'kanton-basel-stadt':
                $req_region = 'Kanton Basel-Stadt';
                break;
            case 'kanton-basel-landschaft':
                $req_region = 'Kanton Basel-Landschaft';
                break;
            case 'kanton-aargau':
                $req_region = 'Kanton Aargau';
                break;
            case 'kanton-appenzell-ausserrhoden':
                $req_region = 'Kanton Appenzell Ausserrhoden';
                break;
            case 'kanton-appenzell-innerrhoden':
                $req_region = 'Kanton Appenzell Innerrhoden';
                break;
            case 'kanton-bern':
                $req_region = 'Kanton Bern';
                break;
            case 'kanton-freiburg':
                $req_region = 'Kanton Freiburg';
                break;
            case 'kanton-genf':
                $req_region = 'Kanton Genf';
                break;
            case 'kanton-glarus':
                $req_region = 'Kanton Glarus';
                break;
            case 'kanton-graubuenden':
                $req_region = 'Kanton Graubünden';
                break;
            case 'kanton-jura':
                $req_region = 'Kanton Jura';
                break;
            case 'kanton-luzern':
                $req_region = 'Kanton Luzern';
                break;
            case 'kanton-neuenburg':
                $req_region = 'Kanton Neuenburg';
                break;
            case 'kanton-nidwalden':
                $req_region = 'Kanton Nidwalden';
                break;
            case 'kanton-obwalden':
                $req_region = 'Kanton Obwalden';
                break;
            case 'kanton-schaffhausen':
                $req_region = 'Kanton Schaffhausen';
                break;
            case 'kanton-schwyz':
                $req_region = 'Kanton Schwyz';
                break;
            case 'kanton-solothurn':
                $req_region = 'Kanton Solothurn';
                break;
            case 'kanton-st-gallen':
                $req_region = 'Kanton St. Gallen';
                break;
            case 'kanton-tessin':
                $req_region = 'Kanton Tessin';
                break;
            case 'kanton-thurgau':
                $req_region = 'Kanton Thurgau';
                break;
            case 'kanton-uri':
                $req_region = 'Kanton Uri';
                break;
            case 'kanton-waadt':
                $req_region = 'Kanton Waadt';
                break;
            case 'kanton-wallis':
                $req_region = 'Kanton Wallis';
                break;
            case 'kanton-zug':
                $req_region = 'Kanton Zug';
                break;
            case 'kanton-zuerich':
                $req_region = 'Kanton Zürich';
                break;
            default:
                break;
        }
        if (!$req_region) {
            return $empty_res;
        }

        $req_type = 'Veranstaltung';
        if (!empty($param_type)) {
            switch ($param_type) {
                case 'ausstellung':
                    $req_type = 'Ausstellung Veranstaltung';
                    break;
                case 'theater':
                    $req_type = 'Theater Veranstaltung';
                    break;
                case 'konzert':
                    $req_type = 'Konzert Veranstaltung';
                    break;
                case 'musik':
                    $req_type = 'Musik Veranstaltung';
                    break;
                case 'party':
                    $req_type = 'Party Veranstaltung';
                    break;
                case 'zirkus':
                    $req_type = 'Zirkus Veranstaltung';
                    break;
                case 'andere':
                    $req_type = 'Andere Veranstaltung';
                    break;
                default:
                    break;
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

