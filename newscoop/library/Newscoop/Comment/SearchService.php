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
     * @var Newscoop\Article\LinkService
     */
    private $articleLinkService;

    /**
     * @param Newscoop\Article\LinkService $articleLinkService
     */
    public function __construct(\Newscoop\Article\LinkService $articleLinkService)
    {
        $this->articleLinkService = $articleLinkService;
    }

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
            'published' => gmdate('Y-m-d\TH:i:s\Z', $comment->getTimeCreated()->getTimestamp()),
            'link' => sprintf('%s#comment_%d', $this->articleLinkService->getLink($comment->getArticle()), $comment->getId()),
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
