<?php
/**
 * @package Tageswoche
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

namespace Tageswoche\Mobile;

use Doctrine\ORM\EntityManager;

/**
 */
class FreeUpgradeFacade
{
    const DEVICE_LIMIT = 5;

    /**
     * @var Doctrine\ORM\EntityManager
     */
    private $em;

    /**
     * @param Doctrine\ORM\EntityManager $em
     */
    public function __construct(EntityManager $em)
    {
        $this->em = $em;
    }

    /**
     * Add device to free upgrade
     *
     * @param string $device
     * @param Newscoop\Entity\User $user
     * @param string $issue
     * @return bool
     */
    public function addDevice($device, $user, $issue)
    {
        $upgrade = $this->getRepository()->findOneBy(array(
            'user' => $user,
        ));

        if (empty($upgrade)) {
            $upgrade = new Upgrade($user, $issue);
            $this->em->persist($upgrade);
            $this->em->flush($upgrade);
        }

        if (!$upgrade->isIssue($issue)) {
            return false;
        }

        if (!$upgrade->hasDevice($device) && $upgrade->getDeviceCount() >= self::DEVICE_LIMIT) {
            return false;
        }

        if (!$upgrade->hasDevice($device)) {
            $upgrade->addDevice($device);
            $this->em->flush($upgrade);
        }

        return true;
    }

    /**
     * Get repository
     *
     * @return Doctrine\ORM\EntityRepository
     */
    private function getRepository()
    {
        return $this->em->getRepository('Tageswoche\Mobile\Upgrade');
    }
}
