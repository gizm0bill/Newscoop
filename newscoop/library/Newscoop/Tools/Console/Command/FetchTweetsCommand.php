<?php
/**
 * @package Newscoop
 * @copyright 2011 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

namespace Newscoop\Tools\Console\Command;

use Symfony\Component\Console\Input\InputArgument,
    Symfony\Component\Console\Input\InputOption,
    Symfony\Component\Console;

/**
 * Fetch tweets command
 */
class FetchTweetsCommand extends Console\Command\Command
{
    /**
     * @see Console\Command\Command
     */
    protected function configure()
    {
        $this
        ->setName('fetchtweets')
        ->setDescription('Fetches tweets and feeds them into solr')
        ->setHelp(<<<EOT
Fetches tweets and feed them into solr
EOT
        );
    }

    /**
     * @see Console\Command\Command
     */
    protected function execute(Console\Input\InputInterface $input, Console\Output\OutputInterface $output)
    {
        $twitterUser = 'tageswoche';
        $twitterUrl = 'https://api.twitter.com/1/favorites.json';
        
        $client = $this->getHelper('container')->getService('solr.client.select');
        $client->setParameterGet(array(
            'wt' => 'json',
            'q' => '*:*',
            'fq' => 'type:tweet',
            'fl' => 'tweet_id',
            'sort' => 'published desc',
            'rows' => '1'
        ));

        $response = $client->request();
        $response = json_decode($response->getBody(), true);
        $response = $response['response'];
        
        $parameters = array();
        $parameters['id'] = $twitterUser;
        //$parameters['count'] = 1;
        
        if ($response['numFound'] != 0) {
            $parameters['since_id'] = $response['docs'][0]['tweet_id'];
        }
        
        $httpClient = new \Zend_Http_Client();
        $httpClient->setUri($twitterUrl);
        $httpClient->setParameterGet($parameters);
        $response = $httpClient->request('GET');
        
        $results = json_decode($response->getBody(), true);
        //var_dump($results);die;
        
        $items = array();
        foreach ($results as $item) {
            $date = date('Y-m-d\TH:i:s\Z', strtotime($item['created_at']));
            
            $items[] = array(
                'id' => 'tweet-'.$item['id_str'],
                'type' => 'tweet',
                'tweet_id' => $item['id_str'],
                'published' => $date,
                'tweet' => $item['text'],
                'tweet_user_name' => $item['user']['name'],
                'tweet_user_screen_name' => $item['user']['screen_name'],
                'tweet_user_profile_image_url' => $item['user']['profile_image_url']
            );
        }
        
        if (count($items) != 0) {
            $items = array('add' => $items);
            $items = json_encode($items);
            
            $client = $this->getHelper('container')->getService('solr.client.update');
            $client->setRawData($items, 'application/json');

            $response = $client->request('POST');
        }
    }
}