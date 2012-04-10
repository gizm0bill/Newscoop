<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

namespace Newscoop\Services;

use Doctrine\ORM\EntityManager,
    Newscoop\Entity\Article,
    Newscoop\Entity\Language;

/**
 * Article service
 */
class ArticleService
{
    /** @var Doctrine\ORM\EntityManager */
    private $em;


    /**
     * @param array $config
     * @param Doctrine\ORM\EntityManager $em
     */
    public function __construct(EntityManager $em)
    {
        $this->em = $em;
    }

    public function getRelatedArticles(Article $article)
    {
        $contextBox = new \ContextBox(null, $article->getId());
        $articleIds = $contextBox->getArticlesList();
        foreach($articleIds as $articleId) {
            $related[] = $this->find($article->getLanguage(), $articleId);
        }

        return $related;
    }

    public function getComments(Article $article, CommentService $commentService)
    {
        //return $this->commentServicecountBy
    }

    /**
     * Find an article
     *
     * @param Newscoop\Entity\Language
     * @param int $number
     * @return Newscoop\Entity\Article
     */
    public function find(Language $language, $number)
    {
        return $this->getRepository()
            ->find(array('language' => $language->getId(), 'number' => $number));
    }
    
    /**
     * Find by given criteria
     *
     * @param array $criteria
     * @param array|null $orderBy
     * @param int|null $limit
     * @param int|null $offset
     * @return mixed
     */
    public function findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
    {
        return $this->getRepository()->findBy($criteria, $orderBy, $limit, $offset);
    }

    /**
     * Get repository
     *
     * @return Doctrine\ORM\EntityRepository
     */
    private function getRepository()
    {
        return $this->em->getRepository('Newscoop\Entity\Article');
    }
}
