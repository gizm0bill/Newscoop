<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

namespace Newscoop\Search;

use Newscoop\Entity\Article,
    Newscoop\Entity\Language;

require_once __DIR__ . '/IndexerTestTemplate.php';

/**
 */
class ArticleIndexerTest extends IndexerTestTemplate
{
    const DATE_FORMAT = 'Y-m-d\TH:i:s\Z';

    /** @var Newscoop\Entity\Language */
    protected $language;

    /** @var Newscoop\Webcode\Mapper */
    protected $webcoder;

    public function setUp()
    {
        parent::setUp();
        $this->orm = $this->setUpOrm('Newscoop\Entity\Article', 'Newscoop\Entity\Language', 'Newscoop\Entity\Author');
        $this->webcoder = new \Newscoop\Webcode\Mapper();
        $this->indexer = new ArticleIndexer($this->orm, $this->webcoder);

        $this->language = new Language();
        $this->orm->persist($this->language);
        $this->orm->flush($this->language);
    }

    public function testInstance()
    {
        $this->assertInstanceOf('Newscoop\Search\ArticleIndexer', $this->indexer);
    }

    public function testUpdateNotPublished()
    {
        $this->orm->persist($article = new Article(1, $this->language));
        $this->orm->flush();

        $this->assertNull(null, $article->getIndexed());

        $this->updateExpectNoAdd();
    }

    public function testUpdateNotUpdated()
    {
        $this->orm->persist($article = new Article(1, $this->language));
        $article->setPublished(new \DateTime('-6 min'));
        $article->setUpdated(new \DateTime('now'));
        $this->orm->flush($article);

        $this->updateExpectNoAdd();
    }

    public function testUpdate()
    {
        $article = $this->createArticle('news', 'title', array(), date_create());
        $article->setPublished(new \DateTime('-6 min'));
        $article->setUpdated(new \DateTime('-6 min'));
        $this->orm->flush($article);

        $this->index->expects($this->exactly(2))
            ->method('add');

        $this->indexer->update($this->index);
        $this->indexer->update($this->index);
        $this->indexer->commit();
        $this->indexer->update($this->index);

        $this->assertNotNull($article->getIndexed());
    }

    public function testIndexBlog()
    {
        $article = $this->createArticle('blog', 'title', array(
            'lede' => 'lede',
            'body' => 'body',
        ), $published = date_create('-6 min'));

        $this->index->expects($this->once())
            ->method('add')
            ->with($this->equalTo(array(
                'id' => 'article-1-1',
                'headline' => 'title',
                'lead' => 'lede',
                'content' => 'body',
                'type' => 'blog',
                'published' => gmdate(self::DATE_FORMAT, $published->getTimestamp()),
                'webcode' => $this->webcode(1),
            )));

        $this->indexer->update($this->index);
    }

    public function testIndexDossier()
    {
        $article = $this->createArticle('dossier', 'title', array(
            'lede' => 'lede',
            'history' => 'history',
        ), $published = date_create('-16 min'));

        $this->index->expects($this->once())
            ->method('add')
            ->with($this->equalTo(array(
                'id' => 'article-1-1',
                'headline' => 'title',
                'lead' => 'lede',
                'content' => 'history',
                'type' => 'dossier',
                'published' => gmdate(self::DATE_FORMAT, $published->getTimestamp()),
                'webcode' => $this->webcode(1),
            )));

        $this->indexer->update($this->index);
    }

    public function testIndexNews()
    {
        $article = $this->createArticle('news', 'title', array(
            'lede' => 'lede',
            'body' => 'body',
        ), $published = date_create('-60 min'));

        $this->index->expects($this->once())
            ->method('add')
            ->with($this->equalTo(array(
                'id' => 'article-1-1',
                'headline' => 'title',
                'lead' => 'lede',
                'content' => 'body',
                'type' => 'news',
                'published' => gmdate(self::DATE_FORMAT, $published->getTimestamp()),
                'webcode' => $this->webcode(1),
            )));

        $this->indexer->update($this->index);
    }

    public function testArticleAuthors()
    {
        $article = $this->createArticle('news', 'title', array(), $published = date_create('-1 day'));

        $this->orm->persist($author = new \Newscoop\Entity\Author('john', 'doe'));
        $this->orm->flush($author);
        $article->addAuthor($author);

        $this->index->expects($this->once())
            ->method('add')
            ->with($this->equalTo(array(
                'id' => 'article-1-1',
                'headline' => 'title',
                'type' => 'news',
                'author' => array('john doe'),
                'published' => gmdate(self::DATE_FORMAT, $published->getTimestamp()),
                'webcode' => $this->webcode(1),
            )));

        $this->indexer->update($this->index);
    }

    private function createArticle($type, $headline, $data, $published = null)
    {
        $article = new Article(1, $this->language);
        $article->setTitle($headline);
        $article->setType($type);
        $article->setData($data);

        $article->setPublished($published === null ? new \DateTime('-6 min') : $published);
        $article->setUpdated(new \DateTime('-6 min'));

        $this->orm->persist($article);
        $this->orm->flush($article);

        return $article;
    }

    private function webcode($number)
    {
        return $this->webcoder->encode($number);
    }
}
