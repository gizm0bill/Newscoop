<?php

namespace Newscoop\Entity\Proxy;

/**
 * THIS CLASS WAS GENERATED BY THE DOCTRINE ORM. DO NOT EDIT THIS FILE.
 */
class NewscoopEntityUserSubscriberProxy extends \Newscoop\Entity\User\Subscriber implements \Doctrine\ORM\Proxy\Proxy
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
    
    
    public function getSubscriptions()
    {
        $this->__load();
        return parent::getSubscriptions();
    }

    public function hasSubscriptions()
    {
        $this->__load();
        return parent::hasSubscriptions();
    }

    public function getIps()
    {
        $this->__load();
        return parent::getIps();
    }

    public function hasIps()
    {
        $this->__load();
        return parent::hasIps();
    }

    public function getId()
    {
        $this->__load();
        return parent::getId();
    }

    public function setUsername($username)
    {
        $this->__load();
        return parent::setUsername($username);
    }

    public function getUsername()
    {
        $this->__load();
        return parent::getUsername();
    }

    public function setPassword($password)
    {
        $this->__load();
        return parent::setPassword($password);
    }

    public function checkPassword($password)
    {
        $this->__load();
        return parent::checkPassword($password);
    }

    public function setFirstName($first_name)
    {
        $this->__load();
        return parent::setFirstName($first_name);
    }

    public function getFirstName()
    {
        $this->__load();
        return parent::getFirstName();
    }

    public function setLastName($last_name)
    {
        $this->__load();
        return parent::setLastName($last_name);
    }

    public function getLastName()
    {
        $this->__load();
        return parent::getLastName();
    }

    public function getName()
    {
        $this->__load();
        return parent::getName();
    }

    public function getRealName()
    {
        $this->__load();
        return parent::getRealName();
    }

    public function setStatus($status)
    {
        $this->__load();
        return parent::setStatus($status);
    }

    public function getStatus()
    {
        $this->__load();
        return parent::getStatus();
    }

    public function setActive()
    {
        $this->__load();
        return parent::setActive();
    }

    public function isActive()
    {
        $this->__load();
        return parent::isActive();
    }

    public function isPending()
    {
        $this->__load();
        return parent::isPending();
    }

    public function setEmail($email)
    {
        $this->__load();
        return parent::setEmail($email);
    }

    public function getEmail()
    {
        $this->__load();
        return parent::getEmail();
    }

    public function getCreated()
    {
        $this->__load();
        return parent::getCreated();
    }

    public function getUpdated()
    {
        $this->__load();
        return parent::getUpdated();
    }

    public function setAdmin($admin)
    {
        $this->__load();
        return parent::setAdmin($admin);
    }

    public function isAdmin()
    {
        $this->__load();
        return parent::isAdmin();
    }

    public function setPublic($public = true)
    {
        $this->__load();
        return parent::setPublic($public);
    }

    public function isPublic()
    {
        $this->__load();
        return parent::isPublic();
    }

    public function getPoints()
    {
        $this->__load();
        return parent::getPoints();
    }

    public function setPoints($points)
    {
        $this->__load();
        return parent::setPoints($points);
    }

    public function getGroups()
    {
        $this->__load();
        return parent::getGroups();
    }

    public function addUserType(\Newscoop\Entity\User\Group $type)
    {
        $this->__load();
        return parent::addUserType($type);
    }

    public function getUserTypes()
    {
        $this->__load();
        return parent::getUserTypes();
    }

    public function setRole(\Newscoop\Entity\Acl\Role $role)
    {
        $this->__load();
        return parent::setRole($role);
    }

    public function getRoleId()
    {
        $this->__load();
        return parent::getRoleId();
    }

    public function addAttribute($name, $value)
    {
        $this->__load();
        return parent::addAttribute($name, $value);
    }

    public function getAttribute($name)
    {
        $this->__load();
        return parent::getAttribute($name);
    }

    public function getAttributes()
    {
        $this->__load();
        return parent::getAttributes();
    }

    public function setImage($image)
    {
        $this->__load();
        return parent::setImage($image);
    }

    public function getImage()
    {
        $this->__load();
        return parent::getImage();
    }

    public function hasPermission($permission)
    {
        $this->__load();
        return parent::hasPermission($permission);
    }

    public function getCommenters()
    {
        $this->__load();
        return parent::getCommenters();
    }

    public function getComments()
    {
        $this->__load();
        return parent::getComments();
    }

    public function getUserId()
    {
        $this->__load();
        return parent::getUserId();
    }

    public function __toString()
    {
        $this->__load();
        return parent::__toString();
    }

    public function exists()
    {
        $this->__load();
        return parent::exists();
    }

    public function getProperty($p_key)
    {
        $this->__load();
        return parent::getProperty($p_key);
    }

    public function setSubscriber($subscriber)
    {
        $this->__load();
        return parent::setSubscriber($subscriber);
    }

    public function getSubscriber()
    {
        $this->__load();
        return parent::getSubscriber();
    }

    public function setAuthor(\Newscoop\Entity\Author $author = NULL)
    {
        $this->__load();
        return parent::setAuthor($author);
    }

    public function getAuthor()
    {
        $this->__load();
        return parent::getAuthor();
    }

    public function getAuthorId()
    {
        $this->__load();
        return parent::getAuthorId();
    }

    public function preUpdate()
    {
        $this->__load();
        return parent::preUpdate();
    }

    public function setIndexed(\DateTime $indexed = NULL)
    {
        $this->__load();
        return parent::setIndexed($indexed);
    }

    public function getIndexed()
    {
        $this->__load();
        return parent::getIndexed();
    }

    public function getDocumentId()
    {
        $this->__load();
        return parent::getDocumentId();
    }

    public function isIndexable(array $config = array (
))
    {
        $this->__load();
        return parent::isIndexable($config);
    }

    public function getDocument()
    {
        $this->__load();
        return parent::getDocument();
    }


    public function __sleep()
    {
        return array('__isInitialized__', 'id', 'email', 'username', 'password', 'first_name', 'last_name', 'created', 'updated', 'status', 'is_admin', 'is_public', 'points', 'image', 'role', 'groups', 'attributes', 'commenters', 'subscriber', 'author', 'indexed', 'subscriptions', 'ips');
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