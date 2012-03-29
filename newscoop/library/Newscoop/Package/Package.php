<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

namespace Newscoop\Package;

use Newscoop\Image\Rendition;

/**
 * @Entity(repositoryClass="Newscoop\Package\PackageRepository")
 * @Table(name="package",
 *      uniqueConstraints={
 *          @UniqueConstraint(columns={"slug"})
 *      })
 */
class Package
{
    /**
     * @Id @Column(type="integer") @GeneratedValue
     * @var int
     */
    private $id;

    /**
     * @Column
     * @var string
     */
    private $headline;

    /**
     * @Column(type="text", nullable=True)
     * @var string
     */
    private $description;

    /**
     * @OneToMany(targetEntity="Newscoop\Package\Item", mappedBy="package", cascade={"remove"})
     * @OrderBy({"offset"="ASC"})
     * @return Doctrine\Common\Collections\Collection
     */
    private $items;

    /**
     * @ManyToOne(targetEntity="Newscoop\Image\Rendition")
     * @JoinColumn(referencedColumnName="name")
     * @var Newscoop\Image\Rendition
     */
    private $rendition;

    /**
     * @Column(nullable=True)
     * @var string
     */
    private $slug;

    /**
     * @var int
     */
    private $itemsCount;

    /**
     * @ManyToMany(targetEntity="Article", mappedBy="packages", cascade={"remove"})
     * @var array
     */
    private $articles;

    /**
     */
    public function __construct()
    {
        $this->items = new \Doctrine\Common\Collections\ArrayCollection();
        $this->articles = new \Doctrine\Common\Collections\ArrayCollection();
    }

    /**
     * @return string
     */
    public function __toString()
    {
        return sprintf('#%d', $this->id);
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
     * Set headline
     *
     * @param string $headline
     * @return void
     */
    public function setHeadline($headline)
    {
        $this->headline = (string) $headline;
    }

    /**
     * Get headline
     *
     * @return string
     */
    public function getHeadline()
    {
        return $this->headline;
    }

    /**
     * Get items
     *
     * @return Doctrine\Common\Collections\Collection
     */
    public function getItems()
    {
        return $this->items;
    }

    /**
     * Set rendition
     *
     * @param Newscoop\Image\Rendition $rendition
     * @return void
     */
    public function setRendition(Rendition $rendition)
    {
        $this->rendition = $rendition;
    }

    /**
     * Get rendition
     *
     * @return Newscoop\Image\Rendition
     */
    public function getRendition()
    {
        return $this->rendition;
    }

    /**
     * Get previous item
     *
     * @param Newscoop\Package\Item $currentItem
     * @return Newscoop\Package\Item
     */
    public function getPrev(Item $currentItem)
    {
        $prev = null;
        foreach ($this->items as $item) {
            if ($item === $currentItem) {
                return $prev;
            }

            $prev = $item;
        }
    }

    /**
     * Get next item
     *
     * @param Newscoop\Package\Item $currentItem
     * @return Newscoop\Package\Item
     */
    public function getNext(Item $currentItem)
    {
        $iterator = $this->items->getIterator();
        foreach ($iterator as $item) {
            if ($item === $currentItem) {
                $iterator->next();
                return $iterator->valid() ? $iterator->current() : null;
            }
        }
    }

    /**
     * Set slug
     *
     * @param string $slug
     * @return void
     */
    public function setSlug($slug)
    {
        $this->slug = empty($slug) ? null : (string) $slug;
    }

    /**
     * Get slug
     *
     * @return string
     */
    public function getSlug()
    {
        return $this->slug;
    }

    /**
     * Set items count
     *
     * @param int $count
     * @return void
     */
    public function setItemsCount($count)
    {
        $this->itemsCount = (int) $count;
    }

    /**
     * Get items count
     *
     * @return int
     */
    public function getItemsCount()
    {
        return $this->itemsCount !== null ? $this->itemsCount : count($this->items);
    }
}
