<?php
/**
 * @package Newscoop
 * @copyright 2011 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

namespace Newscoop\Services;

use Doctrine\ORM\EntityManager;

/**
 * User service
 */
class CommentService
{
    /** @var Doctrine\ORM\EntityManager */
    private $em;

    /**
     * @param Doctrine\ORM\EntityManager $em
     */
    public function __construct(EntityManager $em)
    {
        $this->em = $em;
    }

    private function comment_create($params)
    {
        $comment = $this->find($params['id']);

        $commenter = $comment->getCommenter();
        $user = $commenter->getUser();

        if (!isset($user)) {
            return;
        }

        $attribute_value = $user->getAttribute("comment_delivered");
        $attribute_value = isset($attribute_value) ? ($attribute_value + 1) : 1;

        $user->addAttribute("comment_delivered", $attribute_value);

        $points_action = $this->em->getRepository('Newscoop\Entity\UserPoints')
                    ->getPointValueForAction("comment_delivered");

        $points = $user->getPoints();

        $user->setPoints($points+$points_action);
    }

    private function comment_recommended($params)
    {
        $comment = $this->find($params['id']);

        $commenter = $comment->getCommenter();
        $user = $commenter->getUser();

        if (!isset($user)) {
            return;
        }

        $attribute_value = $user->getAttribute("comment_recommended");
        $attribute_value = isset($attribute_value) ? ($attribute_value + 1) : 1;

        $user->addAttribute("comment_recommended", $attribute_value);

        $points_action = $this->em->getRepository('Newscoop\Entity\UserPoints')
                    ->getPointValueForAction("comment_recommended");

        $points = $user->getPoints();

        $user->setPoints($points+$points_action);
    }

    private function comment_update($params)
    {
        $comment = $this->find($params['id']);
    }

    private function comment_delete($params)
    {
        $comment = $this->find($params['id']);

        $commenter = $comment->getCommenter();
        $user = $commenter->getUser();

        if (!isset($user)) {
            return;
        }

        $attribute_value = $user->getAttribute("comment_deleted");
        $attribute_value = isset($attribute_value) ? ($attribute_value + 1) : 1;

        $user->addAttribute("comment_deleted", $attribute_value);

        //have to remove points for a deleted comment.
        $points_action = $this->em->getRepository('Newscoop\Entity\UserPoints')
                    ->getPointValueForAction("comment_delivered");

        $points = $user->getPoints();

        $user->setPoints($points-$points_action);
    }


    /**
     * Receives notifications of points events.
     *
     * @param sfEvent $event
     * @return void
     */
    public function update(\sfEvent $event)
    {
        $params = $event->getParameters();
        list($resource, $action) = explode('.', $event->getName());

        $method = $resource."_".$action;
        $this->$method($params);

        $this->em->flush();
    }

    /**
     * Get total count for given criteria
     *
     * @param array $criteria
     * @return int
     */
    public function countBy(array $criteria)
    {
        return count($this->findBy($criteria));
    }

    /**
     * Find a comment by its id.
     *
     * @param int $id
     * @return Newscoop\Entity\Comment
     *
     */
    public function find($id)
    {
        return $this->em->getRepository('Newscoop\Entity\Comment')
            ->find($id);
    }

    /**
     * Find records by set of criteria
     *
     * @param array $criteria
     * @param array|null $orderBy
     * @param int|null $limit
     * @param int|null $offset
     * @return array
     */
    public function findBy(array $criteria, $orderBy = null, $limit = null, $offset = null)
    {
        return $this->em->getRepository('Newscoop\Entity\Comment')
            ->findBy($criteria, $orderBy, $limit, $offset);
    }

    public function findUserComments($params, $order, $p_limit, $p_start)
    {
        $qb = $this->em->createQueryBuilder();

        $qb->select('c');
        $qb->from('Newscoop\Entity\Comment', 'c');

        $conditions = $qb->expr()->andx();
        $conditions->add($qb->expr()->in("c.commenter", $params["commenters"]));

        $qb->where($conditions);

        foreach ($order as $column => $direction) {
            $qb->addOrderBy("c.$column", $direction);
        }

        $qb->setFirstResult($p_start);
        $qb->setMaxResults($p_limit);

        //echo $qb->getQuery()->getSql();

        return $qb->getQuery()->getResult();
    }

    /**
     * Get repository for comment entity
     *
     * @return Newscoop\Entity\Repository\CommentRepository
     */
    private function getRepository()
    {
        return $this->em->getRepository('Newscoop\Entity\Comment');
    }

    /**
     * Get articles comment count
     * 
     * @param mixed $ids
     * @return array
     */
    public function getArticlesCommentCount($ids)
    {
        $ids = (array) $ids;
        if (empty($ids)) {
            return array();
        }

        $rows = $this->em->getRepository('Newscoop\Entity\Comment')
            ->createQueryBuilder('c')
            ->select('COUNT(c), c.article_num')
            ->where('c.article_num IN (:ids)')
            ->groupBy('c.article_num')
            ->getQuery()
            ->setParameter('ids', $ids)
            ->getResult();

        $counts = array();
        foreach ($rows as $row) {
            $counts[$row['article_num']] = (int) $row[1];
        }

        return $counts;
    }
}
