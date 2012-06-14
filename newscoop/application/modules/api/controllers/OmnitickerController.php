<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

require_once __DIR__ . '/../../../controllers/OmnitickerController.php';

/**
 */
class Api_OmnitickerController extends OmnitickerController
{
    const ROWS = 200;
    const ROWS_CURRENT = 30;

    const TYPE_ARTICLE = 'article';
    const TYPE_TWITTER = 'tweet';
    const TYPE_NEWSWIRE = 'newswire';
    const TYPE_LINK = 'link';

    const EN_SECTION_ID = 90;
    const EN_SECTION_NAME = 'Swissinfo';
    const EN_SECTION_TYPE = 'english_news';

    /** @var array */
    private $literalTypes = array(self::TYPE_TWITTER, self::TYPE_LINK, self::TYPE_NEWSWIRE);

    public function indexAction()
    {
        parent::indexAction();
        $this->getResponse()->setHeader('Expires', $this->getExpires(), true);
        $this->getResponse()->setHeader('Cache-Control', 'public', true);
        $this->getResponse()->setHeader('Pragma', '', true);
        $this->_helper->json(array_map(array($this, 'formatDoc'), (array) $this->view->result['response']['docs']));
    }

    /**
     * Format document for api
     *
     * @param array $doc
     * @return array
     */
    private function formatDoc(array $doc)
    {
        $published = new DateTime($doc['published']);
        $published->setTimezone(new DateTimeZone('Europe/Zurich'));
        return array(
            'article_id' => $doc['id'],
            'url' => $this->formatLink($doc),
            'short_title' => $this->formatTitle($doc),
            'last_modified' => date_create($doc['published'])->format('Y-m-d H:i:s'),
            'section_id' => !empty($doc['section_id']) ? $doc['section_id'] : null,
            'section_name' => !empty($doc['section_name']) ? $doc['section_name'] : null,
            'source' => $this->formatType($doc),
            'published' => $published->format('Y-m-d H:i:s'),
        );
    }

    /**
     * Format document title
     *
     * @param array $doc
     * @return string
    */
    private function formatTitle(array $doc)
    {
        switch ($doc['type']) {
            case self::TYPE_TWITTER:
                return sprintf('%s: %s', $doc['tweet_user_screen_name'], $doc['tweet']);

            case self::TYPE_LINK:
                return sprintf('%s %s', $doc['link_description'], $doc['title']);
        }
        
        return !empty($doc['title']) ? $doc['title'] : '';
    }

    /**
     * Format document type
     *
     * @param array $doc
     * @return string
     */
    private function formatType(array $doc)
    {
        if ($this->isEnglishNews($doc)) {
            return self::EN_SECTION_TYPE;
        } else if (in_array($doc['type'], $this->literalTypes)) {
            return $doc['type'];
        }

        return self::TYPE_ARTICLE;
    }

    /**
     * Test if is english news
     *
     * @param array $doc
     * @return bool
     */
    private function isEnglishNews(array $doc)
    {
        return (!empty($doc['section_id']) && $doc['section_id'] == self::EN_SECTION_ID)
            || (!empty($doc['section_name']) && $doc['section_name'] === self::EN_SECTION_NAME);
    }

    /**
     * Format document link
     *
     * @param array $doc
     * @return string
     */
    private function formatLink(array $doc)
    {
        foreach(array('link_url', 'link') as $link) {
            if (!empty($doc[$link])) {
                return $doc[$link];
            }
        }

        return null;
    }

    /**
     * Build date range query
     *
     * @return string
     */
    protected function buildSolrDateParam()
    {
        if (!$this->_getParam('start_date')) {
            return;
        }

        try {
            $startDate = new DateTime($this->_getParam('start_date'));
        } catch (Exception $e) {
            $this->sendError($e->getMessage());
        }

        $endDate = $startDate;
        if ($this->_getParam('end_date')) {
            try {
                $endDate = new DateTime($this->_getParam('end_date'));
            } catch (Exception $e) {
                $this->sendError($e->getMessage());
            }
        }

        return sprintf('published:[%s/DAY TO %s+1DAY/DAY]', // it's <,) interval thus +1 day
            $startDate->format('Y-m-d\TH:i:s\Z'),
            $endDate->format('Y-m-d\TH:i:s\Z'));
    }

    /**
     * Build solr params
     *
     * @return array
     */
    protected function buildSolrParams()
    {
        $params = parent::buildSolrParams();
        $params['rows'] = $this->_getParam('start_date') ? self::ROWS_CURRENT : self::ROWS;
        return $params;
    }

    /**
     * Send error and exit
     *
     * @param string $body
     * @param int $code
     * @return void
     */
    private function sendError($body = '', $code = 400)
    {
        $this->getResponse()->setHttpResponseCode($code);
        $this->_helper->json(array(
            'code' => $code,
            'message' => $body,
        ));
    }

    /**
     * Get expires string
     *
     * @return string
     */
    private function getExpires()
    {
        $now = new DateTime();
        $start = new DateTime($this->_getParam('start_date') ?: 'now');
        $expires = new DateInterval($start->format('Y-m-d') === $now->format('Y-m-d') || $start->getTimestamp() > $now->getTimestamp() ? 'PT5M' : 'P300D');
        return $now->add($expires)->format(DateTime::RFC1123);
    }
}
