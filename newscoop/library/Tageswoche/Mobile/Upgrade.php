<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

namespace Tageswoche\Mobile;

use Newscoop\Entity\User,
    Doctrine\Common\Collections\ArrayCollection as Collection;

/**
 * @Entity
 * @Table(name="tw_mobile_upgrade")
 */
class Upgrade
{
    /**
     * @Id @GeneratedValue
     * @Column(type="integer")
     * @var int
     */
    private $id;

    /**
     * @OneToOne(targetEntity="Newscoop\Entity\User")
     * @JoinColumn(referencedColumnName="Id")
     * @var Newscoop\Entity\User
     */
    private $user;

    /**
     * @Column(length=80)
     * @var string
     */
    private $issue;

    /**
     * @OneToMany(targetEntity="Tageswoche\Mobile\UpgradeDevice", mappedBy="upgrade", cascade={"persist"})
     * @var Doctrine\Common\Collections\Collection
     */
    private $devices;

    /**
     * @param Newscoop\Entity\User $user
     * @param string $issue
     */
    public function __construct(User $user, $issue)
    {
        $this->user = $user;
        $this->issue = (string) $issue;
        $this->devices = new Collection();
    }

    /**
     * Test if upgrade is for given issue
     *
     * @param string $issue
     * @return bool
     */
    public function isIssue($issue)
    {
        return $this->issue === (string) $issue;
    }

    /**
     * Test if upgrade exists for given device
     *
     * @param string $deviceId
     * @return bool
     */
    public function hasDevice($deviceId)
    {
        foreach ($this->devices as $device) {
            if ($device->getId() === $deviceId) {
                return true;
            }
        }

        return false;
    }

    /**
     * Get device count
     *
     * @return int
     */
    public function getDeviceCount()
    {
        return count($this->devices);
    }

    /**
     * Add device
     *
     * @param string $id
     * @return void
     */
    public function addDevice($id)
    {
        $this->devices->add(new UpgradeDevice($id, $this));
    }
}
