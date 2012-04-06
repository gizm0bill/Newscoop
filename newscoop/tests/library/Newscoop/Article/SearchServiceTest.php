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
        $this->em = $this->setUpOrm();

        $this->webcoder = new \Newscoop\Webcode\Mapper();

        $this->renditionService = $this->getMockBuilder('Newscoop\Image\RenditionService')
            ->disableOriginalConstructor()
            ->getMock();

        $this->linkService = $this->getMockBuilder('Newscoop\Article\LinkService')
            ->disableOriginalConstructor()
            ->getMock();

        $this->service = new SearchService($this->webcoder, $this->renditionService, $this->linkService, array(
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
        $language = $this->language;
        $language->setCode('de');

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

        $topic = new TopicTree(1, 1);
        $topic->addName('test', $this->language);
        $article->addTopic($topic);

        $section = new \Newscoop\Entity\Section(self::SECTION, 'Sport');
        $article->setSection($section);

        $this->renditionService->expects($this->once())
            ->method('getArticleRenditionImage')
            ->with($this->equalTo($article->getNumber()), $this->equalTo(self::RENDITION), $this->equalTo(200), $this->equalTo(150))
            ->will($this->returnValue(array('src' => 'artimage')));

        $this->linkService->expects($this->once())
            ->method('getLink')
            ->with($this->equalTo($article))
            ->will($this->returnValue('article-link'));

        $this->linkService->expects($this->once())
            ->method('getSectionShortName')
            ->with($this->equalTo($article))
            ->will($this->returnValue('sport'));

        $this->assertEquals(array(
            'id' => 'article-1-0',
            'title' => 'title',
            'type' => 'news',
            'author' => array('john doe'),
            'published' => gmdate('Y-m-d\TH:i:s\Z', $published->getTimestamp()),
            'webcode' => $this->webcoder->encode(1),
            'lead' => 'lede',
            'content' => 'body',
            'image' => 'artimage',
            'link' => 'article-link',
            'section' => 'sport',
            'section_name' => 'Sport',
            'keyword' => array('key', 'words'),
            'topic' => array('test'),
        ), $this->service->getDocument($article));
    }

    public function testGetDocumentDossier()
    {
        $article = new Article(1, $this->language);
        $article->setType('dossier');
        $article->setTitle('test');

        $doc = $this->service->getDocument($article);
        $this->assertEquals(array(
            'value' => 'test',
            'boost' => 1.5,
        ), $doc['title']);
    }

    public function testGetDocumentBlog()
    {
        $article = new Article(1, $this->language);
        $article->setType('blog');

        $doc = $this->service->getDocument($article);
        $this->assertEquals('blog', $doc['section']);
    }

    public function testDocumentEvent()
    {
        $article = new Article(1, $this->language);
        $article->setType('event');
        $article->setData(array(
            'organizer' => 'org',
            'town' => 'basel',
            'date' => '2012-12-01',
            'time' => '05:20',
        ));

        $doc = $this->service->getDocument($article);
        $this->assertEquals('org', $doc['event_organizer']);
        $this->assertEquals('basel', $doc['event_town']);
        $this->assertEquals('2012-12-01', $doc['event_date']);
        $this->assertEquals('05:20', $doc['event_time']);
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
