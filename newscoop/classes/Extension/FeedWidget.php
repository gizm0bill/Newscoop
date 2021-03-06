<?php
/**
 * @package Campsite
 *
 * @author Petr Jasek <petr.jasek@sourcefabric.org>
 * @copyright 2010 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl.txt
 * @link http://www.sourcefabric.org
 */

/**
 * Base feed widget
 */
abstract class FeedWidget extends Widget
{
    /**
     * @var string
     * @setting
     * @label Title
     */
    protected $title = 'Feed reader';

    /**
     * @var string
     * @setting
     */
    protected $url = '';

    /**
     * @var int
     * @setting
     */
    protected $count = 5;

    /** @var int */
    protected $ttl = 900; // 15m

    /**
     * Render feeds
     * @return void
     */
    public function render()
    {
        ob_start();
        $even = false;
        $count = $this->getCount();
        foreach ($this->getItems($this->getUrl()) as $item) {
            if ($count <= 0) {
                break;
            } else {
                $count--;
            }

            echo $even ? '<li class="even">' : '<li>';
            $even = !$even;

            // add link
            printf('<a href="%s" title="%s" target="_blank">%s</a>',
                $item->link,
                $item->title,
                $item->title);

            if ($this->isFullscreen()) {
                echo '<p>', $item->description, '</p>';
            }

            echo '</li>', "\n";
        }
        $content = ob_get_clean();

        if (empty($content)) {
            echo '<p>', getGS('No news.'), '</p>';
        } else {
            echo '<ul class="rss">', "\n";
            echo $content;
            echo '</ul>', "\n";
        }
    }

    /**
     * Get feed items from specified url or cache
     * @param string $p_url
     * @return Iterator
     */
    private function getItems($p_url)
    {
        // check url
        $p_url = (string) $p_url;
        $parts = @parse_url($p_url);
        if (!$parts
            || empty($parts['scheme'])
            || !in_array($parts['scheme'], array('http', 'https'))) {
            return array();
        }

        // get url content
        $cache = $this->getCache();
        $feed = $cache->fetch($p_url);
        if (empty($feed)) {
            $feed = '';
            $headers = @get_headers($p_url);
            if (is_array($headers)
                && strpos($headers[0], '200') !== FALSE) { // OK
                $feed = file_get_contents($p_url);
            }
            $cache->add($p_url, $feed, $this->getTtl());
        }

        // parse xml
        libxml_use_internal_errors(true);
        $xml = simplexml_load_string($feed);
        if (!$xml) { // not well-formed xml
            return array();
        }

        // return items
        return empty($xml->item) ? $xml->channel->item : $xml->item;
    }
}
