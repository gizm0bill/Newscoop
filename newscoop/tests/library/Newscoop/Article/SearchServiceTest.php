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
        $this->em = $this->setUpOrm('Newscoop\Entity\Article', 'Newscoop\Entity\Language');

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
