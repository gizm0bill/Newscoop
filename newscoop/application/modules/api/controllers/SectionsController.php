<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

/**
 */
class Api_SectionsController extends Zend_Controller_Action
{
    const API_VERSION = 1;
    const BASE_URL = '/api/sections/';

    const IMAGE_STANDARD_WIDTH = 105;
    const IMAGE_STANDARD_HEIGHT = 70;
    const IMAGE_RETINA_FACTOR = 2;

    /** @var Zend_Controller_Request_Http */
    private $request;

    /** @var array */
    private $client;

    /** @var Newscoop\Services\SectionService */
    private $service;

    /**
     *
     */
    public function init()
    {
        global $Campsite;

        $this->_helper->layout->disableLayout();
        $this->params = $this->getRequest()->getParams();
        $this->url = $Campsite['WEBSITE_URL'];

        if (empty($this->params['client'])) {
            print Zend_Json::encode(array());
            exit;
        }
        $this->initClient($this->params['client']);
        if (is_null($this->client['type'])) {
            print Zend_Json::encode(array());
            exit;
        }
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
        $this->getHelper('contextSwitch')->addActionContext('list', 'json')->initContext();

        $sections = array(
            0 => array('name' => 'Front page',
                'url' => $this->url . '/api/articles/list?section_id=6&client=' . $this->client['name'] . '&version=' . self::API_VERSION),
            1 => array('name' => 'Basel',
                'url' => $this->url . '/api/articles/list?section_id=7&client=' . $this->client['name'] . '&version=' . self::API_VERSION),
            2 => array('name' => 'Schweiz',
                'url' => $this->url . '/api/articles/list?section_id=8&client=' . $this->client['name'] . '&version=' . self::API_VERSION),
            3 => array('name' => 'International',
                'url' => $this->url . '/api/articles/list?section_id=9&client=' . $this->client['name'] . '&version=' . self::API_VERSION),
            4 => array('name' => 'Sport',
                'url' => $this->url . '/api/articles/list?section_id=10&client=' . $this->client['name'] . '&version=' . self::API_VERSION),
        );

        print Zend_Json::encode($sections);
    }

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
            'image_width' => self::IMAGE_STANDARD_WIDTH,
            'image_height' => self::IMAGE_STANDARD_HEIGHT,
        );

        if ($this->isClientRetina()) {
            $this->client['image_width'] = $this->client['image_width'] * self::IMAGE_RETINA_FACTOR;
            $this->client['image_height'] = $this->client['image_height'] * self::IMAGE_RETINA_FACTOR;
        }
    }

    private function isClientRetina()
    {
        return $this->client['name'] == 'ipad_retina' || $this->client['name'] == 'iphone_retina';
    }
}

