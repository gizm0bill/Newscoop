<?php
/**
 * @package Newscoop
 * @copyright 2011 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

/**
 */
class Application_Form_Confirm extends Zend_Form
{
    public function init()
    {
        $this->setAttrib('enctype', 'multipart/form-data');

        $this->addElement('text', 'first_name', array(
            'label' => 'First Name*:',
            'required' => true,
            'filters' => array('stringTrim'),
        ));

        $this->addElement('text', 'last_name', array(
            'label' => 'Last Name*:',
            'required' => true,
            'filters' => array('stringTrim'),
        ));

        $this->addElement('text', 'username', array(
            'label' => 'Username*:',
            'required' => true,
            'filters' => array('stringTrim'),
        ));

        $this->addElement('file', 'image', array(
            'label' => 'Profile image',
            'maxfilesize' => $this->getMaxFileSize(),
        ));

        $this->addElement('password', 'password', array(
            'label' => 'Password*:',
            'required' => true,
            'filters' => array('stringTrim'),
            'validators' => array(
                array('stringLength', false, array(6, 80)),
            ),
        ));

        $this->addElement('password', 'password_confirm', array(
            'label' => 'Password Confirmation*:',
            'required' => true,
            'filters' => array('stringTrim'),
            'validators' => array(
                new Zend_Validate_Callback(function ($value, $context) {
                    return $value == $context['password'];
                }),
            ),
            'errorMessages' => array("Password confirmation does not match your password."),
        ));

        $this->addElement('checkbox', 'terms_of_use', array(
            'label' => 'Accepting terms of use',
            'required' => true,
            'validators' => array(
                array('greaterThan', true, array('min' => 0)),
            ),
            'errorMessages' => array("You must accept the terms of use."),
        ));

        $this->addElement('submit', 'submit', array(
            'label' => 'Login',
            'ignore' => true,
        ));
    }

    /**
     * Get max file size
     *
     * @return int
     */
    private function getMaxFileSize()
    {
        $maxFileSize = SystemPref::Get("MaxProfileImageFileSize") ?: ini_get('upload_max_filesize');
        return camp_convert_bytes($maxFileSize);
    }
}
