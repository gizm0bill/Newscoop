<?php
/**
 * @package Newscoop
 * @copyright 2011 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

namespace Newscoop\Entity;

/**
 */
class ArticleTest extends \PHPUnit_Framework_TestCase
{
    public function testGetDocumentId()
    {
        $article = new Article(1, new Language());
        $this->assertEquals('article-1-0', $article->getDocumentId());
    }

    public function testIsIndexable()
    {
        $article = new Article(1, new Language());
        $this->assertFalse($article->isIndexable());

        $article->setPublished(new \DateTime());
        $this->assertTrue($article->isIndexable());
    }

    public function testGetDocument()
    {
        $webcoder = new \Newscoop\Webcode\Mapper();
        $article = new Article(1, new Language());
        $article->setWebcoder($webcoder);
        $article->setPublished($published = new \DateTime());
        $article->setTitle('title');
        $article->setType('news');
        $article->addAuthor(new Author('john', 'doe'));

        $this->assertEquals(array(
            'id' => 'article-1-0',
            'headline' => 'title',
            'type' => 'news',
            'author' => array('john doe'),
            'published' => gmdate('Y-m-d\TH:i:s\Z', $published->getTimestamp()),
            'webcode' => $webcoder->encode(1),
        ), $article->getDocument());
    }
}
