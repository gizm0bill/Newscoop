<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

namespace Newscoop\Search;

/**
 * User indexer
 */
class UserIndexer extends IndexerTemplate
{
    /**
     * Get users for indexing
     *
     * @return array
     */
    protected function getIndexable()
    {
        return $this->orm->getRepository('Newscoop\Entity\User')
            ->createQueryBuilder('u')
            ->andWhere('u.indexed IS NULL OR u.indexed < u.updated')
            ->andWhere('u.status = :active')
            ->andWhere('u.is_public = 1')
            ->setMaxResults(50)
            ->getQuery()
            ->setParameters(array(
                'active' => \Newscoop\Entity\User::STATUS_ACTIVE,
            ))
            ->getResult();
    }

    /**
     * Index user entity
     *
     * @param Newscoop\Entity\User $user
     * @return array
     */
    protected function getDocument(IndexableInterface $user)
    {
        return array(
            'id' => sprintf('user-%d', $user->getId()),
            'user' => $user->getUsername(),
            'bio' => $user->getAttribute('bio'),
            'type' => 'user',
        );
    }
}
