<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

namespace Newscoop\Twitter;

/**
 */
class TweetRepositoryTest extends \TestCase
{
    const TWITTER_ID = 'tw1';
    const SINCE_ID = '12345';

    public function setUp()
    {
        $this->solrClient = $this->getMockBuilder('Zend_Http_Client')
            ->disableOriginalConstructor()
            ->getMock();

        $this->twitterClient = $this->getMockBuilder('Zend_Http_Client')
            ->disableOriginalConstructor()
            ->getMock();

        $this->repository = new TweetRepository($this->twitterClient, $this->solrClient, array('id' => self::TWITTER_ID));
    }

    public function testInstance()
    {
        $this->assertInstanceOf('Newscoop\Twitter\TweetRepository', $this->repository);
        $this->assertInstanceOf('Newscoop\Search\RepositoryInterface', $this->repository);
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
                'rows' => '1',
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
                    'numFound' => 1,
                    'docs' => array(
                        array(
                            'tweet_id' => self::SINCE_ID,
                        ),
                    ),
                ),
            ))));

        $this->twitterClient->expects($this->once())
            ->method('setParameterGet')
            ->with($this->equalTo(array(
                'id' => self::TWITTER_ID,
                'since_id' => self::SINCE_ID,
            )));

        $this->twitterClient->expects($this->once())
            ->method('request')
            ->will($this->returnValue($twitterResponse));

        $twitterResponse->expects($this->once())
            ->method('isSuccessful')
            ->will($this->returnValue(true));

        $twitterResponse->expects($this->once())
            ->method('getBody')
            ->will($this->returnValue(json_encode(array(array('tweet' => '123')))));

        $this->assertEquals(array(array('tweet' => '123')), $this->repository->getBatch());
    }
}
