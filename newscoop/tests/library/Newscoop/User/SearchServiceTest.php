<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

namespace Newscoop\User;

use Newscoop\Entity\User;

/**
 */
class SearchServiceTest extends \TestCase
{
    public function setUp()
    {
        $this->service = new SearchService();
    }

    public function testInstance()
    {
        $this->assertInstanceOf('Newscoop\User\SearchService', $this->service);
        $this->assertInstanceOf('Newscoop\Search\ServiceInterface', $this->service);
    }

    public function testGetDocumentId()
    {
        $user = new User();
        $this->assertEquals('user-0', $this->service->getDocumentId($user));
    }

    public function testGetDocument()
    {
        $user = new User();
        $user->setUsername('name');
        $user->setImage('someimage.jpg');
        $user->addAttribute('bio', 'abc');

        $this->assertEquals(array(
            'id' => 'user-0',
            'type' => 'user',
            'user' => 'name',
            'bio' => 'abc',
        ), $this->service->getDocument($user));
    }

    public function testIsIndexed()
    {
        $user = new User();
        $this->assertFalse($this->service->isIndexed($user));
        $user->setIndexed(new \DateTime());
        $this->assertTrue($this->service->isIndexed($user));
    }

    public function testIsIndexable()
    {
        $user = new User();
        $this->assertFalse($this->service->isIndexable($user));

        $user->setPublic(true);

        $this->assertFalse($this->service->isIndexable($user));

        $user->setActive();

        $this->assertTrue($this->service->isIndexable($user));

        $user->setPublic(false);

        $this->assertFalse($this->service->isIndexable($user));
    }
}
