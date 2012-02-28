<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

namespace Newscoop\Search;

use Newscoop\Entity\Article,
    Newscoop\Entity\Language;

/**
 */
class ArticleIndexerTest extends \TestCase
{
    /** @var Newscoop\Search\ArticleIndexer */
    protected $indexer;

    /** @var Doctrine\ORM\EntityManager */
    protected $orm;

    /** @var Newscoop\Entity\Language */
    protected $language;

    /** @var Newscoop\Search\Index */
    protected $index;

    public function setUp()
    {
        $this->orm = $this->setUpOrm('Newscoop\Entity\Article', 'Newscoop\Entity\Language');
        $this->indexer = new ArticleIndexer($this->orm);

        $this->index = $this->getMock('Newscoop\Search\Index');

        $this->language = new Language();
        $this->orm->persist($this->language);
        $this->orm->flush($this->language);
    }

    public function tearDown()
    {
        $this->tearDownOrm($this->orm);
    }

    public function testInstance()
    {
        $this->assertInstanceOf('Newscoop\Search\ArticleIndexer', $this->indexer);
    }

    public function testUpdateNoArticles()
    {
        $this->index->expects($this->never())
            ->method('add');

        $this->indexer->update($this->index);
    }

    public function testUpdateNotPublished()
    {
        $this->orm->persist($article = new Article(1, $this->language));
        $this->orm->flush();

        $this->assertNull(null, $article->getIndexed());

        $this->index->expects($this->never())
            ->method('add');

        $this->indexer->update($this->index);
    }

    public function testUpdateNotUpdated()
    {
        $this->orm->persist($article = new Article(1, $this->language));
        $article->setPublished(new \DateTime('-6 min'));
        $article->setUpdated(new \DateTime('now'));
        $this->orm->flush($article);

        $this->index->expects($this->never())
            ->method('add');

        $this->indexer->update($this->index);
    }

    public function testUpdate()
    {
        $this->orm->persist($article = new Article(1, $this->language));
        $article->setPublished(new \DateTime('-6 min'));
        $article->setUpdated(new \DateTime('-6 min'));
        $this->orm->flush($article);

        $this->index->expects($this->once())
            ->method('add');

        $this->indexer->update($this->index);
        $this->indexer->update($this->index);

        $this->assertNotNull($article->getIndexed());
    }

    public function testIndexBlog()
    {
        $article = $this->createArticle('blog', 'title', array(
            'lede' => 'lede',
            'body' => 'body',
        ));

        $this->index->expects($this->once())
            ->method('add')
            ->with($this->equalTo(array(
                'id' => 'article-1-1',
                'headline' => 'title',
                'lead' => 'lede',
                'content' => 'body',
                'type' => 'blog',
            )));

        $this->indexer->update($this->index);
    }

    public function testIndexDossier()
    {
        $article = $this->createArticle('dossier', 'title', array(
            'lede' => 'lede',
            'history' => 'history',
        ));

        $this->index->expects($this->once())
            ->method('add')
            ->with($this->equalTo(array(
                'id' => 'article-1-1',
                'headline' => 'title',
                'lead' => 'lede',
                'content' => 'history',
                'type' => 'dossier',
            )));

        $this->indexer->update($this->index);
    }

    public function testIndexNews()
    {
        $article = $this->createArticle('news', 'title', array(
            'lede' => 'lede',
            'body' => 'body',
        ));

        $this->index->expects($this->once())
            ->method('add')
            ->with($this->equalTo(array(
                'id' => 'article-1-1',
                'headline' => 'title',
                'lead' => 'lede',
                'content' => 'body',
                'type' => 'news',
            )));

        $this->indexer->update($this->index);
    }

    private function createArticle($type, $headline, $data)
    {
        $article = new Article(1, $this->language);
        $article->setTitle($headline);
        $article->setType($type);
        $article->setData($data);

        $article->setPublished(new \DateTime('-6 min'));
        $article->setUpdated(new \DateTime('-6 min'));

        $this->orm->persist($article);
        $this->orm->flush($article);

        return $article;
    }
}
