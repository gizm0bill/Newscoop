<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

namespace Newscoop\Entity\Repository;

use Newscoop\Entity\Article,
    Newscoop\Entity\Language;

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
    }

    public function testSearchRepositoryInterface()
    {
        $this->assertInstanceOf('Newscoop\Search\RepositoryInterface', $this->repository);
        $this->assertEmpty($this->repository->getBatch());

        $language = new Language();
        $this->orm->persist($language);
        $this->orm->flush();

        $article1 = new Article(1, $language);
        $article2 = new Article(2, $language);
        $article1->setUpdated(new \DateTime('-1 day')); // utc sqlite fix
        $article2->setUpdated(new \DateTime('-1 day')); // utc sqlite fix
        $this->orm->persist($article1);
        $this->orm->persist($article2);
        $this->orm->flush();

        $this->assertEquals(2, count($this->repository->getBatch()));

        $this->repository->setIndexedNow(array($article1));

        $this->assertEquals(1, count($this->repository->getBatch()));
        $this->assertEquals(array($article2), $this->repository->getBatch());

        $this->repository->setIndexedNull();

        $this->assertEquals(2, count($this->repository->getBatch()));
    }

    public function testSetIndexedNowEmpty()
    {
        $this->assertNull($this->repository->setIndexedNow(array()));
    }
}
