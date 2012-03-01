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

    public function setUp()
    {
        $this->client = $this->getMockBuilder('Zend_Http_Client')
            ->disableOriginalConstructor()
            ->getMock();

        $this->orm = $this->getMockBuilder('Doctrine\ORM\EntityManager')
            ->disableOriginalConstructor()
            ->getMock();

    }

    public function testInstance()
    {
        $this->assertInstanceOf('Newscoop\Search\Index', new Index($this->client, $this->orm));
    }

    public function testIndexerUpdatingIndexers()
    {
        $indexer = $this->getMockBuilder('Newscoop\Search\ArticleIndexer')
            ->disableOriginalConstructor()
            ->getMock();

        $index = new Index($this->client, $this->orm, $indexer, $indexer, $indexer);

        $indexer->expects($this->exactly(3))
            ->method('update')
            ->with($this->equalTo($index));

        $index->update();
    }

    public function testIndexerCallClient()
    {
        $this->client->expects($this->once())
            ->method('setRawData')
            ->with($this->equalTo(json_encode(array('add' => array(array('id' => 'article-1-1'),)))), $this->equalTo('application/json'))
            ->will($this->returnValue($this->client));

        $response = $this->getMockBuilder('Zend_Http_Response')
            ->disableOriginalConstructor()
            ->getMock();

        $response->expects($this->once())
            ->method('isSuccessful')
            ->will($this->returnValue(true));

        $this->client->expects($this->once())
            ->method('request')
            ->with($this->equalTo(\Zend_Http_Client::POST))
            ->will($this->returnValue($response));

        $article = $this->getMockBuilder('Newscoop\Entity\Article')
            ->disableOriginalConstructor()
            ->getMock();

        $indexer = $this->getMockBuilder('Newscoop\Search\ArticleIndexer')
            ->disableOriginalConstructor()
            ->getMock();

        $indexer->expects($this->exactly(2))
            ->method('update');

        $indexer->expects($this->once())
            ->method('commit');

        $index = new Index($this->client, $this->orm, $indexer);

        $index->add(array( // fake index method
            'id' => 'article-1-1',
        ));

        $index->update();
        $index->update();
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
            ->method('isIndexable')
            ->will($this->returnValue(false));

        $article->expects($this->once())
            ->method('getDocumentId')
            ->will($this->returnValue('article-1-1'));

        $article->expects($this->once())
            ->method('setIndexed')
            ->with($this->equalTo(null));

        $this->orm->expects($this->once())
            ->method('flush')
            ->with($this->equalTo($article));

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

        $this->orm->expects($this->never())
            ->method('flush');

        $index = new Index($this->client, $this->orm);

        $event = new \sfEvent($this, 'delete', array('entity' => $article));
        $index->delete($event);
    }
}
