<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

namespace Newscoop\Search;

/**
 * Index
 */
class Index
{
    /**
     * @var Zend_Http_Client
     */
    private $client;

    /**
     * @var Doctrine\ORM\EntityManager
     */
    private $orm;

    /**
     * @var array
     */
    private $repositories = array();

    /**
     * @var array
     */
    private $add = array();

    /**
     * @var array
     */
    private $delete = array();

    /**
     * @param Zend_Http_Client $client
     * @param Doctrine\ORM\EntityManager $orm
     */
    public function __construct(\Zend_Http_Client $client, \Doctrine\ORM\EntityManager $orm)
    {
        $this->client = $client;
        $this->orm = $orm;
    }

    /**
     * Add repository
     *
     * @param Newscoop\Search\IndexableRepositoryInterface $repository
     * @return void
     */
    public function addRepository(IndexableRepositoryInterface $repository)
    {
        $this->repositories[] = $repository;
    }

    /**
     * Update index
     *
     * @return void
     */
    public function update()
    {
        foreach ($this->repositories as $repository) {
            $updated = array();
            foreach ($repository->findIndexable() as $indexable) {
                if ($indexable->isIndexable()) {
                    $this->add[] = $indexable->getDocument();
                } else if ($indexable->getIndexed() !== null) {
                    $this->delete[] = $indexable->getDocumentId();
                }

                $updated[] = $indexable;
            }

            $this->flush();
            if (!empty($updated)) {
                $repository->setIndexedNow($updated);
            }
        }
    }

    /**
     * Delete document from index
     *
     * @param Newscoop\Search\IndexableInterface $indexable
     * @return void
     */
    public function delete(\sfEvent $event)
    {
        $indexable = $event['entity'];
        if ($indexable->getIndexed() !== null) {
            $this->client->setRawData(json_encode(array('delete' => array('id' => $indexable->getDocumentId()))), 'application/json');
            $this->client->request(\Zend_Http_Client::POST);
        }
    }

    /**
     * Get subscribed events
     *
     * @return array
     */
    public static function getSubscribedEvents()
    {
        return array(
            'article.delete' => 'delete',
            'user.delete' => 'delete',
            'comment.delete' => 'delete',
        );
    }

    /**
     * Flush changes
     *
     * @return void
     */
    private function flush()
    {
        $commands = array();

        if (!empty($this->add)) {
            $commands[] = sprintf('"add":%s', json_encode($this->add));
        }

        if (!empty($this->delete)) {
            foreach ($this->delete as $id) {
                $commands[] = sprintf('"delete":%s', json_encode(array('id' => $id)));
            }
        }

        if (empty($commands)) {
            return;
        }

        $json = '{' . implode(',', $commands) . '}';
        $this->client->setRawData($json, 'application/json');

        $response = $this->client->request(\Zend_Http_Client::POST);
        if ($response->isSuccessful()) {
            $this->add = $this->delete = array();
            return;
        }

        throw new \RuntimeException("Failed to update index.");
    }
}
