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
    private $indexers = array();

    /**
     * @var array
     */
    private $adds = array();

    /**
     * @param Zend_Http_Client $client
     * @param Doctrine\ORM\EntityManager $orm
     */
    public function __construct(\Zend_Http_Client $client, \Doctrine\ORM\EntityManager $orm)
    {
        $this->client = $client;
        $this->orm = $orm;
        $this->indexers = array_filter(func_get_args(), function($arg) {
            return $arg instanceof IndexerInterface;
        });
    }

    /**
     * Update index
     *
     * @return void
     */
    public function update()
    {
        if ($this->client === null) {
            throw new \RuntimeException("Client must be provided before update.");
        }

        foreach ($this->indexers as $indexer) {
            $indexer->update($this);
            if (!empty($this->adds)) {
                $this->client->setRawData(json_encode(array('add' => $this->adds)), 'application/json');
                $response = $this->client->request(\Zend_Http_Client::POST);
                if ($response->isSuccessful()) {
                    $indexer->commit();
                    $this->adds = array();
                } else {
                    throw new \RuntimeException("Failed to update index.");
                }
            }
        }
    }

    /**
     * Add document to index
     *
     * @param array $document
     * @return void
     */
    public function add(array $document)
    {
        $this->adds[] = $document;
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
        if ($indexable->getIndexed() !== null && !$indexable->isIndexable()) {
            $this->client->setRawData(json_encode(array('delete' => array('id' => $indexable->getDocumentId()))), 'application/json');
            $this->client->request(\Zend_Http_Client::POST);
            $indexable->setIndexed(null);
            $this->orm->flush($indexable);
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
            'article.update' => 'delete',
            'article.delete' => 'delete',
            'user.update' => 'delete',
            'user.delete' => 'delete',
            'comment.update' => 'delete',
            'comment.delete' => 'delete',
        );
    }
}
