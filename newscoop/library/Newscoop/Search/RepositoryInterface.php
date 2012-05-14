<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

namespace Newscoop\Search;

/**
 * Repository interface
 */
interface RepositoryInterface
{
    /**
     * Get items to process
     *
     * @return array
     */
    public function getBatch();

    /**
     * Set indexed to now for given items
     *
     * @param array $items
     * @return void
     */
    public function setIndexedNow(array $items);

    /**
     * Set indexed to null for all items
     *
     * @return void
     */
    public function setIndexedNull();
}
