<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

namespace Newscoop\User;

/**
 * Search Service
 */
class SearchService implements \Newscoop\Search\ServiceInterface
{
    /**
     * Test if user is indexed
     *
     * @param Newscoop\Entity\User $user
     * @return bool
     */
    public function isIndexed($user)
    {
        return $user->getIndexed() !== null;
    }

    /**
     * Test if user can be indexed
     *
     * @param Newscoop\Entity\User $user
     * @return bool
     */
    public function isIndexable($user)
    {
        return $user->isPublic() && $user->isActive();
    }

    /**
     * Get document representation for user
     *
     * @param Newscoop\Entity\User $user
     * @return array
     */
    public function getDocument($user)
    {
        return array(
            'id' => $this->getDocumentId($user),
            'type' => 'user',
            'user' => $user->getUsername(),
            'bio' => $user->getAttribute('bio'),
            //'image' => $this->image !== null ? $this->imageService->getSrc($this->image, 65, 65, 'crop') : '',
        );
    }

    /**
     * Get document id
     *
     * @param Newscoop\Entity\User $user
     * @return string
     */
    public function getDocumentId($user)
    {
        return sprintf('user-%d', $user->getId());
    }
}
