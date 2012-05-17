<?php
/**
 * @package Newscoop
 * @copyright 2011 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

namespace Newscoop\Entity;

/**
 * @Entity
 * @Table(name="TopicNames")
 */
class Topic
{
    /**
     * @Id @ManyToOne(targetEntity="Newscoop\Entity\TopicTree", inversedBy="names")
     * @JoinColumn(name="fk_topic_id", referencedColumnName="id")
     * @var Newscoop\Entity\TopicTree
     */
    private $topic;

    /**
     * @Id @ManyToOne(targetEntity="Newscoop\Entity\Language")
     * @JoinColumn(name="fk_language_id", referencedColumnName="Id")
     * @var Newscoop\Entity\Language
     */
    private $language;

    /**
     * @Column(type="string", length=255)
     * @var string
     */
    private $name;

    /**
     * @param Newscoop\Entity\TopicTree $topic
     * @param Newscoop\Entity\Language $language
     * @param string $name
     */
    public function __construct(TopicTree $topic, Language $language, $name)
    {
        $this->topic = $topic;
        $this->language = $language;
        $this->name = (string) $name;
    }

    /**
     * Get topic id
     *
     * @return int
     */
    public function getTopicId()
    {
        return $this->topic->getId();
    }

    /**
     * Get language id
     *
     * @return int
     */
    public function getLanguageId()
    {
        return $this->language->getId();
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
     * @return string
     */
    public function __toString()
    {
        return (string) $this->name;
    }
}
