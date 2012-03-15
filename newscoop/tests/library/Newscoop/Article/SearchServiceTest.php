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
    Newscoop\Entity\ArticleTopic;

/**
 */
class SearchServiceTest extends \TestCase
{
    const TYPE = 'news';

    public function setUp()
    {
        $this->webcoder = new \Newscoop\Webcode\Mapper();
        $this->service = new SearchService($this->webcoder, array('type' => array(self::TYPE)));
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
        $article = new Article(1, $this->language);
        $article->setPublished($published = new \DateTime());
        $article->setTitle('title');
        $article->setType('news');
        $article->addAuthor(new Author('john', 'doe'));

        $this->assertEquals(array(
            'id' => 'article-1-0',
            'title' => 'title',
            'type' => 'news',
            'author' => array('john doe'),
            'published' => gmdate('Y-m-d\TH:i:s\Z', $published->getTimestamp()),
            'webcode' => $this->webcoder->encode(1),
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
