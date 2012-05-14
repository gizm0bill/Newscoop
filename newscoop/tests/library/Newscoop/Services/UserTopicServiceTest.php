<?php
/**
 * @package Newscoop
 * @copyright 2011 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

namespace Newscoop\Services;

use Newscoop\Entity\User,
    Newscoop\Entity\Topic,
    Newscoop\Entity\UserTopic,
    Newscoop\Entity\Language,
    Newscoop\Entity\TopicTree;

class UserTopicServiceTest extends \RepositoryTestCase
{
    /** @var Newscoop\Services\UserTopicService */
    protected $service;

    /** @var Newscoop\Entity\User */
    protected $user;

    public function setUp()
    {
        parent::setUp('Newscoop\Entity\User', 'Newscoop\Entity\Topic', 'Newscoop\Entity\UserTopic', 'Newscoop\Entity\Acl\Role', 'Newscoop\Entity\Language', 'Newscoop\Entity\TopicTree');

        $this->service = new UserTopicService($this->em);

        $this->language = new Language();
        $this->em->persist($this->language);

        $this->user = new User('name');
        $this->em->persist($this->user);

        $this->topic = new TopicTree(1, 1);
        $this->em->persist($this->topic);

        $this->em->flush();
    }

    public function testService()
    {
        $this->assertInstanceOf('Newscoop\Services\UserTopicService', $this->service);
    }

    public function testGetTopicsEmpty()
    {
        $this->assertEmpty($this->service->getTopics($this->user));
    }

    public function testFollow()
    {
        $topic = new Topic($this->topic, $this->language, 'name');
        $this->em->persist($topic);

        $this->service->followTopic($this->user, $topic);

        $topics = $this->service->getTopics($this->user);
        $this->assertEquals(1, sizeof($topics));
        $this->assertEquals($topic, $topics[0]);
    }

    public function testUpdateTopics()
    {
        $tt2 = new TopicTree(2, 3);
        $tt3 = new TopicTree(3, 5);
        $this->em->persist($tt2);
        $this->em->persist($tt3);
        $this->em->flush();

        $this->em->persist($topic = new Topic($this->topic, $this->language, '1'));
        $this->em->persist(new Topic($tt2, $this->language, '2'));
        $this->em->persist(new Topic($tt3, $this->language, '3'));
        $this->em->flush();

        $this->service->followTopic($this->user, $topic);

        $this->service->updateTopics($this->user, array(
            '1' => 'false',
            '2' => 'false',
            '3' => 'true',
        ));

        $topics = $this->service->getTopics($this->user);
        $this->assertEquals(1, count($topics));
        $this->assertEquals('3', current($topics)->getName());
    }

    public function testUpdateTopicsIfDeleted()
    {
        $topic = new Topic($this->topic, $this->language, 'deleted');
        $this->em->persist($topic);
        $this->em->flush($topic);

        $this->service->followTopic($this->user, $topic);

        $tt2 = new TopicTree(2, 3);
        $this->em->persist($tt2);
        $this->em->flush($tt2);

        $this->em->remove($topic);

        $this->em->persist(new Topic($tt2, $this->language, 'next'));
        $this->em->flush();
        $this->em->clear();

        $this->service->updateTopics($this->user, array(
            2 => "false",
        ));

        $topics = $this->service->getTopics($this->user);
        $this->assertEquals(0, count($topics));
    }

    public function testGetTopicsDeleted()
    {
        $topic = new Topic($this->topic, $this->language, 'test');
        $this->em->persist($topic);
        $this->em->flush($topic);

        $this->service->followTopic($this->user, $topic);

        $this->em->remove($topic);
        $this->em->flush();
        $this->em->clear();

        $this->assertEquals(0, count($this->service->getTopics($this->user)));
    }
}
