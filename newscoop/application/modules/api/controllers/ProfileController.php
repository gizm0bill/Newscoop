<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

require_once __DIR__ . '/AbstractController.php';

/**
 * Profile API
 */
class Api_ProfileController extends AbstractController
{
    /**
     */
    public function subscriptionstatusAction()
    {
        $this->assertIsSecure();

        $user = $this->getUser();
        $subscription = $this->_helper->service('user_subscription')->getActiveSubscription($user);

        $this->_helper->json(array(
            'print_subscription' => !empty($subscription),
            'print_subscription_valid_until' => !empty($subscription) ? $subscription['valid_until'] : null,
            'digital_upgrade' => !empty($subscription) ? (bool) $user->getAttribute(self::DIGITAL_UPGRADE) : false,
            'free_digital_upgrade_consumed' => $this->_helper->service('mobile.free_upgrade')->isConsumed($user),
        ));
    }
}
