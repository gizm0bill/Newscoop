<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

namespace Newscoop\Twitter;

/**
 * Tweet Repository
 */
class TweetRepository implements \Newscoop\Search\RepositoryInterface
{
    /**
     * @var Zend_Http_Client
     */
    protected $twitterClient;

    /**
     * @var Zend_Http_Client
     */
    protected $solrClient;

    /**
     * @var array
     */
    protected $config = array(
    );

    /**
     * @var Zend_Http_Client $twitterClient
     * @var Zend_Http_Client $solrClient
     * @var array $config
     */
    public function __construct(\Zend_Http_Client $twitterClient, \Zend_Http_Client $solrClient, array $config)
    {
        $this->twitterClient = $twitterClient;
        $this->solrClient = $solrClient;
        $this->config = $config;
    }

    /**
     * Get tweets to be indexed
     *
     * @return array
     */
    public function getBatch()
    {
        $this->twitterClient->setParameterGet(array_filter(array(
            'id' => $this->config['id'],
            'since_id' => $this->getLastId(),
        )));

        $response = $this->twitterClient->request();
        if (!$response->isSuccessful()) {
            return array();
        }

        return json_decode($response->getBody(), true);
    }

    /**
     * Get last indexed tweet id
     *
     * @return string
     */
    private function getLastId()
    {
        $this->solrClient->setParameterGet(array(
            'wt' => 'json',
            'q' => '*:*',
            'fq' => 'type:tweet',
            'fl' => 'tweet_id',
            'sort' => 'published desc',
            'rows' => '1',
        ));

        $response = $this->solrClient->request();
        if (!$response->isSuccessful()) {
            return;
        }

        $responseArray = json_decode($response->getBody(), true);
        return $responseArray['response']['numFound'] > 0 ? $responseArray['response']['docs'][0]['tweet_id'] : null;
    }

    /**
     * Set indexed now
     *
     * nop for twitter 
     *
     * @param array $tweets
     * @return void
     */
    public function setIndexedNow(array $tweets)
    {
        return;
    }

    /**
     * Set indexed null
     *
     * nop for twitter
     *
     * @return void
     */
    public function setIndexedNull()
    {
        return;
    }
}
