<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

namespace Newscoop\Search;

/**
 */
abstract class IndexerTestTemplate extends \TestCase
{
    /** @var Newscoop\Search\IndexerInterface */
    protected $indexer;

    /** @var Newscoop\Search\Index */
    protected $index;

    /** @var Doctrine\ORM\EntityManager */
    protected $orm;

    public function setUp()
    {
        $this->index = $this->getMockBuilder('Newscoop\Search\Index')
            ->disableOriginalConstructor()
            ->getMock();
    }

    public function tearDown()
    {
        $this->tearDownOrm($this->orm);
    }

    public function testEmpty()
    {
        $this->updateExpectNoAdd();
    }

    /**
     * Update indexer expecting no adds to index
     *
     * @return void
     */
    public function updateExpectNoAdd()
    {
        $this->index->expects($this->never())
            ->method('add');

        $this->indexer->update($this->index);
    }
}
