<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

namespace Newscoop\Comment;

use Newscoop\Entity\Comment;

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
        $this->assertInstanceOf('Newscoop\Comment\SearchService', $this->service);
        $this->assertInstanceOf('Newscoop\Search\ServiceInterface', $this->service);
    }

    public function testGetDocumentId()
    {
        $comment = new Comment();
        $this->assertEquals('comment-0', $this->service->getDocumentId($comment));
    }

    public function testGetDocument()
    {
        $created = new \DateTime();
        $comment = new Comment();
        $comment->setSubject('sub');
        $comment->setMessage('msg');
        $comment->setTimeCreated($created);

        $this->assertEquals(array(
            'id' => 'comment-0',
            'type' => 'comment',
            'subject' => 'sub',
            'message' => 'msg',
            'published' => gmdate('Y-m-d\TH:i:s\Z', $created->getTimestamp()),
        ), $this->service->getDocument($comment));
    }

    public function testIsIndexed()
    {
        $comment = new Comment();
        $this->assertFalse($this->service->isIndexed($comment));
        $comment->setIndexed(new \DateTime());
        $this->assertTrue($this->service->isIndexed($comment));
    }

    public function testIsIndexable()
    {
        $comment = new Comment();
        $this->assertFalse($this->service->isIndexable($comment));
        $comment->setStatus('approved');
        $this->assertTrue($this->service->isIndexable($comment));
    }
}
