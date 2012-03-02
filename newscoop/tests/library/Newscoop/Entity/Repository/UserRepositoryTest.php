<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

namespace Newscoop\Entity\Repository;

use Newscoop\Entity\User;

/**
 */
class UserRepositoryTest extends \TestCase
{
    /**
     * @var Doctrine\ORM\EntityManager
     */
    private $orm;

    /**
     * @var Newscoop\Entity\Repository\UserRepository
     */
    private $repository;

    public function setUp()
    {
        parent::setUp();
        $this->orm = $this->setUpOrm('Newscoop\Entity\User', 'Newscoop\Entity\Acl\Role', 'Newscoop\Entity\UserAttribute');
        $this->repository = $this->orm->getRepository('Newscoop\Entity\User');
    }

    public function testInstance()
    {
        $this->assertInstanceOf('Newscoop\Entity\Repository\UserRepository', $this->repository);
        $this->assertInstanceOf('Newscoop\Search\IndexableRepositoryInterface', $this->repository);
    }

    public function testFindIndexable()
    {
        $this->assertEmpty($this->repository->findIndexable());

        $user = new User('email');
        $this->orm->persist($user);
        $this->orm->flush($user);

        $this->assertNotEmpty($this->repository->findIndexable());

        $user->setIndexed(new \DateTime('-1 min'));
        $this->orm->flush();

        $this->assertNotEmpty($this->repository->findIndexable());

        $user->setIndexed(new \DateTime());
        $this->orm->flush();

        $this->assertEmpty($this->repository->findIndexable());
    }
}
