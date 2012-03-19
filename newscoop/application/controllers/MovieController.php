<?php
/**
 * @package Newscoop
 * @copyright 2011 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

/**
 */
class MovieController extends Zend_Controller_Action
{

    public function init()
    {
        return;
    }

    public function indexAction()
    {
        $this->render('index');
    }

    public function searchAction()
    {
        //$movie_key = $this->_getParam('key');
        //$this->view->movie_key = $movie_key;

        $this->render('search');
    }
}
