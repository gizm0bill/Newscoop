<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

namespace Newscoop\Search;

/**
 * Indexer
 */
class Indexer
{
    /**
     * @var Newscoop\Search\Index
     */
    protected $index;

    /**
     * @var Newscoop\Search\ServiceInterface
     */
    protected $service;

    /**
     * @var Newscoop\Search\RepositoryInterface
     */
    protected $repository;

    /**
     * @param Newscoop\Search\Index $index
     * @param Newscoop\Search\ServiceInterface $service
     * @param Newscoop\Search\RepositoryInterface $repository
     */
    public function __construct(Index $index, ServiceInterface $service, RepositoryInterface $repository = null)
    {
        $this->index = $index;
        $this->service = $service;
        $this->repository = $repository;
    }

    /**
     * Init repository
     *
     * @param sfServiceContainer $container
     * @param string $entity
     */
    public function initRepository(\sfServiceContainer $container, $entity)
    {
        $this->repository = $container->getService('em')->getRepository($entity);
        if (!$this->repository instanceof RepositoryInterface) {
            throw new \RuntimeException("Repository for entity '$entity' must implement Newscoop\Search\RepositoryInterface");
        }
    }

    /**
     * Update index
     *
     * @return void
     */
    public function update()
    {
        $items = $this->repository->getBatch();
        foreach ($items as $item) {
            if ($this->service->isIndexable($item)) {
                $this->index->add($this->service->getDocument($item));
            } else if ($this->service->isIndexed($item)) {
                $this->index->delete($this->service->getDocumentId($item));
            }
        }

        $this->index->flush();
        $this->repository->setIndexedNow($items);
    }

    /**
     * Delete event listener
     *
     * @param sfEvent $event
     * @return void
     */
    public function delete(\sfEvent $event)
    {
        if ($this->service->isIndexed($event['entity'])) {
            $this->index->delete($this->service->getDocumentId($event['entity']));
            $this->index->flush();
        }
    }

    /**
     * Delete all docs
     *
     * @return void
     */
    public function deleteAll()
    {
        $this->index->deleteAll();
        $this->repository->setIndexedNull();
    }
}
