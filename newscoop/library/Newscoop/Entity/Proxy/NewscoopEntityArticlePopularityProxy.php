<?php

namespace Newscoop\Entity\Proxy;

/**
 * THIS CLASS WAS GENERATED BY THE DOCTRINE ORM. DO NOT EDIT THIS FILE.
 */
class NewscoopEntityArticlePopularityProxy extends \Newscoop\Entity\ArticlePopularity implements \Doctrine\ORM\Proxy\Proxy
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
    
    
    public function getArticleId()
    {
        $this->__load();
        return parent::getArticleId();
    }

    public function setArticleId($id)
    {
        $this->__load();
        return parent::setArticleId($id);
    }

    public function getLanguageId()
    {
        $this->__load();
        return parent::getLanguageId();
    }

    public function setLanguageId($id)
    {
        $this->__load();
        return parent::setLanguageId($id);
    }

    public function getURL()
    {
        $this->__load();
        return parent::getURL();
    }

    public function setURL($url)
    {
        $this->__load();
        return parent::setURL($url);
    }

    public function getDate()
    {
        $this->__load();
        return parent::getDate();
    }

    public function setDate(\DateTime $date)
    {
        $this->__load();
        return parent::setDate($date);
    }

    public function getUniqueViews()
    {
        $this->__load();
        return parent::getUniqueViews();
    }

    public function setUniqueViews($views)
    {
        $this->__load();
        return parent::setUniqueViews($views);
    }

    public function getAvgTimeOnPage()
    {
        $this->__load();
        return parent::getAvgTimeOnPage();
    }

    public function setAvgTimeOnPage($time)
    {
        $this->__load();
        return parent::setAvgTimeOnPage($time);
    }

    public function getTweets()
    {
        $this->__load();
        return parent::getTweets();
    }

    public function setTweets($tweets)
    {
        $this->__load();
        return parent::setTweets($tweets);
    }

    public function getLikes()
    {
        $this->__load();
        return parent::getLikes();
    }

    public function setLikes($likes)
    {
        $this->__load();
        return parent::setLikes($likes);
    }

    public function getComments()
    {
        $this->__load();
        return parent::getComments();
    }

    public function setComments($comments)
    {
        $this->__load();
        return parent::setComments($comments);
    }

    public function getPopularity()
    {
        $this->__load();
        return parent::getPopularity();
    }

    public function setPopularity($points)
    {
        $this->__load();
        return parent::setPopularity($points);
    }


    public function __sleep()
    {
        return array('__isInitialized__', 'article_id', 'language_id', 'url', 'date', 'unique_views', 'avg_time_on_page', 'tweets', 'likes', 'comments', 'popularity');
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