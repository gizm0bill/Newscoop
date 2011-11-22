<?php

/**
 * @package Newscoop
 * @copyright 2011 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl.txt
 */

namespace Newscoop\Entity;

use Newscoop\Entity\User, Newscoop\Entity\Comment;

/**
 * CommentRating entity
 * @entity
 * @table(name="comment_rating")
 * @entity(repositoryClass="Newscoop\Entity\Repository\CommentRatingRepository")
 */
class CommentRating
{    
    /**
     * @id @generatedValue
     * @column(type="integer")
     * @var int
     */
    private $id;

    /**
     * @manyToOne(targetEntity="Newscoop\Entity\Comment")
     * @joinColumn(name="comment_id", referencedColumnName="id")
     * @var Newscoop\Entity\Comment
     */
    private $comment;
    
    /**
     * @manyToOne(targetEntity="Newscoop\Entity\User")
     * @joinColumn(name="user_id", referencedColumnName="Id")
     * @var Newscoop\Entity\User
     */
    private $user;
    
    /**
     * @column(length=2)
     * @var int
     */
    private $rating;
    
    /**
     * Get id
     *
     * @return int
     */
    public function getId()
    {
        return $this->id;
    }
    
    /**
     * Set comment
     *
     * @param Newscoop\Entity\Comment $p_comment
     * @return Newscoop\Entity\CommentRating
     */
    public function setComment(Comment $p_comment)
    {
        $this->comment = $p_comment;
        // return this for chaining mechanism
        return $this;
    }

    /**
     * Get comment
     *
     * @return Newscoop\Entity\Comment
     */
    public function getComment()
    {
        return $this->comment;
    }
    
    /**
     * Set user
     *
     * @param Newscoop\Entity\User $p_user
     * @return Newscoop\Entity\Feedback
     */
    public function setUser(User $p_user)
    {
        $this->user = $p_user;
        // return this for chaining mechanism
        return $this;
    }

    /**
     * Get user
     *
     * @return Newscoop\Entity\User
     */
    public function getUser()
    {
        return $this->user;
    }
    
    /**
     * Set rating
     *
     * @return Newscoop\Entity\CommentRating
     */
    public function setRating($rating)
    {
        $this->rating = $rating;
        return $this;
    }

    /**
     * Get rating
     *
     * @return integer
     */
    public function getRating()
    {
        return($this->rating);
    }
}
