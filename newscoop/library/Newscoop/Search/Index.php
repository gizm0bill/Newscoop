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
    const APPLICATION_JSON = 'application/json';

    /**
     * @var array
     */
    private $config = array();

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
     * @param array $config
     * @param Zend_Http_Client $client
     * @param Doctrine\ORM\EntityManager $orm
     */
    public function __construct(array $config, \Zend_Http_Client $client, \Doctrine\ORM\EntityManager $orm)
    {
        $this->config = array_merge($this->config, $config);
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
                if ($indexable->isIndexable($this->config)) {
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
            $this->client->setRawData(json_encode(array('delete' => array('id' => $indexable->getDocumentId()))), self::APPLICATION_JSON);
            $this->client->request(\Zend_Http_Client::POST);
        }
    }

    /**
     * Rebuild index
     *
     * @return void
     */
    public function rebuild()
    {
        $this->client->setRawData(json_encode(array('delete' => array('query' => '*:*'))), self::APPLICATION_JSON);
        $response = $this->client->request(\Zend_Http_Client::POST);
        if ($response->isSuccessful()) {
            foreach ($this->repositories as $repository) {
                $repository->setIndexedNull();
            }
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
        $commands = array_merge($this->buildAddCommands(), $this->buildDeleteCommands());
        if (empty($commands)) {
            return;
        }

        $jsonData = '{' . implode(',', $commands) . '}';
        $this->client->setRawData($jsonData, self::APPLICATION_JSON);

        $response = $this->client->request(\Zend_Http_Client::POST);
        if ($response->isSuccessful()) {
            $this->add = $this->delete = array();
            return;
        }

        throw new \RuntimeException("Failed to update index.");
    }

    /**
     * Build add commands
     *
     * @return array
     */
    private function buildAddCommands()
    {
        return empty($this->add) ? array() : array(sprintf('"add":%s', json_encode($this->add)));
    }

    /**
     * Build delete commands
     *
     * @return array
     */
    private function buildDeleteCommands()
    {
        $commands = array();
        foreach ($this->delete as $id) {
            $commands[] = sprintf('"delete":%s', json_encode(array('id' => $id)));
        }

        return $commands;
    }
}
