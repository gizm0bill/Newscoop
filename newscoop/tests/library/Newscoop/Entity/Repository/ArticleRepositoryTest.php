<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

namespace Newscoop\Entity\Repository;

use Newscoop\Entity\Article;

/**
 */
class ArticleRepositoryTest extends \TestCase
{
    /**
     * @var Doctrine\ORM\EntityManager
     */
    private $orm;

    /**
     * @var Newscoop\Entity\Repository\ArticleRepository
     */
    private $repository;

    public function setUp()
    {
        parent::setUp();
        $this->orm = $this->setUpOrm('Newscoop\Entity\Language', 'Newscoop\Entity\Article');
        $this->repository = $this->orm->getRepository('Newscoop\Entity\Article');
    }

    public function testInstance()
    {
        $this->assertInstanceOf('Newscoop\Entity\Repository\ArticleRepository', $this->repository);
        $this->assertInstanceOf('Newscoop\Search\IndexableRepositoryInterface', $this->repository);
    }

    public function testFindIndexable()
    {
        $language = new \Newscoop\Entity\Language();
        $this->orm->persist($language);
        $this->orm->flush($language);

        $this->assertEmpty($this->repository->findIndexable());

        $article = new \Newscoop\Entity\Article(1, $language);
        $this->orm->persist($article);
        $this->orm->flush($article);

        $this->assertNotEmpty($this->repository->findIndexable());

        $article->setIndexed(new \DateTime('-1 min'));
        $this->orm->flush();

        $this->assertNotEmpty($this->repository->findIndexable());

        $article->setIndexed(new \DateTime());
        $this->orm->flush();

        $this->assertEmpty($this->repository->findIndexable());
    }
}
