<?php
/**
 * @package Newscoop
 * @copyright 2011 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

namespace Newscoop\Entity;

/**
 */
class UserTopicTest extends \RepositoryTestCase
{
    /** @var Doctrine\ORM\EntityRepository */
    protected $repository;

    public function setUp()
    {
        parent::setUp('Newscoop\Entity\User', 'Newscoop\Entity\UserTopic', 'Newscoop\Entity\Topic', 'Newscoop\Entity\Acl\Role', 'Newscoop\Entity\TopicTree', 'Newscoop\Entity\Language');
        $this->repository = $this->em->getRepository('Newscoop\Entity\UserTopic');
    }

    public function testUserToken()
    {
        $user = new User('uname');
        $topic = new Topic(new TopicTree(1, 1), new Language(), 'name');
        $userTopic = new UserTopic($user, $topic);
        $this->assertInstanceOf('Newscoop\Entity\UserTopic', $userTopic);
    }

    /**
     * @expects Exception
     */
    public function testSave()
    {
        $language = new Language();
        $tt = new TopicTree(1, 1);
        $this->em->persist($language);
        $this->em->persist($tt);
        $this->em->flush();

        $user = new User('uname');
        $topic = new Topic($tt, $language, 'name');
        $this->em->persist($user);
        $this->em->persist($topic);
        $this->em->flush();

        $userTopic = new UserTopic($user, $topic);
        $this->em->persist($userTopic);
        $this->em->flush();
        $this->em->clear();

        $userTopics = $this->repository->findBy(array(
            'user' => $user->getId(),
        ));

        $this->assertEquals(1, sizeof($userTopics));
        $this->assertEquals($topic->getName(), $userTopics[0]->getTopic()->getName());
    }
}
