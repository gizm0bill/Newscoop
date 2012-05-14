<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

namespace Newscoop\Search;

/**
 */
class IndexManagerTest extends \TestCase
{
    /** @var Zend_Http_Client */
    private $client;

    /** @var Newscoop\Search\Index */
    private $index;

    public function setUp()
    {
        $this->client = $this->getMockBuilder('Zend_Http_Client')
            ->disableOriginalConstructor()
            ->getMock();

        $this->index = new Index($this->client);
    }

    public function testInstance()
    {
        $this->assertInstanceOf('Newscoop\Search\Index', $this->index);
    }

    public function testAdd()
    {
        $document = array('id' => 'article-1-1');
        $this->clientExpects(array('add' => array($document)), true);

        $this->index->add($document);
        $this->index->flush();
    }

    public function testIndexUpdateDelete()
    {
        $documentId = 'article-1-1';
        $this->clientExpects(array('delete' => array('id' => $documentId)), true);

        $this->index->delete($documentId);
        $this->index->flush();
    }

    public function testDeleteAll()
    {
        $this->clientExpects(array('delete' => array('query' => '*:*')), true);
        $this->index->deleteAll();
    }

    /**
     * Set client expectations
     *
     * @param array $data
     * @param bool $success
     * @return void
     */
    private function clientExpects($data, $success)
    {
        $this->client->expects($this->once())
            ->method('setRawData')
            ->with($this->equalTo(json_encode($data)), $this->equalTo('application/json'))
            ->will($this->returnValue($this->client));

        $response = $this->getMockBuilder('Zend_Http_Response')
            ->disableOriginalConstructor()
            ->getMock();

        $response->expects($this->once())
            ->method('isSuccessful')
            ->will($this->returnValue($success));

        $this->client->expects($this->once())
            ->method('request')
            ->with($this->equalTo(\Zend_Http_Client::POST))
            ->will($this->returnValue($response));
    }
}
