<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

namespace Newscoop\Search;

/**
 */
class IndexerTemplateTest extends \TestCase
{
    public function setUp()
    {
        $this->index = $this->getMockBuilder('Newscoop\Search\Index')
            ->disableOriginalConstructor()
            ->getMock();

        $this->serviceInterface = $this->getMock('Newscoop\Search\ServiceInterface');
        $this->repositoryInterface = $this->getMock('Newscoop\Search\RepositoryInterface');
        $this->indexer = new Indexer($this->index, $this->serviceInterface, $this->repositoryInterface);
    }

    public function testUpdateAdd()
    {
        $document = array('id' => 'article-1-1');
        $entity = "Entity";

        $this->repositoryInterface->expects($this->once())
            ->method('getBatch')
            ->will($this->returnValue(array($entity)));

        $this->serviceInterface->expects($this->once())
            ->method('isIndexable')
            ->with($this->equalTo($entity))
            ->will($this->returnValue(true));

        $this->serviceInterface->expects($this->once())
            ->method('getDocument')
            ->with($this->equalTo($entity))
            ->will($this->returnValue($document));

        $this->index->expects($this->once())
            ->method('add')
            ->with($this->equalTo($document));

        $this->index->expects($this->once())
            ->method('flush');

        $this->repositoryInterface->expects($this->once())
            ->method('setIndexedNow')
            ->with($this->equalTo(array($entity)));

        $this->indexer->update();
    }

    public function testUpdateDelete()
    {
        $documentId = 'doc-1-2';
        $entity = "Entity";

        $this->repositoryInterface->expects($this->once())
            ->method('getBatch')
            ->will($this->returnValue(array($entity)));

        $this->serviceInterface->expects($this->once())
            ->method('isIndexable')
            ->will($this->returnValue(false));

        $this->serviceInterface->expects($this->once())
            ->method('isIndexed')
            ->will($this->returnValue(true));

        $this->serviceInterface->expects($this->once())
            ->method('getDocumentId')
            ->with($this->equalTo($entity))
            ->will($this->returnValue($documentId));

        $this->index->expects($this->once())
            ->method('delete')
            ->with($this->equalTo($documentId));

        $this->index->expects($this->once())
            ->method('flush');

        $this->indexer->update();
    }

    public function testDelete()
    {
        $documentId = 'a-123';
        $entity = "Entity";

        $event = new \sfEvent($this, "entity.delete", array(
            'id' => '123',
            'diff' => null,
            'title' => null,
            'entity' => $entity,
        ));

        $this->serviceInterface->expects($this->once())
            ->method('isIndexed')
            ->will($this->returnValue(true));

        $this->serviceInterface->expects($this->once())
            ->method('getDocumentId')
            ->with($this->equalTo($entity))
            ->will($this->returnValue($documentId));

        $this->index->expects($this->once())
            ->method('delete')
            ->with($this->equalTo($documentId));

        $this->index->expects($this->once())
            ->method('flush');

        $this->indexer->delete($event);
    }

    public function testDeleteAll()
    {
        $this->index->expects($this->once())
            ->method('deleteAll');

        $this->repositoryInterface->expects($this->once())
            ->method('setIndexedNull');

        $this->indexer->deleteAll();
    }
}
