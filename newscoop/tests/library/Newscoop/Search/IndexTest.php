<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

namespace Newscoop\Search;

/**
 */
class IndexTest extends \TestCase
{
    /** @var Zend_Http_Client */
    private $client;

    /** @var Doctrine\ORM\EntityManager */
    private $orm;

    /** @var Newscoop\Search\Client */
    private $index;

    public function setUp()
    {
        $this->client = $this->getMockBuilder('Zend_Http_Client')
            ->disableOriginalConstructor()
            ->getMock();

        $this->orm = $this->getMockBuilder('Doctrine\ORM\EntityManager')
            ->disableOriginalConstructor()
            ->getMock();

        $this->index = new Index($this->client, $this->orm);
    }

    public function testInstance()
    {
        $this->assertInstanceOf('Newscoop\Search\Index', $this->index);
    }

    public function testIndexUpdateAdd()
    {
        $repository = $this->getMock('Newscoop\Search\IndexableRepositoryInterface');
        $indexable = $this->getMock('Newscoop\Search\IndexableInterface');

        $repository->expects($this->once())
            ->method('findIndexable')
            ->will($this->returnValue(array($indexable)));

        $indexable->expects($this->once())
            ->method('getDocument')
            ->will($this->returnValue(array(
                'id' => 'article-1-1',
            )));

        $indexable->expects($this->once())
            ->method('isIndexable')
            ->will($this->returnValue(true));

        $this->clientExpects(array('add' => array(array('id' => 'article-1-1'),)), true);

        $repository->expects($this->once())
            ->method('setIndexedNow')
            ->with($this->equalTo(array($indexable)));

        $this->index->addRepository($repository);
        $this->index->update();
    }

    public function testIndexUpdateDelete()
    {
        $repository = $this->getMock('Newscoop\Search\IndexableRepositoryInterface');
        $indexable = $this->getMock('Newscoop\Search\IndexableInterface');

        $repository->expects($this->once())
            ->method('findIndexable')
            ->will($this->returnValue(array($indexable)));

        $indexable->expects($this->once())
            ->method('isIndexable')
            ->will($this->returnValue(false));

        $indexable->expects($this->once())
            ->method('getIndexed')
            ->will($this->returnValue(new \DateTime()));

        $indexable->expects($this->once())
            ->method('getDocumentId')
            ->will($this->returnValue('article-1-1'));

        $indexable->expects($this->never())
            ->method('getDocument');

        $this->clientExpects(array('delete' => array('id' => 'article-1-1')), true);

        $repository->expects($this->once())
            ->method('setIndexedNow')
            ->with($this->equalTo(array($indexable)));

        $this->index->addRepository($repository);
        $this->index->update();
    }

    public function testDelete()
    {
        $this->client->expects($this->once())
            ->method('setRawData')
            ->with($this->equalTo(json_encode(array('delete' => array('id' => 'article-1-1')))), $this->equalTo('application/json'))
            ->will($this->returnValue($this->client));

        $this->client->expects($this->once())
            ->method('request')
            ->with($this->equalTo(\Zend_Http_Client::POST));

        $index = new Index($this->client, $this->orm);

        $article = $this->getMockBuilder('Newscoop\Entity\Article')
            ->disableOriginalConstructor()
            ->getMock();

        $article->expects($this->once())
            ->method('getIndexed')
            ->will($this->returnValue(new \DateTime()));

        $article->expects($this->once())
            ->method('getDocumentId')
            ->will($this->returnValue('article-1-1'));

        $event = new \sfEvent($this, 'delete', array('entity' => $article));
        $index->delete($event);
    }

    public function testDeleteNotIndexed()
    {
        $article = $this->getMockBuilder('Newscoop\Entity\Article')
            ->disableOriginalConstructor()
            ->getMock();

        $this->client->expects($this->never())
            ->method('setRawData');

        $article->expects($this->once())
            ->method('getIndexed')
            ->will($this->returnValue(null));

        $index = new Index($this->client, $this->orm);

        $event = new \sfEvent($this, 'delete', array('entity' => $article));
        $index->delete($event);
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
