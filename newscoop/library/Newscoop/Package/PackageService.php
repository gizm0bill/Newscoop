<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

namespace Newscoop\Package;

/**
 * Package Service
 */
class PackageService
{
    const CODE_UNIQUE_SLUG = 1;

    /**
     * @var Doctrine\ORM\EntityManager
     */
    private $orm;

    /**
     * @param Doctrine\ORM\EntityManager $orm
     */
    public function __construct(\Doctrine\ORM\EntityManager $orm)
    {
        $this->orm = $orm;
    }

    /**
     * Find package
     *
     * @param int $id
     * @return Newscoop\Package\Package
     */
    public function find($id)
    {
        return $this->orm->getRepository('Newscoop\Package\Package')->find($id);
    }

    /**
     * Find packages by article
     *
     * @param int $articleNumber
     * @return array
     */
    public function findByArticle($articleNumber)
    {
        try {
            return $this->orm->getRepository('Newscoop\Package\Package')->findBy(array(
                'articleNumber' => $articleNumber,
            ), array('id' => 'asc'));
        } catch (\Exception $e) {
            if ($e->getCode() === '42S02') {
                $schemaTool = new \Doctrine\ORM\Tools\SchemaTool($this->orm);
                try {
                    $schemaTool->createSchema(array(
                        $this->orm->getClassMetadata('Newscoop\Package\Package'),
                        $this->orm->getClassMetadata('Newscoop\Package\Item'),
                        $this->orm->getClassMetadata('Newscoop\Image\Rendition'),
                    ));
                } catch (\Exception $e) {
                }
                return array();
            } else {
                throw $e;
            }
        }
    }

    /**
     * Save package
     *
     * @param array $values
     * @param Newscoop\Package\Package $package
     * @return Newscoop\Package\Package
     */
    public function save(array $values, Package $package = null)
    {
        if ($package === null) {
            $package = new Package();
            $this->orm->persist($package);
        }

        if (array_key_exists('article', $values)) {
            $package->setArticleNumber($values['article']);
        }

        if (array_key_exists('headline', $values)) {
            $package->setHeadline($values['headline']);
        }

        if (array_key_exists('rendition', $values)) {
            $package->setRendition($values['rendition']);
        }

        if (array_key_exists('slug', $values)) {
            $package->setSlug($values['slug']);
        }

        try {
            $this->orm->flush($package);
            return $package;
        } catch (\PDOException $e) {
            throw new \InvalidArgumentException("Slug must be unique", self::CODE_UNIQUE_SLUG);
        }
    }

    /**
     * Add package item
     *
     * @param Newscoop\Package\Package $package
     * @param mixed $item
     * @param int $offset
     * @return Newscoop\Package\Item
     */
    public function addItem(Package $package, $item)
    {
        if (is_a($item, 'Newscoop\Image\LocalImage') && !$this->orm->contains($item)) {
            $this->orm->persist($item);
            $this->orm->flush($item);
        }

        if ($package->getRendition() !== null && is_a($item, 'Newscoop\Image\LocalImage') && !$package->getRendition()->fits($item)) {
            throw new \InvalidArgumentException("Image too small.");
        }

        $packageItem = new Item($package, $item);
        $this->orm->persist($packageItem);
        $this->orm->flush();
        return $packageItem;
    }

    /**
     * Set order of items for given package
     *
     * @param Newscoop\Package\Package $package
     * @param array $order
     * @return void
     */
    public function setOrder(Package $package, $order)
    {
        $items = array();
        foreach ($package->getItems() as $item) {
            $offset = array_search('item-' . $item->getId(), $order);
            $package->getItems()->set($offset, $item);
            $package->getItems()->get($offset)->setOffset($offset);
        }

        $this->orm->flush();
    }

    /**
     * Remove item from package
     *
     * @param Newscoop\Package\Package $package
     * @param int $itemId
     * @return void
     */
    public function removeItem(Package $package, $itemId)
    {
        foreach ($package->getItems() as $item) {
            if ($item->getId() === (int) $itemId) {
                for ($i = $item->getOffset() + 1; $i < count($package->getItems()); $i++) {
                    $package->getItems()->set($i - 1, $package->getItems()->get($i));
                    $package->getItems()->get($i - 1)->setOffset($i - 1);
                }

                $package->getItems()->remove(count($package->getItems()) - 1);
                $this->orm->remove($item);
                $this->orm->flush();
                return;
            }
        }
    }

    /**
     * Find item by given id
     *
     * @param int $id
     * @return Newscoop\Package\Item
     */
    public function findItem($id)
    {
        return $this->orm->getRepository('Newscoop\Package\Item')->find($id);
    }

    /**
     * Save item
     *
     * @param array $values
     * @param Newscoop\Package\Item $item
     * @return void
     */
    public function saveItem(array $values, Item $item)
    {
        if (array_key_exists('caption', $values)) {
            $item->setCaption($values['caption']);
        }

        if (array_key_exists('coords', $values)) {
            $item->setCoords($values['coords']);
        }

        if (!empty($values['url'])) {
            $item->setVideoUrl($values['url']);
        }

        $this->orm->flush($item);
    }

    /**
     * Find package by slug
     *
     * @param string $slug
     * @return Newscoop\Package\Package
     */
    public function findBySlug($slug)
    {
        return $this->orm->getRepository('Newscoop\Package\Package')
            ->findOneBy(array(
                'slug' => $slug,
            ));
    }
}
