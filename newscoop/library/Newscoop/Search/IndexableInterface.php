<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

namespace Newscoop\Search;

/**
 * Indexable interface
 */
interface IndexableInterface
{
    /**
     * Get document id
     *
     * @return string
     */
    public function getDocumentId();

    /**
     * Set indexed date
     *
     * @param DateTime $indexed
     * @return void
     */
    public function setIndexed(\DateTime $indexed = null);

    /**
     * Get indexed
     *
     * @return DateTime
     */
    public function getIndexed();

    /**
     * Test if item can be indexed
     *
     * @return bool
     */
    public function isIndexable();
}
