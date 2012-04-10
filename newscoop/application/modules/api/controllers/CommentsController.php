<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

/**
 */
class Api_CommentsController extends Zend_Controller_Action
{
    /** @var Zend_Controller_Request_Http */
    private $request;

    /** @var Newscoop\Services\CommentService */
    private $service;

    /**
     *
     */
    public function init()
    {
        $this->_helper->layout->disableLayout();
        $this->request = $this->getRequest();
        $this->service = $this->_helper->service('comment');
    }

    /**
     */
    public function indexAction()
    {
        $this->_forward('list');
    }

    /**
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
            );
        }
        var_dump(Zend_Json::prettyPrint(Zend_Json::encode($list)));
    }

    /**
     * Send article info.
     */
    public function itemAction()
    {
        $id = $this->request->getParam('id');
        $section = $this->service->find($id);
        $response = array(
            'id' => $section->getNumber(),
            'name' => $section->getName(),
        );

        var_dump(Zend_Json::prettyPrint(Zend_Json::encode($response)));
    }
}
