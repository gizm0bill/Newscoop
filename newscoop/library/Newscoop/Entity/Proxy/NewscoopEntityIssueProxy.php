<?php

namespace Newscoop\Entity\Proxy;

/**
 * THIS CLASS WAS GENERATED BY THE DOCTRINE ORM. DO NOT EDIT THIS FILE.
 */
class NewscoopEntityIssueProxy extends \Newscoop\Entity\Issue implements \Doctrine\ORM\Proxy\Proxy
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
    
    
    public function getLanguage()
    {
        $this->__load();
        return parent::getLanguage();
    }

    public function getPublication()
    {
        $this->__load();
        return parent::getPublication();
    }

    public function getPublicationId()
    {
        $this->__load();
        return parent::getPublicationId();
    }

    public function getSections()
    {
        $this->__load();
        return parent::getSections();
    }

    public function setTemplate(\Newscoop\Entity\Template $template)
    {
        $this->__load();
        return parent::setTemplate($template);
    }

    public function setSectionTemplate(\Newscoop\Entity\Template $template)
    {
        $this->__load();
        return parent::setSectionTemplate($template);
    }

    public function setArticleTemplate(\Newscoop\Entity\Template $template)
    {
        $this->__load();
        return parent::setArticleTemplate($template);
    }

    public function getName()
    {
        $this->__load();
        return parent::getName();
    }

    public function setShortName($shortName)
    {
        $this->__load();
        return parent::setShortName($shortName);
    }

    public function getShortName()
    {
        $this->__load();
        return parent::getShortName();
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


    public function __sleep()
    {
        return array('__isInitialized__', 'publication', 'number', 'language', 'name', 'sections', 'template', 'sectionTemplate', 'articleTemplate', 'shortName', 'outputSettingsIssues', 'id');
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