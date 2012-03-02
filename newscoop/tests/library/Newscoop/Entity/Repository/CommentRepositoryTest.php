<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

namespace Newscoop\Entity\Repository;

use Newscoop\Entity\Comment;

/**
 */
class CommentRepositoryTest extends \TestCase
{
    /**
     * @var Doctrine\ORM\EntityManager
     */
    private $orm;

    /**
     * @var Newscoop\Entity\Repository\CommentRepository
     */
    private $repository;

    public function setUp()
    {
        parent::setUp();
        $this->orm = $this->setUpOrm('Newscoop\Entity\Comment', 'Newscoop\Entity\Language', 'Newscoop\Entity\Article');
        $this->repository = $this->orm->getRepository('Newscoop\Entity\Comment');
    }

    public function testInstance()
    {
        $this->assertInstanceOf('Newscoop\Entity\Repository\CommentRepository', $this->repository);
        $this->assertInstanceOf('Newscoop\Search\IndexableRepositoryInterface', $this->repository);
    }

    public function testFindIndexable()
    {
        $language = new \Newscoop\Entity\Language();
        $this->orm->persist($language);
        $this->orm->flush($language);

        $article = new \Newscoop\Entity\Article(1, $language);
        $this->orm->persist($article);
        $this->orm->flush($article);

        $this->assertEmpty($this->repository->findIndexable());

        $comment = new Comment();
        $comment->setThread($article);
        $comment->setSubject('sub');
        $comment->setMessage('msg');
        $this->orm->persist($comment);
        $this->orm->flush($comment);

        $this->assertNotEmpty($this->repository->findIndexable());

        $comment->setIndexed(new \DateTime('-1 min'));
        $this->orm->flush();

        $this->assertNotEmpty($this->repository->findIndexable());

        $comment->setIndexed(new \DateTime());
        $this->orm->flush();

        $this->assertEmpty($this->repository->findIndexable());
    }
}
