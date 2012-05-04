<?php
/**
 * @package Newscoop
 * @copyright 2011 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

class ArticleofthedayController extends Zend_Controller_Action
{
    public function init()
    {
        $this->_helper->viewRenderer->setViewSuffix('tpl');

        $ajaxContext = $this->_helper->getHelper('AjaxContext');
        $ajaxContext->addActionContext('article-of-the-day', 'json')
                    ->initContext();
    }

    public function indexAction()
    {
        $this->view->headScript()->appendFile($this->view->baseUrl('/public/js/jquery.wobscalendar.js'));

        $request = $this->getRequest();

        $view = $request->getParam('view', "month");
        $this->view->defaultView = $view;

        $date = $request->getParam('date', date("Y/m/d"));
        $date = explode("/", $date);

        $today = date("Y/m/d");
        $today = explode("/", $today);
        $this->view->today = $today;
        
        //TagesWoche wants the previous month shown instead of the current month now as a default.
        $startDate = array();
        
        if ($today[1] == "1") {
            $startDate[0] = $today[0] - 1;
            $startDate[1] = 12;
        }
        else {
            $startDate[0] = $today[0];
            $startDate[1] = $today[1] - 1;
        }
        
        $this->view->year = $startDate[0];
        $this->view->month = $startDate[1] - 1;
        
        $now = new DateTime("$today[0]-$today[1]");

        //oldest month user can scroll to YYYY/mm
        $earliestMonth = $request->getParam('earliestMonth', null);
        if (isset($earliestMonth) && $earliestMonth == "current") {
            $this->view->earliestMonth = $today;
        }
        else if (isset($earliestMonth)) {

            $earliestMonth = explode("/", $earliestMonth);
            $tmp_earliest = new DateTime("$earliestMonth[0]-$earliestMonth[1]");

            if ($tmp_earliest > $now) {
                $earliestMonth = $today;
            }

            $this->view->earliestMonth = $earliestMonth;
        }
        else {
            $this->view->earliestMonth = null;
        }

        //most recent month user can scroll to YYYY/mm
        $latestMonth = $request->getParam('latestMonth', null);
        if (isset($latestMonth) && $latestMonth == "current") { 
            $this->view->latestMonth = $today;
        }
        else if (isset($latestMonth)) {
            $latestMonth = explode("/", $latestMonth);
            $tmp_latest = new DateTime("$latestMonth[0]-$latestMonth[1]");

            if ($now > $tmp_latest) {
                $latestMonth = $today;
            }

            $this->view->latestMonth = $latestMonth;
        }
        else {
            $this->view->latestMonth = null;
        }

        $imageWidth = $request->getParam('imageWidth', 140);
        if (!is_int($imageWidth)) {
            $imageWidth = 140;
        }
        $this->view->imageWidth = $imageWidth;

        $this->view->nav = $request->getParam('navigation', true);
        $this->view->firstDay = $request->getParam('firstDay', 0);
        $this->view->dayNames = $request->getParam('showDayNames', true);
        $this->view->rand_int = md5(uniqid("", true));
    }

    public function articleOfTheDayAction()
    {
        $request = $this->getRequest();

        //TODO parse these to make sure are times.
        $start_date = $request->getParam('start');
        $end_date = $request->getParam('end');

        $imageWidth = $request->getParam('image_width', 140);

        $articles = Article::GetArticlesOfTheDay($start_date, $end_date);

        //get what we need for the json returned data.
        $results = array();

        foreach ($articles as $article) {
            $article_number = $article->getArticleNumber();

            $json = array();

            $json['title'] = $article->getTitle();
            
            $image = $this->_helper->service('image.rendition')->getArticleRenditionImage($article_number, 'rubrikenseite', 140, 94);
            
            if (isset($image)) {
                $json['image'] = $this->view->url(array('src' => $image['src']), 'image', true, false);
            }
            else {
                $json['image'] = null;
            }

            $date = $article->getPublishDate();
            $date = explode(" ", $date);
            $YMD = explode("-", $date[0]);

            //month-1 is for js, months are 0-11.
            $json['date'] = array("year"=>intval($YMD[0]), "month"=>intval($YMD[1]), "day"=>intval($YMD[2]));

            $json['url'] = ShortURL::GetURL($article->getPublicationId(), $article->getLanguageId(), null, null, $article_number);

            $results[] = $json;
        }

        $this->view->articles = $results;
    }
}
