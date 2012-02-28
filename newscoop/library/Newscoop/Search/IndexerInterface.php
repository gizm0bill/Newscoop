<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

namespace Newscoop\Search;

/**
 * Indexer interface
 */
interface IndexerInterface
{
    /**
     * Update index
     *
     * @param Newscoop\Search\Index $index
     * @return void
     */
    public function update(\Index $index);
}
