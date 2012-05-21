<?php
/**
 * Ticker function
 *
 * @param array $params
 * @param object $smarty
 * @return string
 */
function smarty_function_ticker($params, $smarty)
{
    $client = \Zend_Registry::get('container')->getService('solr.client.select');
    $sections = array( // whitelist
        'basel',
        'schweiz',
        'international',
        'sport',
        'kultur',
        'leben',
    );

    $filters = array();
    $types = array('tweet', 'newswire');
    if (!empty($params['section']) && $params['section']->number && in_array($params['section']->url_name, $sections)) {
        $filters[] = sprintf('section:%s', $params['section']->url_name);
        $types = array_diff($types, array('tweet'));
    } else { // filter en news
        $filters[] = '-section:swissinfo';
    }

    $filters[] = sprintf('type:(%s)', implode(' OR ', $types));

    $client->setParameterGet(array(
        'fq' => implode(' AND ', $filters),
        'rows' => 6,
        'q' => '*:*',
        'spellcheck' => 'false',
        'facet' => 'false',
        'sort' => 'published desc',
        'wt' => 'json',
    ));

    try {
        $response = $client->request();
    } catch (\Exception $e) {
        return json_encode(array());
    }

    return $response->getBody();
}
