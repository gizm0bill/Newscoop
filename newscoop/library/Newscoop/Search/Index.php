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
     * @var array
     */
    private $indexers = array();

    /**
     * @var array
     */
    private $adds = array();

    /**
     */
    public function __construct()
    {
        $this->client = array_pop(array_filter(func_get_args(), function($arg) {
            return $arg instanceof \Zend_Http_Client;
        }));

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
        }

        $this->client->setRawData(json_encode(array('add' => $this->adds)), 'application/json');
        $response = $this->client->request(\Zend_Http_Client::POST);
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
}
