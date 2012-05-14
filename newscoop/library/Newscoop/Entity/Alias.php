<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

namespace Newscoop\Entity;

/**
 * @Entity
 * @Table(name="Aliases")
 */
class Alias
{
    /**
     * @Id @GeneratedValue
     * @Column(type="integer", name="Id")
     * @var int
     */
    private $id;

    /**
     * @Column(type="string", length=80, name="Name")
     * @var string
     */
    private $name;

    /**
     * @ManyToOne(targetEntity="Newscoop\Entity\Publication", inversedBy="aliases")
     * @JoinColumn(name="IdPublication", referencedColumnName="Id")
     * @var Newscoop\Entity\Publication
     */
    private $publication;

    /**
     * @param string $name
     */
    public function __construct($name)
    {
        $this->name = (string) $name;
    }

    /**
     * Get id
     *
     * @return int
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * Get name
     *
     * @return string
     */
    public function getName()
    {
        return $this->name;
    }

    /**
     * Set publication
     *
     * @param Newscoop\Entity\Publication $publication
     * @return void
     */
    public function setPublication(Publication $publication)
    {
        $this->publication = $publication;
    }
}
