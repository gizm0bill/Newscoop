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
    }

    public function testSearchRepositoryInterface()
    {
        $this->assertInstanceOf('Newscoop\Search\RepositoryInterface', $this->repository);
        $this->assertEmpty($this->repository->getBatch());

        $user = new User('email');
        $updated = new \ReflectionProperty($user, 'updated');
        $updated->setAccessible(true);
        $updated->setValue($user, date_create('-1 day')); // utc sqlite fix
        $this->orm->persist($user);
        $this->orm->flush();

        $this->assertNotEmpty($this->repository->getBatch());

        $this->repository->setIndexedNow(array($user));

        $this->assertEmpty($this->repository->getBatch());

        $this->repository->setIndexedNull();

        $this->assertNotEmpty($this->repository->getBatch());
    }

    public function testIndexedNowEmpty()
    {
        $this->assertNull($this->repository->setIndexedNow(array()));
    }
}
