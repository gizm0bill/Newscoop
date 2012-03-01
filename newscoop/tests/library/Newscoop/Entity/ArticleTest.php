<?php
/**
 * @package Newscoop
 * @copyright 2011 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

namespace Newscoop\Entity;

/**
 */
class ArticleTest extends \PHPUnit_Framework_TestCase
{
    public function testIsIndexable()
    {
        $article = new Article(1, new Language());
        $this->assertFalse($article->isIndexable());

        $article->setPublished(new \DateTime());
        $this->assertTrue($article->isIndexable());
    }
}
