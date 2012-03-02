<?php
/**
 * @package Newscoop
 * @copyright 2011 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl.txt
 */

namespace Newscoop\Entity;

/**
 * Article entity
 *
 * @Entity(repositoryClass="Newscoop\Entity\Repository\ArticleRepository") @HasLifecycleCallbacks
 * @Table(name="Articles")
 */
class Article implements \Newscoop\Search\IndexableInterface
{
    const STATUS_PUBLISHED = 'Y';
    const STATUS_NOT_PUBLISHED = 'N';
    const STATUS_SUBMITTED = 'S';

    const DATE_FORMAT = 'Y-m-d H:i:s';

    /**
     * @Id
     * @ManyToOne(targetEntity="Newscoop\Entity\Language")
     * @JoinColumn(name="IdLanguage", referencedColumnName="Id")
     * @var Newscoop\Entity\Language
     */
    private $language;

    /**
     * @ManyToOne(targetEntity="Newscoop\Entity\Publication")
     * @JoinColumn(name="IdPublication", referencedColumnName="Id")
     * @var Newscoop\Entity\Publication
     */
    private $publication;

    /**
     * @ManyToOne(targetEntity="Newscoop\Entity\Issue")
     * @JoinColumn(name="NrIssue", referencedColumnName="Number")
     * @var Newscoop\Entity\Issue
     */
    private $issue;

    /**
     * @ManyToOne(targetEntity="Newscoop\Entity\Section")
     * @JoinColumn(name="NrSection", referencedColumnName="Number")
     * @var Newscoop\Entity\Section
     */
    private $section;
    
    /**
     * @OneToOne(targetEntity="Newscoop\Entity\User")
     * @JoinColumn(name="IdUser", referencedColumnName="Id")
     * @var Newscoop\Entity\User
     */
    private $creator;

    /**
     * @column(name="NrSection", nullable=True)
     * @var int
     */
    private $sectionId;

    /**
     * @column(name="NrIssue", nullable=True)
     * @var int
     */
    private $issueId;

    /**
     * @Id
     * @Column(type="integer", name="Number")
     * @var int
     */
    private $number;

    /**
     * @Column(name="Name", nullable=True)
     * @var string
     */
    private $name;

    /**
     * @Column(name="time_updated", nullable=True)
     * @var string
     */
    private $date;

    /**
     * @Column(name="comments_enabled", nullable=True)
     * @var int
     */
    private $comments_enabled;
    
    /**
     * @Column(name="Type", nullable=True)
     * @var string
     */
    private $type;
    
    /**
     * @Column(name="PublishDate", nullable=True)
     * @var string
     */
    private $published;
    
    /**
     * @Column(name="Published", nullable=True)
     * @var string
     */
    private $workflowStatus;

    /**
     * @ManyToMany(targetEntity="Newscoop\Entity\Author")
     * @JoinTable(name="ArticleAuthors",
     *      joinColumns={@JoinColumn(name="fk_article_number", referencedColumnName="Number"), @JoinColumn(name="fk_language_id", referencedColumnName="IdLanguage")},
     *      inverseJoinColumns={@JoinColumn(name="fk_author_id", referencedColumnName="id")}
     *      )
     * @var Doctrine\Common\Collections\Collection
     */
    private $authors;

    /**
     * @Column(type="datetime", nullable=True)
     * @var DateTime
     */
    private $indexed;

    /**
     * @var array
     */
    private $data;

    /**
     * @param int $number
     * @param Newscoop\Entity\Language $language
     */
    public function __construct($number, Language $language)
    {
        $this->number = (int) $number;
        $this->language = $language;
        $this->authors = new \Doctrine\Common\Collections\ArrayCollection();

        $this->created = $this->date = date_create()->format(self::DATE_FORMAT); 
    }

    /**
     * Set article id
     *
     * @param int $p_id
     * @return Article
     */
    public function setId($p_id)
    {
        $this->number = $p_id;
        // return this for chaining mechanism
        return $this;
    }

    /**
     * Get article id
     *
     * @return int
     */
    public function getId()
    {
        return $this->number;
    }

    /**
     * Get article name
     *
     * @return string
     */
    public function getName()
    {
        return $this->name;
    }

    /**
     * Set publication
     *
     * @param  Publication $p_publication
     * @return Article
     */
    public function setPublication(Publication $p_publication)
    {
        $this->publication = $p_publication;
        // return this for chaining mechanism
        return $this;
    }

    /**
     * Get publication
     *
     * @return Newscoop\Entity\Publication
     */
    public function getPublication()
    {
        return $this->publication;
    }

    /**
     * Get publication id
     *
     * @return int
     */
    public function getPublicationId()
    {
        return ($this->publication) ? $this->publication->getId() : null;
    }

    /**
     * Get section
     *
     * @return Newscoop\Entity\Section
     */
    public function getSection()
    {
        return $this->section;
    }

    /**
     * Get section id
     *
     * @return int
     */
    public function getSectionId()
    {
        return $this->sectionId;
    }

    /**
     * Get issue id
     *
     * @return int
     */
    public function getIssueId()
    {
        return $this->issueId;
    }

    /**
     * Set language
     *
     * @param  Newscoop\Entity\Language $p_language
     * @return Newscoop\Entity\Article
     */
    public function setLanguage(Language $p_language)
    {
        $this->language = $p_language;
        // return this for chaining mechanism
        return $this;
    }

    /**
     * Get language
     *
     * @return Newscoop\Entity\Language
     */
    public function getLanguage()
    {
        return $this->language;
    }

