<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

namespace Newscoop\Comment;

/**
 * Search Service
 */
class SearchService implements \Newscoop\Search\ServiceInterface
{
    /**
     * Test if comment is indexed
     *
     * @param Newscoop\Entity\Comment $comment
     * @return bool
     */
    public function isIndexed($comment)
    {
        return $comment->getIndexed() !== null;
    }

    /**
     * Test if comment can be indexed
     *
     * @param Newscoop\Entity\Comment $comment
     * @return bool
     */
    public function isIndexable($comment)
    {
        return $comment->getStatus() === 'approved';
    }

    /**
     * Get document for comment
     *
     * @param Newscoop\Entity\Comment $comment
     * @return array
     */
    public function getDocument($comment)
    {
        return array(
            'id' => $this->getDocumentId($comment),
            'type' => 'comment',
            'subject' => $comment->getSubject(),
            'message' => $comment->getMessage(),
        );
    }

    /**
     * Get document id
     *
     * @param Newscoop\Entity\Comment $comment
     * @return string
     */
    public function getDocumentId($comment)
    {
        return sprintf('comment-%d', $comment->getId());
    }
}
