<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

namespace Newscoop\Services;

use Doctrine\ORM\EntityManager,
    Newscoop\Entity\Publication;

/**
 * Publication service
 */
class PublicationService
{
    /** Doctrine\ORM\EntityManager */
    private $em;


    /**
     * @param Doctrine\ORM\EntityManager $em
     */
    public function __construct(EntityManager $em)
    {
        $this->em = $em;
    }

    /**
     * Find by id
     *
     * @param int $id
     * @return Newscoop\Entity\Publication
     */
    public function find($id)
    {
        return $this->getRepository()
            ->find($id);
    }

    /**
     * Get publication repository
     *
     * @return Doctrine\ORM\EntityRepository
     */
    private function getRepository()
    {
        return $this->em->getRepository('Newscoop\Entity\Publication');
    }
}
