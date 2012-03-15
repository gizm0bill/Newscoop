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
     * @var Zend_Http_Client
     */
    private $client;

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
     */
    public function __construct(\Zend_Http_Client $client)
    {
        $this->client = $client;
    }

    /**
     * Add document
     *
     * @param array $doc
     * @return void
     */
    public function add(array $doc)
    {
        $this->add[] = $doc;
    }

    /**
     * Delete document from index
     *
     * @param string $documentId
     * @return void
     */
    public function delete($documentId)
    {
        $this->delete[] = $documentId;
    }

    /**
     * Delete all docs
     *
     * @return void
     */
    public function deleteAll()
    {
        $this->client->setRawData(json_encode(array('delete' => array('query' => '*:*'))), self::APPLICATION_JSON);
        $response = $this->client->request(\Zend_Http_Client::POST);
        if (!$response->isSuccessful()) {
            $this->throwException($response);
        }
    }

    /**
     * Flush changes
     *
     * @return void
     */
    public function flush()
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

        $this->throwException($response);
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

    /**
     * Throw exception by given response
     *
     * @param Zend_Http_Response $response
     * @return void
     */
    private function throwException(\Zend_Http_Response $response)
    {
        throw new \RuntimeException($response->getMessage(), $response->getStatus());
    }
}
