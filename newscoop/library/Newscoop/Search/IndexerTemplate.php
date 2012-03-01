<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

namespace Newscoop\Search;

/**
 * Indexer template
 */
abstract class IndexerTemplate implements IndexerInterface
{
    /**
     * @var Doctrine\ORM\EntityManager
     */
    protected $orm;

    /**
     * Get indexable entities
     *
     * @return array
     */
    abstract protected function getIndexable();

    /**
     * Get document for entity
     *
     * @param mixed $entity
     * @return array
     */
    abstract protected function getDocument(IndexableInterface $entity);

    /**
     * @param Doctrine\ORM\EntityManager $orm
     */
    public function __construct(\Doctrine\ORM\EntityManager $orm)
    {
        $this->orm = $orm;
    }

    /**
     * Update index
     *
     * @return void
     */
    public function update(Index $index)
    {
        foreach ($this->getIndexable() as $indexable) {
            $index->add($this->index($indexable));
        }
    }

    /**
     * Commit entity changes
     *
     * @return void
     */
    public function commit()
    {
        $this->orm->flush();
    }

    /**
     * Index entity
     *
     * @param Newscoop\Search\IndexableInterface $indexable
     * @return array
     */
    final protected function index(IndexableInterface $indexable)
    {
        $indexable->setIndexed(new \DateTime());
        return $this->getDocument($indexable);
    }
}
