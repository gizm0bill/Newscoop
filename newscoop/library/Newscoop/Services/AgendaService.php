<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

namespace Newscoop\Services;

require_once($GLOBALS['g_campsiteDir'].'/classes/Article.php');
require_once($GLOBALS['g_campsiteDir'].'/classes/TopicName.php');
require_once($GLOBALS['g_campsiteDir'].'/template_engine/classes/Operator.php');
require_once($GLOBALS['g_campsiteDir'].'/template_engine/classes/ComparisonOperation.php');

/*
use Doctrine\ORM\EntityManager,
    Newscoop\Entity\Section,
    Newscoop\Entity\Publication;
*/

/**
 * Agenda service
 */
class AgendaService
{

    /**
     */
    public function __construct()
    {
    }

    public function getEventList($p_params)
    {
        $empty_list = array();

        if (!isset($p_params['event_date'])) {
            return $empty_list;
        }
        if (!isset($p_params['event_region'])) {
            return $empty_list;
        }
        if (!isset($p_params['event_type'])) {
            return $empty_list;
        }

        if (!isset($p_params['publication'])) {
            return $empty_list;
        }
        if (!isset($p_params['language'])) {
            return $empty_list;
        }
        if (!isset($p_params['section'])) {
            return $empty_list;
        }

        if (!isset($p_params['article_type'])) {
            return $empty_list;
        }

        $use_publication = $p_params['publication']; // 3;
        $use_language = $p_params['language']; // 5;
        $use_section = $p_params['section']; // 71;
        $use_type = $p_params['article_type']; // 'event';


        $use_date = $p_params['event_date']; // '2012-06-06';

        //$use_topics = array('99', '134');
        $use_topics = array();

        $region_topic = new \TopicName($p_params['event_region'], $p_params['language']);
        $region_topic_id = $region_topic->getTopicId();
        $use_topics[] = $region_topic_id;

        $type_topic = new \TopicName($p_params['event_type'], $p_params['language']);
        $type_topic_id = $type_topic->getTopicId();
        $use_topics[] = $type_topic_id;

        $ev_parameters = array();

        if (true) {
            $leftOperand = 'complex_date';
            $rightOperand = array('schedule' => 'start_date: ' . $use_date . ', end_date: ' . $use_date);
            $operator = new \Operator('is', 'string');
            $constraint = new \ComparisonOperation($leftOperand, $operator, $rightOperand);
            $ev_parameters[] = $constraint;
        }

        if (true) {
            $leftOperand = 'IdPublication';
            $rightOperand = $use_publication;
            $operator = new \Operator('is', 'integer');
            $constraint = new \ComparisonOperation($leftOperand, $operator, $rightOperand);
            $ev_parameters[] = $constraint;
        }
        if (true) {
            $leftOperand = 'IdLanguage';
            $rightOperand = $use_language;
            $operator = new \Operator('is', 'integer');
            $constraint = new \ComparisonOperation($leftOperand, $operator, $rightOperand);
            $ev_parameters[] = $constraint;
        }
        if (true) {
            $leftOperand = 'published';
            $rightOperand = 'true';
            $operator = new \Operator('is', 'string');
            $constraint = new \ComparisonOperation($leftOperand, $operator, $rightOperand);
            $ev_parameters[] = $constraint;
        }

        if (true) {
            $leftOperand = 'section';
            $rightOperand = $use_section;
            $operator = new \Operator('is', 'integer');
            $constraint = new \ComparisonOperation($leftOperand, $operator, $rightOperand);
            $ev_parameters[] = $constraint;
        }
        if (true) {
            $leftOperand = 'type';
            $rightOperand = $use_type;
            $operator = new \Operator('is', 'string');
            $constraint = new \ComparisonOperation($leftOperand, $operator, $rightOperand);
            $ev_parameters[] = $constraint;
        }
        if (true) {
            foreach ($use_topics as $one_topic) {
                $leftOperand = 'topic';
                $rightOperand = $one_topic;
                $operator = new \Operator('is', 'topic');
                $constraint = new \ComparisonOperation($leftOperand, $operator, $rightOperand);
                $ev_parameters[] = $constraint;
            }
        }

        if (true) {
            $leftOperand = 'matchalltopics';
            $rightOperand = true;
            $operator = new \Operator('is', 'boolean');
            $constraint = new \ComparisonOperation($leftOperand, $operator, $rightOperand);
            $ev_parameters[] = $constraint;
        }

        $ev_order = array();
        // for movies: $ev_order = array(array('field' => 'byname', 'dir' => 'asc'));


        $ev_start = 0;
        $ev_limit = 0;
        $ev_count = 0;
        $ev_skipCache = false;
        $ev_returnObjs = true;

        $events = \Article::GetList($ev_parameters, $ev_order, $ev_start, $ev_limit, &$ev_count, $ev_skipCache, $ev_returnObjs);

        if (empty($events)) {
            return $empty_list;
        }

        return $events;
    }

