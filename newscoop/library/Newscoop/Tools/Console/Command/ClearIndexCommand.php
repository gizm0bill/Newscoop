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
 * Index clear command
 */
class ClearIndexCommand extends AbstractIndexCommand
{
    /**
     * @see Console\Command\Command
     */
    protected function configure()
    {
        $this
        ->setName('index:clear')
        ->setDescription('Clear Search Index.')
        ->setHelp("");
    }

    /**
     * @see Console\Command\Command
     */
    protected function execute(Console\Input\InputInterface $input, Console\Output\OutputInterface $output)
    {
        foreach ($this->getIndexers() as $indexer) {
            $indexer->deleteAll();
        }

        $output->writeln('Search Index cleared.');
    }
}
