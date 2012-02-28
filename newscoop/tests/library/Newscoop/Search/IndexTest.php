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
    public function testInstance()
    {
        $this->assertInstanceOf('Newscoop\Search\Index', new Index());
    }

    public function testIndexerUpdatingIndexers()
    {
        $indexer = $this->getMockBuilder('Newscoop\Search\ArticleIndexer')
            ->disableOriginalConstructor()
            ->getMock();

        $client = $this->getMockBuilder('Zend_Http_Client')
            ->disableOriginalConstructor()
            ->getMock();

        $index = new Index($client, $indexer, $indexer, $indexer);

        $indexer->expects($this->exactly(3))
            ->method('update')
            ->with($this->equalTo($index));

        $index->update();
    }

    public function testIndexerCallClient()
    {
        $client = $this->getMockBuilder('Zend_Http_Client')
            ->disableOriginalConstructor()
            ->getMock();

        $client->expects($this->once())
            ->method('setRawData')
            ->with($this->equalTo(json_encode(array('add' => array(array('id' => 'article-1-1'),)))), $this->equalTo('application/json'))
            ->will($this->returnValue($client));

        $client->expects($this->once())
            ->method('request')
            ->with($this->equalTo(\Zend_Http_Client::POST));

        $index = new Index($client);

        $index->add(array(
            'id' => 'article-1-1',
        ));

        $index->update();
    }
}
