<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

namespace Newscoop\Twitter;

/**
 * Search Service
 */
class SearchService implements \Newscoop\Search\ServiceInterface
{
    /**
     * Test if tweet is indexed
     *
     * @param array $tweet
     * @return bool
     */
    public function isIndexed($tweet)
    {
        return false;
    }

    /**
     * Test if tweet can be indexed
     *
     * @param array $tweet
     * @return bool
     */
    public function isIndexable($tweet)
    {
        return true;
    }

    /**
     * Get document representation for tweet
     *
     * @param array $tweet
     * @return array
     */
    public function getDocument($tweet)
    {
        return array(
            'id' => $this->getDocumentId($tweet),
            'type' => 'tweet',
            'tweet_id' => $tweet['id_str'],
            'published' => gmdate('Y-m-d\TH:i:s\Z', strtotime($tweet['created_at'])),
            'tweet' => $tweet['text'],
            'tweet_user_name' => $tweet['user']['name'],
            'tweet_user_screen_name' => $tweet['user']['screen_name'],
            'tweet_user_profile_image_url' => $tweet['user']['profile_image_url'],
        );
    }

    /**
     * Get document id
     *
     * @param array $tweet
     * @return string
     */
    public function getDocumentId($tweet)
    {
        return sprintf('tweet-%d', $tweet['id_str']);
    }
}
