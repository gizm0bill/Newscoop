<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

namespace Newscoop\Search;

/**
 * Comment indexer
 */
class CommentIndexer extends IndexerTemplate
{
    /**
     * Get comments for indexing
     *
     * @return array
     */
    protected function getIndexable()
    {
        return $this->orm->getRepository('Newscoop\Entity\Comment')
            ->createQueryBuilder('c')
            ->andWhere('c.indexed IS NULL OR c.indexed < c.time_updated')
            ->andWhere('c.status = :approved')
            ->setMaxResults(50)
            ->getQuery()
            ->setParameters(array(
                'approved' => 0,
            ))
            ->getResult();
    }

    /**
     * Get document for comment
     *
     * @param Newscoop\Entity\Comment $comment
     * @return array
     */
    protected function getDocument(IndexableInterface $comment)
    {
        return array(
            'id' => $comment->getDocumentId(),
            'type' => 'comment',
            'subject' => $comment->getSubject(),
            'message' => $comment->getMessage(),
        );
    }
}
