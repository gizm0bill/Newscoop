<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

namespace Newscoop\Article;

use Newscoop\Entity\Language,
    Newscoop\Entity\Article,
    Newscoop\Entity\Author,
    Newscoop\Entity\ArticleTopic,
    Newscoop\Entity\Publication,
    Newscoop\Entity\Alias,
    Newscoop\Entity\Issue,
    Newscoop\Entity\Section,
    Newscoop\Entity\TopicTree;

/**
 */
class LinkServiceTest extends \TestCase
{
    const SECTION = 123;

    public function setUp()
    {
        $this->em = $this->setUpOrm('Newscoop\Entity\Article', 'Newscoop\Entity\Publication', 'Newscoop\Entity\Issue', 'Newscoop\Entity\Section', 'Newscoop\Entity\Language', 'Newscoop\Entity\Alias');
        $this->service = new LinkService($this->em);
        $this->language = new Language();

        $this->publication = new Publication();
        $this->publication->addAlias(new Alias('example.com'));
        $this->publication->setSeo(array('name' => 'on'));
        $this->em->persist($this->publication);

        $this->language->setCode('de');
        $this->em->persist($this->language);

        $this->em->flush();

        $this->issue = new Issue(1);
        $this->issue->setShortName('2012_11');
        $this->issue->setPublication($this->publication);
        $this->issue->setLanguage($this->language);
        $this->em->persist($this->issue);

        $this->em->flush();

        $this->section = new Section(self::SECTION, 'Sport');
        $this->section->setShortName('sport');
        $this->section->setPublication($this->publication);
        $this->section->setIssue($this->issue);
        $this->section->setLanguage($this->language);
        $this->em->persist($this->section);

        $this->em->flush();
    }

    public function tearDown()
    {
        $this->tearDownOrm($this->em);
    }

    public function testInstance()
    {
        $this->assertInstanceOf('Newscoop\Article\LinkService', $this->service);
    }

    public function testGetLink()
    {
        $article = new Article(1, $this->language);
        $article->setType('news');
        $article->setTitle('title');
        $article->setPublication($this->publication);
        $article->setIssue($this->issue);
        $article->setSection($this->section);

        $this->assertEquals($this->publication->getId(), $article->getPublicationId());
        $this->assertEquals($this->issue->getNumber(), $article->getIssueNumber());
        $this->assertEquals($this->section->getNumber(), $article->getSectionNumber());
        $this->assertEquals($this->language->getId(), $article->getLanguageId());

        $this->assertEquals('http://example.com/de/2012_11/sport/1/title.htm', $this->service->getLink($article));
    }

    public function testGetLinkBloginfo()
    {
        $article = new Article(1, $this->language);
        $article->setType('bloginfo');
        $article->setTitle('BlogInfo');
        $article->setPublication($this->publication);
        $article->setIssue($this->issue);
        $article->setSection($this->section);

        $this->assertEquals('http://example.com/de/2012_11/sport/', $this->service->getLink($article));
    }
}
