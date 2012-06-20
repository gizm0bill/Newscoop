<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

require_once __DIR__ . '/OmnitickerController.php';

/**
 */
class Api_SearchController extends Api_OmnitickerController
{
    const Q_PARAM = 'query_string';

    public function preDispatch()
    {
        if (!$this->_getParam(self::Q_PARAM)) {
            $this->sendError("No 'query_string' provided");
        }
    }

    /**
     * Build solr params
     *
     * @return array
     */
    protected function buildSolrParams()
    {
        $dateParam = $this->buildSolrDateParam();
        return array_merge(parent::buildSolrParams(), array(
            'q' => $this->_getParam(self::Q_PARAM),
            'fq' => '!section:swissinfo AND -type:tweet' . ($dateParam ? " AND $dateParam" : ''), 
        ));
    }
}
