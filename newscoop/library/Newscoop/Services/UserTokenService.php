<?php
/**
 * @package Newscoop
 * @copyright 2011 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

namespace Newscoop\Services;

use Newscoop\Entity\User,
    Newscoop\Entity\UserToken;

/**
 * User token service
 */
class UserTokenService
{
    const TOKEN_LENGTH = 40;
    const TOKEN_LIFETIME = 'P5D';

    /** @var Doctrine\ORM\EntityManager */
    protected $em;

    /** @var Doctrine\ORM\EntityRepository */
    protected $repository;

    /**
     * @param Doctrine\ORM\EntityManager $em
     */
    public function __construct(\Doctrine\ORM\EntityManager $em)
    {
        $this->em = $em;
        $this->repository = $this->em->getRepository('Newscoop\Entity\UserToken');
    }

    /**
     * Generate user action token
     *
     * @param Newscoop\Entity\User $user
     * @param string $action
     * @return string
     */
    public function generateToken(User $user, $action = 'any')
    {
        $token = $user->generateRandomString(self::TOKEN_LENGTH);
        $userToken = new UserToken($user, $action, $token);
        $this->em->persist($userToken);
        $this->em->flush($userToken);
        return $token;
    }

    /**
     * Check user action token
     *
     * @param Newscoop\Entity\User $user
     * @param string $token
     * @param string $action
     * @return bool
     */
    public function checkToken(User $user, $token, $action = 'any')
    {
        $userToken = $this->findToken($user, $token, $action);
        if ($userToken === null) {
            return false;
        }

        $now = new \DateTime();
        return $now->sub(new \DateInterval(self::TOKEN_LIFETIME))->getTimestamp() < $userToken->getCreated()->getTimestamp();
    }

    /**
     * Test if given token exists
     *
     * @param Newscoop\Entity\User $user
     * @param string $token
     * @param string $action
     * @return bool
     */
    public function hasToken(User $user, $token, $action = 'any')
    {
        return $this->findToken($user, $token, $action) !== null;
    }

    /**
     * Invalidate token
     *
     * @param Newscoop\Entity\User $user
     * @param string $action
     * @return void
     */
    public function invalidateTokens(User $user, $action = 'any')
    {
        $tokens = $this->em->getRepository('Newscoop\Entity\UserToken')->findBy(array(
            'user' => $user->getId(),
            'action' => $action,
        ));

        foreach ($tokens as $token) {
            $this->em->remove($token);
        }

        $this->em->flush();
    }

    /**
     * Find token
     *
     * @param Newscoop\Entity\User $user
     * @param string $token
     * @param string $action
     * @return Newscoop\Entity\UserToken
     */
    private function findToken(User $user, $token, $action)
    {
        return $this->repository->find(array(
            'user' => $user->getId(),
            'token' => $token,
            'action' => $action,
        ));
    }
}
