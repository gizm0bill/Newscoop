<?php
/**
 * @package Newscoop
 * @copyright 2011 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

namespace Newscoop\Tools\Console\Command;

use Symfony\Component\Console\Input\InputArgument,
    Symfony\Component\Console\Input\InputOption,
    Symfony\Component\Console;

/**
 * Base Index Command
 */
abstract class AbstractIndexCommand extends Console\Command\Command
{
    /**
     * Get all indexers
     *
     * @return array
     */
    protected function getIndexers()
    {
        return array(
            $this->getHelper('container')->getService('search_indexer_article'),
            $this->getHelper('container')->getService('search_indexer_comment'),
            $this->getHelper('container')->getService('search_indexer_user'),
            $this->getHelper('container')->getService('search_indexer_twitter'),
        );
    }
}
