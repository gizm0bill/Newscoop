<?php

namespace Proxy\__CG__\Newscoop\Entity;

/**
 * THIS CLASS WAS GENERATED BY THE DOCTRINE ORM. DO NOT EDIT THIS FILE.
 */
class Article extends \Newscoop\Entity\Article implements \Doctrine\ORM\Proxy\Proxy
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

            if (method_exists($this, "__wakeup")) {
                // call this after __isInitialized__to avoid infinite recursion
                // but before loading to emulate what ClassMetadata::newInstance()
                // provides.
                $this->__wakeup();
            }

            if ($this->_entityPersister->load($this->_identifier, $this) === null) {
                throw new \Doctrine\ORM\EntityNotFoundException();
            }
            unset($this->_entityPersister, $this->_identifier);
        }
    }

    /** @private */
    public function __isInitialized()
    {
        return $this->__isInitialized__;
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

    public function getName()
    {
        $this->__load();
        return parent::getName();
    }

    public function setPublication(\Newscoop\Entity\Publication $p_publication)
    {
        $this->__load();
        return parent::setPublication($p_publication);
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

    public function setSection(\Newscoop\Entity\Section $section)
    {
        $this->__load();
        return parent::setSection($section);
    }

    public function getSection()
    {
        $this->__load();
        return parent::getSection();
    }

    public function getSectionId()
    {
        $this->__load();
        return parent::getSectionId();
    }

    public function getSectionNumber()
    {
        $this->__load();
        return parent::getSectionNumber();
    }

    public function getSectionName()
    {
        $this->__load();
        return parent::getSectionName();
    }

    public function setIssue(\Newscoop\Entity\Issue $issue)
    {
        $this->__load();
        return parent::setIssue($issue);
    }

    public function getIssue()
    {
        $this->__load();
        return parent::getIssue();
    }

    public function getIssueId()
    {
        $this->__load();
        return parent::getIssueId();
    }

    public function getIssueNumber()
    {
        $this->__load();
        return parent::getIssueNumber();
    }

    public function setLanguage(\Newscoop\Entity\Language $p_language)
    {
        $this->__load();
        return parent::setLanguage($p_language);
    }

    public function getLanguage()
    {
        $this->__load();
        return parent::getLanguage();
    }

    public function getLanguageId()
    {
        $this->__load();
        return parent::getLanguageId();
    }

    public function getNumber()
    {
        if ($this->__isInitialized__ === false) {
            return (int) $this->_identifier["number"];
        }
        $this->__load();
        return parent::getNumber();
    }

    public function setTitle($title)
    {
        $this->__load();
        return parent::setTitle($title);
    }

    public function getTitle()
    {
        $this->__load();
        return parent::getTitle();
    }

    public function getDate()
    {
        $this->__load();
        return parent::getDate();
    }

    public function commentsEnabled()
    {
        $this->__load();
        return parent::commentsEnabled();
    }

    public function setType($type)
    {
        $this->__load();
        return parent::setType($type);
    }

    public function getType()
    {
        $this->__load();
        return parent::getType();
    }

    public function getPublishDate()
    {
        $this->__load();
        return parent::getPublishDate();
    }

    public function setPublished(\DateTime $published)
    {
        $this->__load();
        return parent::setPublished($published);
    }

    public function setCreator(\Newscoop\Entity\User $p_user)
    {
        $this->__load();
        return parent::setCreator($p_user);
    }

    public function getCreator()
    {
        $this->__load();
        return parent::getCreator();
    }

    public function addAuthor(\Newscoop\Entity\Author $author)
    {
        $this->__load();
        return parent::addAuthor($author);
    }

    public function getAuthors()
    {
        $this->__load();
        return parent::getAuthors();
    }

    public function setStatus($status)
    {
        $this->__load();
        return parent::setStatus($status);
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

    public function setUpdated(\DateTime $updated)
    {
        $this->__load();
        return parent::setUpdated($updated);
    }

    public function setData(array $data)
    {
        $this->__load();
        return parent::setData($data);
    }

    public function getData($field)
    {
        $this->__load();
        return parent::getData($field);
    }

    public function isPublished()
    {
        $this->__load();
        return parent::isPublished();
    }

    public function addTopic(\Newscoop\Entity\TopicTree $topic)
    {
        $this->__load();
        return parent::addTopic($topic);
    }

    public function getTopicNames()
    {
        $this->__load();
        return parent::getTopicNames();
    }

    public function setKeywords($keywords)
    {
        $this->__load();
        return parent::setKeywords($keywords);
    }

    public function getKeywords()
    {
        $this->__load();
        return parent::getKeywords();
    }


    public function __sleep()
    {
        return array('__isInitialized__', 'sectionId', 'issueId', 'number', 'name', 'date', 'comments_enabled', 'type', 'published', 'workflowStatus', 'indexed', 'keywords', 'language', 'publication', 'issue', 'section', 'creator', 'authors', 'topics');
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