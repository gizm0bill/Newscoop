<?php
/**
 * @package Newscoop
 * @copyright 2011 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

namespace Newscoop\Entity\Repository;

use Newscoop\Entity\CommentRating;
use Doctrine\ORM\EntityRepository;

class CommentRatingRepository extends EntityRepository
{
    public function save(CommentRating $commentRating, array $values)
    {
        $em = $this->getEntityManager();
        
        if (is_numeric($values['comment'])) {
            $values['comment'] = $em->find('Newscoop\Entity\Comment', $values['comment']);
        }
        if (is_numeric($values['user'])) {
            $values['user'] = $em->find('Newscoop\Entity\User', $values['user']);
        }
        
        $exists = $this->find(array('comment' => $values['comment']->getId(), 'user' => $values['user']->getId()));
        
        if ($exists) {
            $commentRating = $exists;
        } else {
            $commentRating->setComment($values['comment']);
            $commentRating->setUser($values['user']);
        }
        
        $commentRating->setRating($values['rating']);
        
        $em->persist($commentRating);
        $em->flush();
    }
}