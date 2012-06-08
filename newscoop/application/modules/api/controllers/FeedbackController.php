<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

use Newscoop\Entity\Feedback;

/**
 * Feedback resource controller
 */
class Api_FeedbackController extends Zend_Controller_Action
{
    /** @var Zend_Controller_Request_Http */
    private $request;

    /**
     *
     */
    public function init()
    {
        global $Campsite;

        $this->_helper->layout->disableLayout();
        $this->request = $this->getRequest();
        $this->url = $Campsite['WEBSITE_URL'];
    }

    /**
     *
     */
    public function indexAction()
    {
        $this->getHelper('contextSwitch')->addActionContext('list', 'json')->initContext('json');

        if ($this->request->isPost()) {
            $this->getResponse()->setHttpResponseCode(500);
        }

        $params = $this->request->getPost();
        if (!isset($params['username']) || !isset($params['password'])) {
            $this->getResponse()->setHttpResponseCode(401);
        }

        $user = $this->_helper->service('user')->findOneBy(array('username' => $params['username']));
        if (!$user->checkPassword($params['password'])) {
            $this->getResponse()->setHttpResponseCode(401);
        }

        $feedbackRepository = $this->getHelper('entity')->getRepository('Newscoop\Entity\Feedback');
        $feedback = new Feedback();

        $values = array(
            'user' => $user,
            'subject' => $params['f_feedback_subject'],
            'message' => $params['f_feedback_content'],
        );

        $this->sendMail($values);

        $this->_helper->json(array());
    }

    /**
     * @param array $values
     */
    public function sendMail($values)
    {
        $toEmail = 'dienstpult@tageswoche.ch';

        $fromEmail = $values['user']->getEmail();

        $message = $values['message'];
        $message = $message . '<br>Von <a href="http://www.tageswoche.ch/user/profile/'
            . $values['user']->getUsername() . '">' . $values['user']->getUsername() . '</a> (' . $values['user']->getRealName() . ')';
        $message = $message . '<br>Gesendet von: <a href="' . $values['url'] . '">' . $values['url'].'</a>';

        $mail = new Zend_Mail('utf-8');

        $mail->setSubject('Leserfeedback: ' . $values['subject']);
        $mail->setBodyHtml($message);
        $mail->setFrom($fromEmail);
        $mail->addTo($toEmail);

        try {
            $mail->send();
        } catch (Exception $e) {}

        echo(' ');
    }
}
