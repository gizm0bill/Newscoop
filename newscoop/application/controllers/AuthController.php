<?php
/**
 * @package Newscoop
 * @copyright 2011 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

/**
 */
class AuthController extends Zend_Controller_Action
{
    /** @var Zend_Auth */
    private $auth;

    public function init()
    {
        $this->_helper->layout->disableLayout();
        $this->auth = Zend_Auth::getInstance();
        
        $this->getHelper('contextSwitch')->addActionContext('password-restore-ajax', 'json')->initContext();
    }

    public function preDispatch()
    {
        if ($this->_getParam('provider') !== 'Facebook' && $this->getRequest()->getActionName() === 'social') {
            $this->_forward('social-error');
        }
    }

    public function indexAction()
    {
        if ($this->auth->hasIdentity()) {
            $this->_helper->redirector('index', 'index');
        }

        $form = new Application_Form_Login();

        $request = $this->getRequest();
        if ($request->isPost() && $form->isValid($request->getPost())) {
            $values = $form->getValues();
            $adapter = $this->_helper->service('auth.adapter');
            $adapter->setEmail($values['email'])->setPassword($values['password']);
            $result = $this->auth->authenticate($adapter);

            if ($result->getCode() == Zend_Auth_Result::SUCCESS) {
                if ($values['persistency'] == '1') {
                    $seconds  = 60 * 60 * 24 * 7; // 7 days
                    Zend_Session::RememberMe($seconds);
                }
                $this->_helper->redirector('index', 'dashboard');
            } else {
                $form->addError($this->view->translate("Invalid credentials"));
            }
        }

        $this->view->form = $form;
    }

    public function logoutAction()
    {
        if ($this->auth->hasIdentity()) {
            $this->auth->clearIdentity();
        }

        $url = $this->_request->getParam('url');
        if (!is_null($url)) {
            $this->_redirect($url);
        }

        $this->_helper->redirector->gotoUrl('?t=' . time());
    }

    public function socialAction()
    {
        if ($this->auth->hasIdentity()) {
            $this->_helper->redirector('index', 'index');
            return;
        }

        try {
            $userData = $this->getUserData();
        } catch (\Exception $e) {
            $this->_forward('social-error');
            return;
        }

        $adapter = $this->_helper->service('auth.adapter.social');
        $adapter->setProvider($this->_getParam('provider'))->setProviderUserId($userData->identifier);
        $result = $this->auth->authenticate($adapter);
        if ($result->getCode() == Zend_Auth_Result::SUCCESS) {
            try {
                $this->_helper->redirector->gotoUrl($this->getRequest()->getServer('HTTP_REFERER'));
            } catch (\Exception $e) {
                $this->_helper->redirector('index', 'dashboard');
            }
        } else { // allow user to create account
            $this->_forward('social', 'register', 'default', array(
                'userData' => $userData,
            ));
        }
    }

    /**
     * Get userdata for given provider
     *
     * @return object
     */
    private function getUserData()
    {
        require_once 'Hybrid/Auth.php';
        $hauth = new Hybrid_Auth(APPLICATION_PATH . '/../hybridauth/config.php');
        $adapter = $hauth->authenticate($this->_getParam('provider'));
        return $adapter->getUserProfile();
    }

    public function mergeAction()
    {
        try {
            $form = new Application_Form_Login();
            $userData = $this->getUserData();
        } catch (\Exception $e) {
            $this->_forward('social-error');
            return;
        }

        if ($this->getRequest()->isPost() && $form->isValid($this->getRequest()->getPost())) {
            $values = $form->getValues();
            $adapter = $this->_helper->service('auth.adapter');
            $adapter->setEmail($values['email'])->setPassword($values['password']);
            $result = $this->auth->authenticate($adapter);

            if ($result->getCode() == Zend_Auth_Result::SUCCESS) {
                $this->_helper->service('auth.adapter.social')->addIdentity($this->_helper->service('user')->getCurrentUser(), $this->_getParam('provider'), $userData->identifier);
                $this->_helper->redirector('index', 'dashboard');
            }
        } else {
            $this->_forward('social');
        }
    }

    public function passwordRestoreAction()
    {
        $form = new Application_Form_PasswordRestore();

        $request = $this->getRequest();
        if ($request->isPost() && $form->isValid($request->getPost())) {
            $user = $this->_helper->service('user')->findOneBy(array(
                'email' => $form->email->getValue(),
            ));

            if (!empty($user) && $user->isActive()) {
                $this->_helper->service('email')->sendPasswordRestoreToken($user);
                $this->_helper->flashMessenger($this->view->translate("E-mail with instructions was sent to given email address."));
                $this->_helper->redirector('password-restore-after', 'auth');
            } else if (empty($user)) {
                $form->email->addError($this->view->translate("Given email not found."));
            }
        }

        $this->view->form = $form;
    }

    public function passwordRestoreAfterAction()
    {
    }
    
    public function passwordRestoreAjaxAction()
    {
        $request = $this->getRequest();
        $parameters = $request->getParams();
        
        if ($request->isPost()) {
            $user = $this->_helper->service('user')->findOneBy(array(
                'email' => $parameters['email'],
            ));

            if (!empty($user) && $user->isActive()) {
                $this->view->response = "Wir haben Ihnen eine E-Mail zum Wiederherstellen Ihres Passworts geschickt.";
                $this->_helper->service('email')->sendPasswordRestoreToken($user);
            } else if (empty($user)) {
                $this->view->response = "Diese E-Mail-Adresse ist bei uns nicht registriert. Ist es die richtige?";
            }
        }
    }

    public function passwordRestoreFinishAction()
    {
        $user = $this->_helper->service('user')->find($this->_getParam('user'));
        if (empty($user)) {
            $this->_helper->flashMessenger(array('error', $this->view->translate('User not found.')));
            $this->_helper->redirector('index', 'index', 'default');
        }

        if (!$user->isActive()) {
            $this->_helper->flashMessenger(array('error', $this->view->translate('User is not active user.')));
            $this->_helper->redirector('index', 'index', 'default');
        }

        $token = $this->_getParam('token', false);
        if (!$token) {
            $this->_helper->flashMessenger(array('error', $this->view->translate('No token provided.')));
            $this->_helper->redirector('index', 'index', 'default');
        }

        if (!$this->_helper->service('user.token')->checkToken($user, $token, 'password.restore')) {
            $this->_helper->flashMessenger(array('error', $this->view->translate('Invalid token.')));
            $this->_helper->redirector('index', 'index', 'default');
        }

        $form = new Application_Form_PasswordRestorePassword();
        $request = $this->getRequest();
        if ($request->isPost() && $form->isValid($request->getPost())) {
            $this->_helper->service('user')->save($form->getValues(), $user);
            $this->_helper->service('user.token')->invalidateTokens($user, 'password.restore');
            if (!$this->auth->hasIdentity()) { // log in
                $adapter = $this->_helper->service('auth.adapter');
                $adapter->setEmail($user->getEmail())->setPassword($form->password->getValue());
                $this->auth->authenticate($adapter);
                $this->_helper->redirector('index', 'dashboard');
            } else {
                $this->_helper->flashMessenger($this->view->translate("Password changed"));
                $this->_helper->redirector('index', 'auth');
            }
        }

        $this->view->form = $form;
    }

    public function socialErrorAction()
    {
    }
}
