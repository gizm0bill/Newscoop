<?php
/**
 * @package Newscoop
 * @copyright 2011 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl.txt
 */

namespace Newscoop\Entity;

use Doctrine\Common\Collections\ArrayCollection;

/**
 * Issue entity
 * @Entity
 * @Table(name="Issues", uniqueConstraints={@UniqueConstraint(name="issues_unique",columns={"IdPublication", "Number", "IdLanguage"})})
 */
class Issue extends Entity
{
    /**
     * Provides the class name as a constant.
     */
    const NAME = __CLASS__;

    /**
     * @ManyToOne(targetEntity="Newscoop\Entity\Publication", inversedBy="issues")
     * @JoinColumn(name="IdPublication", referencedColumnName="Id")
     * @var Newscoop\Entity\Publication
     */
    private $publication;

    /**
     * @Column(type="integer", name="Number")
     * @var int
     */
    private $number;

    /**
     * @ManyToOne(targetEntity="Newscoop\Entity\Language")
     * @JoinColumn(name="IdLanguage", referencedColumnName="Id")
     * @var Newscoop\Entity\Language
     */
    private $language;

    /**
     * @Column(name="Name")
     * @var string
     */
    private $name = '';

    /**
     * @OneToMany(targetEntity="Newscoop\Entity\Section", mappedBy="issue")
     * @var array
     */
    private $sections;

    /**
     * @ManyToOne(targetEntity="Newscoop\Entity\Template")
     * @JoinColumn(name="IssueTplId", referencedColumnName="Id")
     * @var Newscoop\Entity\Template"
     */
    private $template;

    /**
     * @ManyToOne(targetEntity="Newscoop\Entity\Template")
     * @JoinColumn(name="SectionTplId", referencedColumnName="Id")
     * @var Newscoop\Entity\Template"
     */
    private $sectionTemplate;

    /**
     * @ManyToOne(targetEntity="Newscoop\Entity\Template")
     * @JoinColumn(name="ArticleTplId", referencedColumnName="Id")
     * @var Newscoop\Entity\Template"
     */
    private $articleTemplate;

    /**
     * @Column(name="ShortName")
     * @var string
     */
    private $shortName = '';

    /**
    * @OneToMany(targetEntity="Newscoop\Entity\Output\OutputSettingsIssue", mappedBy="issue")
    * @var Newscoop\Entity\Output\OutputSettingsIssue
    */
    private $outputSettingsIssues;

    /**
     * @param int $number
     */
    public function __construct($number)
    {
        $this->number = (int) $number;
        $this->sections = new ArrayCollection;
    }

    /**
     * Set language
     *
     * @param Newscoop\Entity\Language $language
     * @return void
     */
    public function setLanguage(Language $language)
    {
        $this->language = $language;
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
     * Set publication
     *
     * @param Newscoop\Entity\Publication $publication
     * @return void
     */
    public function setPublication(Publication $publication)
    {
        $this->publication = $publication;
    }

    /**
     * Get publication
     *
     * @return Publication
     */
    public function getPublication()
    {
        return $this->publication;
    }

    /**
     * Get publication Id
     *
     * @return int
     */
    public function getPublicationId()
    {
        return $this->publication !== null ? $this->publication->getId() : null;
    }
    /**
     * Get sections
     *
     * @return array
     */
    public function getSections()
    {
        return $this->sections;
    }

    /**
     * Set template
     *
     * @param Newscoop\Entity\Template $template
     * @return Newscoop\Entity\Issue
     */
    public function setTemplate(Template $template)
    {
        $this->template = $template;
        return $this;
    }

    /**
     * Set section template
     *
     * @param Newscoop\Entity\Template $template
     * @return Newscoop\Entity\Issue
     */
    public function setSectionTemplate(Template $template)
    {
        $this->sectionTemplate = $template;
        return $this;
    }

    /**
     * Set article template
     *
     * @param Newscoop\Entity\Template $template
     * @return Newscoop\Entity\Issue
     */
    public function setArticleTemplate(Template $template)
    {
        $this->articleTemplate = $template;
        return $this;
    }

    /**
     * Get name of the issue
     *
     * @return string
     */
    public function getName()
    {
        return $this->name;
    }

    /**
     * Set short name
     *
     * @param string $shortName
     * @return void
     */
    public function setShortName($shortName)
    {
        $this->shortName = (string) $shortName;
    }

    /**
     * Get short name of the issue
     *
     * @return string
     */
    public function getShortName()
    {
        return $this->shortName;
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
}
