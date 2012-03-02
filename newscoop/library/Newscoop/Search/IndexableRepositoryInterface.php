<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

namespace Newscoop\Search;

/**
 * Indexable Repository interface
 */
interface IndexableRepositoryInterface
{
    /**
     * Find indexable entities
     *
     * @return array
     */
    public function findIndexable();

    /**
     * Set indexed property for entities
     *
     * @param array $entities
     * @return void
     */
    public function setIndexedNow(array $entities);
}
