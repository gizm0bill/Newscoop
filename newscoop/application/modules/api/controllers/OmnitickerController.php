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

    public function indexAction()
    {
        parent::indexAction();
        $this->_helper->json(array_map(function($doc) {
            return array(
                'article_id' => $doc['id'],
                'url' => !empty($doc['link']) ? $doc['link'] : null,
                'short_title' => !empty($doc['title']) ? $doc['title'] : $doc['tweet'],
                'last_modified' => $doc['published'],
                'section_id' => null,
                'section_name' => !empty($doc['section_name']) ? $doc['section_name'] : null,
                'source' => $doc['type'],
            );
        }, $this->view->result['response']['docs']));
    }

    protected function buildSolrDateParam()
    {
        if (!$this->_getParam('start_date')) {
            $this->sendError();
        }

        try {
            $startDate = new DateTime($this->_getParam('start_date'));
            $this->setExpiresHeader($startDate);
        } catch (Exception $e) {
            $this->sendError($e);
        }

        $endDate = $startDate;
        if ($this->_getParam('end_date')) {
            try {
                $endDate = new DateTime($this->_getParam('end_date'));
            } catch (Exception $e) {
                $this->sendError($e);
            }
        }

        return sprintf('published:[%s/DAY TO %s+1DAY/DAY]', // it's <,) interval thus +1 day
            $startDate->format('Y-m-d\TH:i:s\Z'),
            $endDate->format('Y-m-d\TH:i:s\Z'));
    }

    protected function buildSolrParams()
    {
        $params = parent::buildSolrParams();
        $params['rows'] = self::ROWS;
        return $params;
    }

    /**
     * Send error and exit
     *
     * @param Exception $e
     * @param int $code
     * @return void
     */
    private function sendError(Exception $e, $code = 400)
    {
        $this->getResponse()->setBody($e->getMessage());
        $this->getResponse()->setHttpResponseCode($code);
        $this->getResponse()->sendResponse();
        exit;
    }

    /**
     * Set expires header based on start date
     *
     * @param DateTime $startDate
     * @return void
     */
    private function setExpiresHeader(DateTime $startDate)
    {
        $now = new DateTime();
        $expires = new DateInterval($startDate->format('Y-m-d') === $now->format('Y-m-d') ? 'PT5M' : 'P300D');
        $this->getResponse()->setHeader('Expires', $now->add($expires)->format(DateTime::RFC1123), true);
        $this->getResponse()->setHeader('Pragma', 'cache', true);
        $this->getResponse()->setHeader('Cache-Control', 'public, max-age=300', true);
    }
}
