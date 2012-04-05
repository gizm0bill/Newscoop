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
        $publication = new Publication();
        $publication->addAlias(new Alias('example.com'));
        $publication->setSeo(array('name' => 'on'));
        $this->em->persist($publication);
        $this->em->flush();

        $language = $this->language;
        $language->setCode('de');
        $this->em->persist($language);
        $this->em->flush();

        $issue = new Issue(1);
        $issue->setShortName('2012_11');
        $issue->setPublication($publication);
        $issue->setLanguage($language);
        $this->em->persist($issue);
        $this->em->flush();

        $section = new Section(self::SECTION, 'Sport');
        $section->setShortName('sport');
        $section->setPublication($publication);
        $section->setIssue($issue);
        $section->setLanguage($language);
        $this->em->persist($section);
        $this->em->flush();

        $article = new Article(1, $this->language);
        $article->setTitle('title');
        $article->setPublication($publication);
        $article->setIssue($issue);
        $article->setSection($section);

        $this->assertEquals($publication->getId(), $article->getPublicationId());
        $this->assertEquals($issue->getNumber(), $article->getIssueNumber());
        $this->assertEquals($section->getNumber(), $article->getSectionNumber());
        $this->assertEquals($language->getId(), $article->getLanguageId());

        $this->assertEquals('http://example.com/de/2012_11/sport/1/title.htm', $this->service->getLink($article));
    }
}
