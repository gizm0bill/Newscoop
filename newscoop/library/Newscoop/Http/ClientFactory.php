<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

namespace Newscoop\Http;

use Guzzle\Http\Client;

/**
 */
class ClientFactory
{
    /**
     * Get client
     *
     * @return Guzzle\Http\Client
     */
    public function getClient()
    {
        return new Client();
    }
}
