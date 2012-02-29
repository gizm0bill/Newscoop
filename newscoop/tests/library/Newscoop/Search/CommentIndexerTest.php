<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

namespace Newscoop\Search;

use Newscoop\Entity\Comment;

/**
 */
class CommentIndexerTest extends \TestCase
{
    /** @var Newscoop\Search\CommentIndexer */
    protected $indexer;

    /** @var Doctrine\ORM\EntityManager */
    protected $orm;

    /** @var Newscoop\Search\Index */
    protected $index;

    public function setUp()
    {
        $this->orm = $this->setUpOrm('Newscoop\Entity\Comment', 'Newscoop\Entity\Article', 'Newscoop\Entity\Language');
        $this->indexer = new CommentIndexer($this->orm);
        $this->index = $this->getMock('Newscoop\Search\Index');
    }

    public function tearDown()
    {
        $this->tearDownOrm($this->orm);
    }

    public function testInstance()
    {
        $this->assertInstanceOf('Newscoop\Search\CommentIndexer', $this->indexer);
        $this->assertInstanceOf('Newscoop\Search\IndexerInterface', $this->indexer);
    }

    public function testUpdateNoComments()
    {
        $this->index->expects($this->never())
            ->method('add');

        $this->indexer->update($this->index);
    }

    public function testUpdatePending()
    {
        $comment = $this->getComment('sub', 'msg');

        $this->index->expects($this->never())
            ->method('add');

        $this->indexer->update($this->index);
    }

    public function testUpdate()
    {
        $comment = $this->getComment('subj', 'messg');
        $comment->setStatus('approved');
        $this->orm->flush($comment);

        $this->index->expects($this->once())
            ->method('add')
            ->with($this->equalTo(array(
                'id' => 'comment-1',
                'type' => 'comment',
                'subject' => 'subj',
                'message' => 'messg',
            )));

        $this->indexer->update($this->index);
    }

    /**
     * Get comment
     *
     * @param string $subject
     * @param string $message
     * @return Newscoop\Entity\Comment
     */
    private function getComment($subject, $message)
    {
        $language = new \Newscoop\Entity\Language();
        $this->orm->persist($language);
        $this->orm->flush($language);

        $article = new \Newscoop\Entity\Article(1, $language);
        $this->orm->persist($article);
        $this->orm->flush($article);

        $comment = new Comment();
        $comment->setThread($article);
        $comment->setSubject($subject);
        $comment->setMessage($message);
        $comment->setThreadLevel(1);
        $comment->setThreadOrder(1);

        $this->orm->persist($comment);
        $this->orm->flush($comment);
        return $comment;
    }
}