    /**
     * Get language id
     *
     * @return int
     */
    public function getLanguageId()
    {
        return ($this->language) ? $this->language->getId() : null;
    }


    /**
     * Get number
     *
     * @return int
     */
    public function getNumber()
    {
        return $this->number;
    }

    /**
     * Set title
     *
     * @param string $title
     * @return void
     */
    public function setTitle($title)
    {
        $this->name = (string) $title;
    }

    /**
     * Get title
     *
     * @return string
     */
    public function getTitle()
    {
        return $this->name;
    }

    /**
     * Get date
     *
     * @return string
     */
    public function getDate()
    {
        return $this->date;
    }

    /**
     * Get whether commenting is enabled
     *
     * @return int
     */
    public function commentsEnabled()
    {
        return (int) $this->comments_enabled;
    }

    /**
     * Set type
     *
     * @param string $type
     * @return void
     */
    public function setType($type)
    {
        $this->type = (string) $type;
    }
    
    /**
     * Get type
     *
     * @return string
     */
    public function getType()
    {
        return $this->type;
    }
    
    /**
     * Get publishDate
     *
     * @return string
     */
    public function getPublishDate()
    {
        return $this->published;
    }

    /**
     * Set published
     *
     * @param DateTime $published
     * @return void
     */
    public function setPublished(\DateTime $published)
    {
        $this->setStatus(self::STATUS_PUBLISHED);
        $this->published = $published->format(self::DATE_FORMAT);
    }
    
    /**
     * Set creator
     *
     * @param  User $p_user
     * @return Article
     */
    public function setCreator(User $p_user)
    {
        $this->creator = $p_user;
        // return this for chaining mechanism
        return $this;
    }

    /**
     * Get creator
     *
     * @return Newscoop\Entity\User
     */
    public function getCreator()
    {
        return $this->creator;
    }

    /**
     * Add author
     *
     * @param Newscoop\Entity\Author $author
     * @return void
     */
    public function addAuthor(Author $author)
    {
        $this->authors->add($author);
    }

    /**
     * Get authors
     *
     * @return array
     */
    public function getAuthors()
    {
        return $this->authors->toArray();
    }

    /**
     * Set status
     *
     * @param string $status
     * @return void
     */
    public function setStatus($status)
    {
        $this->workflowStatus = (string) $status;
    }

    /**
     * Set indexed
     *
     * @return void
     */
    public function setIndexed(\DateTime $indexed = null)
    {
        $this->indexed = $indexed;
    }

    /**
     * Get indexed
     *
     * @return DateTime
     */
    public function getIndexed()
    {
        return $this->indexed;
    }

    /**
     * Set updated
     *
     * @param DateTime $updated
     * @return void
     */
    public function setUpdated(\DateTime $updated)
    {
        $this->date = $updated->format(self::DATE_FORMAT);
    }

    /**
     * Set data
     *
     * @param array $data
     * @return void
     */
    public function setData(array $data)
    {
        $this->data = $data;
    }

    /**
     * Get data
     *
     * @param string $field
     * @return mixed
     */
    public function getData($field)
    {
        if ($this->data === null) {
            $this->data = new \ArticleData($this->type, $this->number, $this->getLanguageId());
        }

        if (is_array($this->data)) {
            return array_key_exists($field, $this->data) ? $this->data[$field] : null;
        } else {
            return $this->data->getFieldValue($field);
        }
    }

    /**
     * Get document id
     *
     * @return string
     */
    public function getDocumentId()
    {
        return sprintf('article-%d-%d', $this->number, $this->getLanguageId());
    }

    /**
     * Test if article can be indexed
     *
     * @return bool
     */
    public function isIndexable()
    {
        return $this->workflowStatus === self::STATUS_PUBLISHED && in_array($this->type, array('news'));;
    }

    /**
     * Set webcoder
     *
     * @PostLoad
     * @param Newscoop\Webcode\Mapper $webcoder
     * @return void
     */
    public function setWebcoder(\Newscoop\Webcode\Mapper $webcoder = null)
    {
        $this->webcoder = $webcoder !== null ? $webcoder : self::getDefaultWebcoder();
    }

    /**
     * Get webcode mapper
     *
     * @return Newscoop\Webcode\Mapper
     */
    private static function getDefaultWebcoder()
    {
        static $webcoder;
        if ($webcoder === null) {
            $webcoder = new \Newscoop\Webcode\Mapper;
        }

        return $webcoder;
    }

    /**
     * Get webcode
     *
     * @return string
     */
    public function getWebcode()
    {
        return $this->webcoder->encode($this->number);
    }

    /**
     * Get document
     *
     * @return array
     */
    public function getDocument()
    {
        $doc = array(
            'id' => $this->getDocumentId(),
            'headline' => $this->getTitle(),
            'type' => $this->getType(),
            'published' => gmdate('Y-m-d\TH:i:s\Z', date_create($this->getPublishDate())->getTimestamp()),
            'author' => array_map(function($author) {
                return $author->getFullName();
            }, $this->getAuthors()),
            'webcode' => $this->getWebcode(),
        );

        switch ($this->getType()) {
            case 'blog':
            case 'news':
                $doc['lead'] = $this->getData('lede');
                $doc['content'] = $this->getData('body');
                break;

            case 'dossier':
                $doc['lead'] = $this->getData('lede');
                $doc['content'] = $this->getData('history');
                break;

            case 'newswire':
                $doc['lead'] = $this->getData('DataLead');
                $doc['content'] = $this->getData('DataContent');
                break;
        }

        return array_filter($doc);
    }
}
