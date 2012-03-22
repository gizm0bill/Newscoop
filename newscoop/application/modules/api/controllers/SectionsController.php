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
    const BASE_URL = '/sections/';

    /** @var Zend_Controller_Request_Http */
    private $request;

    /** @var Newscoop\Services\SectionService */
    private $service;

    /**
     *
     */
    public function init()
    {
        $this->_helper->layout->disableLayout();
        $this->request = $this->getRequest();
        $this->service = $this->_helper->service('section');
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
        $publication = $this->_helper->service('publication')
            ->find(2);
        $sections = $this->service->getByPublication($publication);
        $list = array();
        foreach($sections as $section) {
            $list[] = array(
                'name' => $section->getName(),
                'url' => self::BASE_URL . 'item?id=' . $section->getId(), 
            );
        }
        var_dump(Zend_Json::prettyPrint(Zend_Json::encode($list)));
    }

    /**
     * Serve section data.
     *
     * @return json Object
     */
    public function itemAction()
    {
        $id = $this->request->getParam('id');
        $section = $this->service->find($id);
        $response = array(
            'id' => $section->getId(),
            'name' => $section->getName(),
            'articles' => '/articles/list?section=' . $section->getId(),
        );

        var_dump(Zend_Json::prettyPrint(Zend_Json::encode($response)));
    }
}
