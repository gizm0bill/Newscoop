<?php

namespace Newscoop\Entity\Proxy;

/**
 * THIS CLASS WAS GENERATED BY THE DOCTRINE ORM. DO NOT EDIT THIS FILE.
 */
class NewscoopEntityPublicationProxy extends \Newscoop\Entity\Publication implements \Doctrine\ORM\Proxy\Proxy
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
    
    
    public function getName()
    {
        $this->__load();
        return parent::getName();
    }

    public function getLanguage()
    {
        $this->__load();
        return parent::getLanguage();
    }

    public function getIssues()
    {
        $this->__load();
        return parent::getIssues();
    }

    public function getLanguages()
    {
        $this->__load();
        return parent::getLanguages();
    }

    public function getDefaultLanguage()
    {
        $this->__load();
        return parent::getDefaultLanguage();
    }

    public function getDefaultLanguageName()
    {
        $this->__load();
        return parent::getDefaultLanguageName();
    }

    public function getSections()
    {
        $this->__load();
        return parent::getSections();
    }

    public function getId()
    {
        $this->__load();
        return parent::getId();
    }

    public function setId($id)
    {
        $this->__load();
        return parent::setId($id);
    }

    public function setModeratorTo($p_moderator_to)
    {
        $this->__load();
        return parent::setModeratorTo($p_moderator_to);
    }

    public function getModeratorTo()
    {
        $this->__load();
        return parent::getModeratorTo();
    }

    public function setModeratorFrom($p_moderator_from)
    {
        $this->__load();
        return parent::setModeratorFrom($p_moderator_from);
    }

    public function getModeratorFrom()
    {
        $this->__load();
        return parent::getModeratorFrom();
    }

    public function addAlias(\Newscoop\Entity\Alias $alias)
    {
        $this->__load();
        return parent::addAlias($alias);
    }

    public function getAliasName()
    {
        $this->__load();
        return parent::getAliasName();
    }

    public function setSeo(array $seo)
    {
        $this->__load();
        return parent::setSeo($seo);
    }

    public function getSeo()
    {
        $this->__load();
        return parent::getSeo();
    }


    public function __sleep()
    {
        return array('__isInitialized__', 'id', 'name', 'language', 'issues', 'public_enabled', 'moderator_to', 'moderator_from', 'aliases', 'seo');
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