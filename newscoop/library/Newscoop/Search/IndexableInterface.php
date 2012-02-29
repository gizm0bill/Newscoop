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
     * Set indexed date
     *
     * @param DateTime $indexed
     * @return void
     */
    public function setIndexed(\DateTime $indexed);
}
