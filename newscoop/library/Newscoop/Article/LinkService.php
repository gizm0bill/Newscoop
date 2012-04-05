<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

namespace Newscoop\Article;

/**
 * Link Service
 */
class LinkService
{
    /**
     * @var Doctrine\ORM\EntityManager
     */
    private $em;

    /**
     * @param Doctrine\ORM\EntityManager $em
     */
    public function __construct(\Doctrine\ORM\EntityManager $em)
    {
        $this->em = $em;
    }

    /**
     * Get link
     *
     * @param Newscoop\Entity\Article $article
     * @return string
     */
    public function getLink(\Newscoop\Entity\Article $article)
    {
        $link = implode('/', array(
            trim($article->getPublication()->getAliasName(), '/'),
            $article->getLanguage()->getCode(),
            $this->getIssueShortName($article),
            $this->getSectionShortName($article),
            $article->getNumber(),
            $article->getSeoPath(),
        ));

        return strpos($link, 'http') === 0 ? $link : 'http://' . $link;
    }

    /**
     * Get issue short name
     *
     * @param Newscoop\Entity\Article $article
     * @return string
     */
    public function getIssueShortName(\Newscoop\Entity\Article $article)
    {
        $issue = $this->em->getRepository('Newscoop\Entity\Issue')->findOneBy(array(
            'number' => $article->getIssueNumber(),
            'publication' => $article->getPublicationId(),
            'language' => $article->getLanguageId(),
        ));

        return $issue ? $issue->getShortName() : null;
    }

    /**
     * Get section short name
     *
     * @param Newscoop\Entity\Article $article
     * @return string
     */
    public function getSectionShortName(\Newscoop\Entity\Article $article)
    {
        $section = $this->em->getRepository('Newscoop\Entity\Section')->findOneBy(array(
            'number' => $article->getSectionNumber(),
            'publication' => $article->getPublicationId(),
            'language' => $article->getLanguageId(),
            'issueNumber' => $article->getIssueNumber(),
        ));

        return $section ? $section->getShortName() : null;
    }
}
