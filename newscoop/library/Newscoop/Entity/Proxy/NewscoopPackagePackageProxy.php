<?php

namespace Newscoop\Entity\Proxy;

/**
 * THIS CLASS WAS GENERATED BY THE DOCTRINE ORM. DO NOT EDIT THIS FILE.
 */
class NewscoopPackagePackageProxy extends \Newscoop\Package\Package implements \Doctrine\ORM\Proxy\Proxy
{
    private $_entityPersister;
    private $_identifier;
    public $__isInitialized__ = false;
    public function __construct($entityPersister, $identifier)
    {
        $this->_entityPersister = $entityPersister;
        $this->_identifier = $identifier;
    }
    /** @private */
    public function __load()
    {
        if (!$this->__isInitialized__ && $this->_entityPersister) {
            $this->__isInitialized__ = true;
            if ($this->_entityPersister->load($this->_identifier, $this) === null) {
                throw new \Doctrine\ORM\EntityNotFoundException();
            }
            unset($this->_entityPersister, $this->_identifier);
        }
    }
    
    
    public function __toString()
    {
        $this->__load();
        return parent::__toString();
    }

    public function getId()
    {
        $this->__load();
        return parent::getId();
    }

    public function setHeadline($headline)
    {
        $this->__load();
        return parent::setHeadline($headline);
    }

    public function getHeadline()
    {
        $this->__load();
        return parent::getHeadline();
    }

    public function getItems()
    {
        $this->__load();
        return parent::getItems();
    }

    public function setRendition(\Newscoop\Image\Rendition $rendition)
    {
        $this->__load();
        return parent::setRendition($rendition);
    }

    public function getRendition()
    {
        $this->__load();
        return parent::getRendition();
    }

    public function getPrev(\Newscoop\Package\Item $currentItem)
    {
        $this->__load();
        return parent::getPrev($currentItem);
    }

    public function getNext(\Newscoop\Package\Item $currentItem)
    {
        $this->__load();
        return parent::getNext($currentItem);
    }

    public function setSlug($slug)
    {
        $this->__load();
        return parent::setSlug($slug);
    }

    public function getSlug()
    {
        $this->__load();
        return parent::getSlug();
    }

    public function setItemsCount($count)
    {
        $this->__load();
        return parent::setItemsCount($count);
    }

    public function getItemsCount()
    {
        $this->__load();
        return parent::getItemsCount();
    }


    public function __sleep()
    {
        return array('__isInitialized__', 'id', 'headline', 'description', 'items', 'rendition', 'slug', 'articles');
    }

    public function __clone()
    {
        if (!$this->__isInitialized__ && $this->_entityPersister) {
            $this->__isInitialized__ = true;
            $class = $this->_entityPersister->getClassMetadata();
            $original = $this->_entityPersister->load($this->_identifier);
            if ($original === null) {
                throw new \Doctrine\ORM\EntityNotFoundException();
            }
            foreach ($class->reflFields AS $field => $reflProperty) {
                $reflProperty->setValue($this, $reflProperty->getValue($original));
            }
            unset($this->_entityPersister, $this->_identifier);
        }
        
    }
}