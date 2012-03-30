<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

/**
 */
class Application_Form_SearchForm extends Zend_Form
{
    public function init()
    {
        $this->addElement('text', 'q', array(
            'label' => 'Query',
            'required' => true,
            'filters' => array(
                'stringTrim',
            ),
        ));

        $this->addElement('submit', 'submit', array(
            'label' => 'Search',
            'ignore' => true,
        ));
    }
}
