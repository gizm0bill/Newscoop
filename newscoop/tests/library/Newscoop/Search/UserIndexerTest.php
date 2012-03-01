<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

namespace Newscoop\Search;

use Newscoop\Entity\User;

require_once __DIR__ . '/IndexerTestTemplate.php';

/**
 */
class UserIndexerTest extends IndexerTestTemplate
{
    public function setUp()
    {
        parent::setUp();
        $this->orm = $this->setUpOrm('Newscoop\Entity\User', 'Newscoop\Entity\Acl\Role', 'Newscoop\Entity\UserAttribute');
        $this->indexer = new UserIndexer($this->orm);
    }

    public function testInstance()
    {
        $this->assertInstanceOf('Newscoop\Search\UserIndexer', $this->indexer);
        $this->assertInstanceOf('Newscoop\Search\IndexerInterface', $this->indexer);
    }

    public function testUpdateNotActiveNotPublic()
    {
        $user = new User('email');
        $this->orm->persist($user);
        $this->orm->flush($user);

        $this->updateExpectNoAdd();
    }

    public function testUpdateActiveNotPublic()
    {
        $user = new User('email');
        $user->setActive(true);
        $this->orm->persist($user);
        $this->orm->flush($user);

        $this->updateExpectNoAdd();
    }

    public function testUpdateNotActivePublic()
    {
        $user = new User('email');
        $user->setPublic(true);
        $this->orm->persist($user);
        $this->orm->flush($user);

        $this->updateExpectNoAdd();
    }

    public function testUpdate()
    {
        $user = new User('email');
        $this->orm->persist($user);
        $this->orm->flush($user);

        $user->setUsername('uname');
        $user->setActive(true);
        $user->setPublic(true);
        $user->addAttribute('bio', 'ubio');
        $this->orm->flush($user);

        $this->index->expects($this->once())
            ->method('add')
            ->with($this->equalTo(array(
                'id' => 'user-1',
                'user' => 'uname',
                'bio' => 'ubio',
                'type' => 'user',
            )));

        $this->indexer->update($this->index);
        $this->indexer->commit();
        $this->orm->clear();
        $this->indexer->update($this->index);
    }
}
