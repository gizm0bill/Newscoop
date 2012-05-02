<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

namespace Newscoop\Article;

/**
 * Link Service
 */
class LinkService
{
    /** @var array */
    static $urlMap = array(
        'ä' => 'ae',
        'Ä' => 'ae',
        'á' => 'a',
        'à' => 'a',
        'â' => 'a',
        'æ' => 'a',
        'é' => 'e',
        'é' => 'e',
        'è' => 'e',
        'è' => 'e',
        'ü' => 'ue',
        'Ü' => 'ue',
        'ö' => 'oe',
        'Ö' => 'oe',
        'ß' => 'ss',
        'ç' => 'c',
        'ê' => 'e',
        'ê' => 'e',
        'ì' => 'i',
        'ì' => 'i',
        'í' => 'i',
        'í' => 'i',
        'ô' => 'o',
        'ô' => 'o',
        'œ' => 'o',
        'ò' => 'o',
        'ò' => 'o',
        'ó' => 'o',
        'ó' => 'o',
        'ù' => 'u',
        'ù' => 'u',
        'û' => 'u',
        'û' => 'u',
        'ú' => 'u',
        'ú' => 'u',
        'ÿ' => 'y',
        'Ÿ' => 'y',
    );

    /**
     * @var Doctrine\ORM\EntityManager
     */
    private $em;

    /**
     * @param Doctrine\ORM\EntityManager $em
     */
    public function __construct(\Doctrine\ORM\EntityManager $em)
    {
        $this->em = $em;
    }

    /**
     * Get link
     *
     * @param Newscoop\Entity\Article $article
     * @return string
     */
    public function getLink(\Newscoop\Entity\Article $article)
    {
        $link = implode('/', array(
            trim($article->getPublication()->getAliasName(), '/'),
            $article->getLanguage()->getCode(),
            $this->getIssueShortName($article),
            $this->getSectionShortName($article),
            $article->getNumber(),
            $this->getSeo($article, $article->getPublication()->getSeo()),
        ));

        return strpos($link, 'http') === 0 ? $link : 'http://' . $link;
    }

    /**
     * Get issue short name
     *
     * @param Newscoop\Entity\Article $article
     * @return string
     */
    public function getIssueShortName(\Newscoop\Entity\Article $article)
    {
        $issue = $this->em->getRepository('Newscoop\Entity\Issue')->findOneBy(array(
            'number' => $article->getIssueNumber(),
            'publication' => $article->getPublicationId(),
            'language' => $article->getLanguageId(),
        ));

        return $issue ? $issue->getShortName() : null;
    }

    /**
     * Get section short name
     *
     * @param Newscoop\Entity\Article $article
     * @return string
     */
    public function getSectionShortName(\Newscoop\Entity\Article $article)
    {
        $section = $this->em->getRepository('Newscoop\Entity\Section')->findOneBy(array(
            'number' => $article->getSectionNumber(),
            'publication' => $article->getPublicationId(),
            'language' => $article->getLanguageId(),
            'issueNumber' => $article->getIssueNumber(),
        ));

        return $section ? $section->getShortName() : null;
    }

    /**
     * Get seo string
     *
     * @param object $article
     * @param array $fields
     * @return string
     */
    public function getSeo($article, array $fields)
    {
        $seo = array();
        foreach ($fields as $field => $value) {
            switch ($field) {
                case 'name':
                    $seo[] = trim($article->getName());
                    break;

                case 'keywords':
                    $seo[] = trim($this->getKeywords());
                    break;

                case 'topics':
                    $topics = \ArticleTopic::GetArticleTopics($article->getNumber());
                    foreach ($articleTopics as $topic) {
                        $seo[] = trim($topic->getName($article->getLanguageId()));
                    }
                    break;
            }
        }

        $seo = trim(implode('-', array_filter($seo)), '-');
        $seo = preg_replace('/[\\\\,\/\.\?"\+&%:#]/', '', $seo);
        $seo = str_replace(' ', '-', $seo) . '.htm';
        return $this->encode($seo);
    }

    /**
     * Encode url
     *
     * @param string $url
     * @return string
     */
    private function encode($url)
    {
        list($url,) = explode('.', $url, 2);
        $url = strtolower($url);
        $url = str_replace(array_keys(self::$urlMap), array_values(self::$urlMap), $url);
        $url = preg_replace('#[^-a-z0-9.]#', '-', $url);
        $url = preg_replace('#[-]{2,}#', '-', $url);
        return trim($url, '-') . '.htm';
    }
}
