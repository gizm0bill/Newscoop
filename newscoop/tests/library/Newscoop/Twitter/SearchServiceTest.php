<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

namespace Newscoop\Twitter;

/**
 */
class SearchServiceTest extends \TestCase
{
    public function setUp()
    {
        $this->service = new SearchService();
        $this->tweet = json_decode(file_get_contents(__DIR__ . '/tweet.json'), true);
    }

    public function testInstance()
    {
        $this->assertInstanceOf('Newscoop\Twitter\SearchService', $this->service);
        $this->assertInstanceOf('Newscoop\Search\ServiceInterface', $this->service);
    }

    public function testGetDocumentId()
    {
        $this->assertEquals('tweet-28547150983987200', $this->service->getDocumentId($this->tweet));
    }

    public function testGetDocument()
    {
        $this->assertEquals(array(
            'id' => 'tweet-28547150983987200',
            'type' => 'tweet',
            'tweet_id' => '28547150983987200',
            'published' => '2011-01-21T20:19:05Z',
            'tweet' => "Today is Health & Hack Day @LinkedIn. Failed my health goal of bike to work for the first time. Will I play with git & github? Stay tuned.",
            'tweet_user_name' => "Adam Trachtenberg",
            'tweet_user_screen_name' => "atrachtenberg",
            'tweet_user_profile_image_url' => "http://a1.twimg.com/profile_images/625094660/adam-72x101_normal.jpeg",
        ), $this->service->getDocument($this->tweet));
    }

    public function testIsIndexed()
    {
        $this->assertFalse($this->service->isIndexed($this->tweet));
    }

    public function testIsIndexable()
    {
        $this->assertTrue($this->service->isIndexable($this->tweet));
    }
}
