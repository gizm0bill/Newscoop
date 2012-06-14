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
    const TWITTER_ID = 'tw1';

    public function setUp()
    {
        $this->solrClient = $this->getMockBuilder('Zend_Http_Client')
            ->disableOriginalConstructor()
            ->getMock();

        $this->twitterClient = $this->getMockBuilder('Zend_Http_Client')
            ->disableOriginalConstructor()
            ->getMock();

        $this->service = new SearchService($this->twitterClient, $this->solrClient, array('id' => self::TWITTER_ID));

        $this->tweet = json_decode(file_get_contents(__DIR__ . '/tweet.json'), true);
    }

    public function testInstance()
    {
        $this->assertInstanceOf('Newscoop\Twitter\SearchService', $this->service);
        $this->assertInstanceOf('Newscoop\Search\ServiceInterface', $this->service);
        $this->assertInstanceOf('Newscoop\Search\RepositoryInterface', $this->service);
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

    public function testGetBatch()
    {
        $solrResponse = $this->getMockBuilder('Zend_Http_Response')
            ->disableOriginalConstructor()
            ->getMock();

        $twitterResponse = $this->getMockBuilder('Zend_Http_Response')
            ->disableOriginalConstructor()
            ->getMock();

        $this->solrClient->expects($this->once())
            ->method('setParameterGet')
            ->with($this->equalTo(array(
                'wt' => 'json',
                'q' => '*:*',
                'fq' => 'type:tweet',
                'fl' => 'tweet_id',
                'sort' => 'published desc',
                'rows' => '20',
            )))->will($this->returnValue($this->solrClient));

        $this->solrClient->expects($this->once())
            ->method('request')
            ->will($this->returnValue($solrResponse));

        $solrResponse->expects($this->once())
            ->method('isSuccessful')
            ->will($this->returnValue(true));

        $solrResponse->expects($this->once())
            ->method('getBody')
            ->will($this->returnValue(json_encode(array(
                'response' => array(
                    'numFound' => 2,
                    'docs' => array(
                        array(
                            'tweet_id' => '2',
                        ),
                        array(
                            'tweet_id' => '1',
                        ),
                    ),
                ),
            ))));

        $this->twitterClient->expects($this->once())
            ->method('setParameterGet')
            ->with($this->equalTo(array(
                'id' => self::TWITTER_ID,
                'since_id' => '1',
            )));

        $this->twitterClient->expects($this->once())
            ->method('request')
            ->will($this->returnValue($twitterResponse));

        $twitterResponse->expects($this->once())
            ->method('isSuccessful')
            ->will($this->returnValue(true));

        $twitterResponse->expects($this->once())
            ->method('getBody')
            ->will($this->returnValue(json_encode(array(
                array('id_str' => '3'),
                array('id_str' => '2'),
            ))));

        $tweets = $this->service->getBatch();
        $this->assertEquals(array(
            array('id_str' => '3'),
            array('id_str' => '2'),
        ), $tweets);

        $this->assertTrue($this->service->isIndexable($tweets[0]));
        $this->assertTrue($this->service->isIndexable($tweets[1]));

        $this->assertFalse($this->service->isIndexed($tweets[0]));
        $this->assertFalse($this->service->isIndexed($tweets[1]));
    }
}
