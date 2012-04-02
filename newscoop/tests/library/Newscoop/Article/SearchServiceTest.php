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
class SearchServiceTest extends \TestCase
{
    const TYPE = 'news';
    const RENDITION = 'rend';
    const SECTION = 123;

    public function setUp()
    {
        $this->em = $this->setUpOrm('Newscoop\Entity\Article', 'Newscoop\Entity\Publication', 'Newscoop\Entity\Issue', 'Newscoop\Entity\Section', 'Newscoop\Entity\Language', 'Newscoop\Entity\Alias');

        $this->webcoder = new \Newscoop\Webcode\Mapper();

        $this->renditionService = $this->getMockBuilder('Newscoop\Image\RenditionService')
            ->disableOriginalConstructor()
            ->getMock();

        $this->service = new SearchService($this->webcoder, $this->renditionService, $this->em, array(
            'type' => array(self::TYPE),
            'rendition' => self::RENDITION,
        ));

        $this->language = new Language();
    }

    public function testInstance()
    {
        $this->assertInstanceOf('Newscoop\Article\SearchService', $this->service);
        $this->assertInstanceOf('Newscoop\Search\ServiceInterface', $this->service);
    }

    public function testGetDocumentId()
    {
        $article = new Article(1, $this->language);

        $this->assertEquals('article-1-0', $this->service->getDocumentId($article));
    }

    public function testGetDocument()
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
        $article->setPublished($published = new \DateTime());
        $article->setTitle('title');
        $article->setType('news');
        $article->addAuthor($author = new Author('john', 'doe'));
        $article->setData(array(
            'lede' => 'lede',
            'body' => 'body',
            'tic' => 'toc',
        ));

        $article->setKeywords('key,words');

        $article->setPublication($publication);
        $article->setIssue($issue);
        $article->setSection($section);

        $this->assertEquals($publication->getId(), $article->getPublicationId());
        $this->assertEquals($issue->getNumber(), $article->getIssueNumber());
        $this->assertEquals($section->getNumber(), $article->getSectionNumber());
        $this->assertEquals($language->getId(), $article->getLanguageId());

        $topic = new TopicTree(1, 1);
        $topic->addName('test', $this->language);
        $article->addTopic($topic);

        $this->renditionService->expects($this->once())
            ->method('getArticleRenditionImage')
            ->with($this->equalTo($article->getNumber()), $this->equalTo(self::RENDITION), $this->equalTo(200), $this->equalTo(150))
            ->will($this->returnValue(array('src' => 'artimage')));

        $this->assertEquals(array(
            'id' => 'article-1-1',
            'title' => 'title',
            'type' => 'news',
            'author' => array('john doe'),
            'published' => gmdate('Y-m-d\TH:i:s\Z', $published->getTimestamp()),
            'webcode' => $this->webcoder->encode(1),
            'lead' => 'lede',
            'content' => 'body',
            'image' => 'artimage',
            'link' => 'http://example.com/de/2012_11/sport/1/title.htm',
            'section' => self::SECTION,
            'keyword' => array('key', 'words'),
            'topic' => array('test'),
        ), $this->service->getDocument($article));
    }

    public function testIsIndexed()
    {
        $article = new Article(1, $this->language);

        $this->assertFalse($this->service->isIndexed($article));

        $article->setIndexed(new \DateTime());

        $this->assertTrue($this->service->isIndexed($article));
    }

    public function testIsIndexable()
    {
        $article = new Article(1, $this->language);

        $this->assertFalse($this->service->isIndexable($article));

        $article->setPublished(new \DateTime());

        $this->assertFalse($this->service->isIndexable($article));

        $article->setType(self::TYPE);

        $this->assertTrue($this->service->isIndexable($article));

        $article->setType(uniqid());

        $this->assertFalse($this->service->isIndexable($article));
    }
}
