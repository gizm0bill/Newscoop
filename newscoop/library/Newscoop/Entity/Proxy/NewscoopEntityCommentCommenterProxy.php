<?php

namespace Newscoop\Entity\Proxy;

/**
 * THIS CLASS WAS GENERATED BY THE DOCTRINE ORM. DO NOT EDIT THIS FILE.
 */
class NewscoopEntityCommentCommenterProxy extends \Newscoop\Entity\Comment\Commenter implements \Doctrine\ORM\Proxy\Proxy
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
    
    
    public function setId($p_id)
    {
        $this->__load();
        return parent::setId($p_id);
    }

    public function getId()
    {
        $this->__load();
        return parent::getId();
    }

    public function setName($p_name)
    {
        $this->__load();
        return parent::setName($p_name);
    }

    public function getName()
    {
        $this->__load();
        return parent::getName();
    }

    public function setEmail($p_email)
    {
        $this->__load();
        return parent::setEmail($p_email);
    }

    public function getEmail()
    {
        $this->__load();
        return parent::getEmail();
    }

    public function setUser(\Newscoop\Entity\User $user)
    {
        $this->__load();
        return parent::setUser($user);
    }

    public function getUser()
    {
        $this->__load();
        return parent::getUser();
    }

    public function setUrl($p_url)
    {
        $this->__load();
        return parent::setUrl($p_url);
    }

    public function getUrl()
    {
        $this->__load();
        return parent::getUrl();
    }

    public function setIp($p_ip)
    {
        $this->__load();
        return parent::setIp($p_ip);
    }

    public function getIp()
    {
        $this->__load();
        return parent::getIp();
    }

    public function setTimeCreated(\DateTime $p_datetime)
    {
        $this->__load();
        return parent::setTimeCreated($p_datetime);
    }

    public function getTimeCreated()
    {
        $this->__load();
        return parent::getTimeCreated();
    }

    public function getUserName()
    {
        $this->__load();
        return parent::getUserName();
    }

    public function getLoginName()
    {
        $this->__load();
        return parent::getLoginName();
    }

    public function getUserId()
    {
        $this->__load();
        return parent::getUserId();
    }

    public function getComments()
    {
        $this->__load();
        return parent::getComments();
    }


    public function __sleep()
    {
        return array('__isInitialized__', 'id', 'user', 'name', 'email', 'url', 'ip', 'time_created', 'comments');
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