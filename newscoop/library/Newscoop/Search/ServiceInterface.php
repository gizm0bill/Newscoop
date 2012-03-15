<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

namespace Newscoop\Search;

/**
 * Service Interface
 */
interface ServiceInterface
{
    /**
     * Test if item is indexed
     *
     * @param mixed $item
     * @return bool
     */
    public function isIndexed($item);

    /**
     * Test if item can be indexed
     *
     * @param mixed $item
     * @return bool
     */
    public function isIndexable($item);

    /**
     * Get document for item
     *
     * @param mixed $item
     * @return array
     */
    public function getDocument($item);

    /**
     * Get document id
     *
     * @param mixed $item
     * @return string
     */
    public function getDocumentId($item);
}