    public function getRegionList($p_params)
    {
        if (isset($p_params['country']) && ('ch' != $p_params['country'])) {
            return array();
        }

        return array(
            'region-basel' => array('topic' => 'Region Basel', 'label' => 'Region Basel'),
            'kanton-basel-stadt' => array('topic' => 'Kanton Basel-Stadt', 'label' => 'Basel-Stadt'),
            'kanton-basel-landschaft' => array('topic' => 'Kanton Basel-Landschaft', 'label' => 'Basel-Landschaft'),
            'kanton-aargau' => array('topic' => 'Kanton Aargau', 'label' => 'Aargau'),
            'kanton-appenzell-ausserrhoden' => array('topic' => 'Kanton Appenzell Ausserrhoden', 'label' => 'Appenzell Ausserrhoden'),
            'kanton-appenzell-innerrhoden' => array('topic' => 'Kanton Appenzell Innerrhoden', 'label' => 'Appenzell Innerrhoden'),
            'kanton-bern' => array('topic' => 'Kanton Bern', 'label' => 'Bern'),
            'kanton-freiburg' => array('topic' => 'Kanton Freiburg', 'label' => 'Freiburg'),
            'kanton-genf' => array('topic' => 'Kanton Genf', 'label' => 'Genf'),
            'kanton-glarus' => array('topic' => 'Kanton Glarus', 'label' => 'Glarus'),
            'kanton-graubuenden' => array('topic' => 'Kanton Graubünden', 'label' => 'Graubünden'),
            'kanton-jura' => array('topic' => 'Kanton Jura', 'label' => 'Jura'),
            'kanton-luzern' => array('topic' => 'Kanton Luzern', 'label' => 'Luzern'),
            'kanton-neuenburg' => array('topic' => 'Kanton Neuenburg', 'label' => 'Neuenburg'),
            'kanton-nidwalden' => array('topic' => 'Kanton Nidwalden', 'label' => 'Nidwalden'),
            'kanton-obwalden' => array('topic' => 'Kanton Obwalden', 'label' => 'Obwalden'),
            'kanton-schaffhausen' => array('topic' => 'Kanton Schaffhausen', 'label' => 'Schaffhausen'),
            'kanton-schwyz' => array('topic' => 'Kanton Schwyz', 'label' => 'Schwyz'),
            'kanton-solothurn' => array('topic' => 'Kanton Solothurn', 'label' => 'Solothurn'),
            'kanton-st-gallen' => array('topic' => 'Kanton St. Gallen', 'label' => 'St. Gallen'),
            'kanton-tessin' => array('topic' => 'Kanton Tessin', 'label' => 'Tessin'),
            'kanton-thurgau' => array('topic' => 'Kanton Thurgau', 'label' => 'Thurgau'),
            'kanton-uri' => array('topic' => 'Kanton Uri', 'label' => 'Uri'),
            'kanton-waadt' => array('topic' => 'Kanton Waadt', 'label' => 'Waadt'),
            'kanton-wallis' => array('topic' => 'Kanton Wallis', 'label' => 'Wallis'),
            'kanton-zug' => array('topic' => 'Kanton Zug', 'label' => 'Zug'),
            'kanton-zuerich' => array('topic' => 'Kanton Zürich', 'label' => 'Zürich'),
        );
    }

    public function getEventTypeList($p_params)
    {
        if (isset($p_params['country']) && ('ch' != $p_params['country'])) {
            return array();
        }

        return array(
            'theater' => array('topic' =>  'Theater Veranstaltung', 'label' => 'Theater'),
            'musik' => array('topic' =>  'Musik Veranstaltung', 'label' => 'Konzerte'),
            'party' => array('topic' =>  'Party Veranstaltung', 'label' => 'Partys'),
            'ausstellung' => array('topic' =>  'Ausstellung Veranstaltung', 'label' => 'Ausstellungen'),
            'andere' => array('topic' =>  'Andere Veranstaltung', 'label' => 'Diverse'),
        );

    }

}
