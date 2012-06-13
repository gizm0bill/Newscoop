<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

namespace Tageswoche\Mobile;

/**
 * @Entity
 * @Table(name="tw_mobile_upgrade_device")
 */
class UpgradeDevice
{
    /**
     * @Id
     * @Column(length=80)
     * @var string
     */
    private $id;

    /**
     * @ManyToOne(targetEntity="Tageswoche\Mobile\Upgrade", inversedBy="devices")
     * @var Tageswoche\Mobile\Upgrade
     */
    private $upgrade;

    /**
     * @param string $id
     * @param Tageswoche\Mobile\Upgrade $upgrade
     */
    public function __construct($id, Upgrade $upgrade)
    {
        $this->id = $id;
        $this->upgrade = $upgrade;
    }

    /**
     * Get id
     *
     * @return string
     */
    public function getId()
    {
        return $this->id;
    }
}
