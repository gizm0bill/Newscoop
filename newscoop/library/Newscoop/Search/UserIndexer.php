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
class UserIndexer implements IndexerInterface
{
    /**
     * @var Doctrine\ORM\EntityManager
     */
    private $orm;

    /**
     * @param Doctrine\ORM\EntityManager $orm
     */
    public function __construct(\Doctrine\ORM\EntityManager $orm)
    {
        $this->orm = $orm;
    }

    /**
     * Update index
     */
    public function update(Index $index)
    {
        foreach ($this->getUsersForIndexing() as $user) {
            $index->add($this->index($user));
            $this->orm->flush($user);
        }
    }

    /**
     * Get users for indexing
     *
     * @return array
     */
    private function getUsersForIndexing()
    {
        return $this->orm->getRepository('Newscoop\Entity\User')
            ->createQueryBuilder('u')
            ->andWhere('u.status = :active')
            ->andWhere('u.is_public = 1')
            ->andWhere('u.indexed IS NULL OR u.indexed < u.updated')
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
    public function index(\Newscoop\Entity\User $user)
    {
        $user->setIndexed(new \DateTime());
        return array(
            'id' => sprintf('user-%d', $user->getId()),
            'user' => $user->getUsername(),
            'bio' => $user->getAttribute('bio'),
            'type' => 'user',
        );
    }
}
