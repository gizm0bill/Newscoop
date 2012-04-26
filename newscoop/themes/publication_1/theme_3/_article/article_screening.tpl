{{ include file="_tpl/_html-head.tpl" }}

<body>

    <div id="wrapper">

{{ include file="_tpl/header-omnibox.tpl" }}

{{ include file="_tpl/header.tpl" }}

{{ include file="_ausgehen/subnav.tpl" }}


{{ assign var="region_name" "Kanton Basel-Stadt" }}
{{ assign var="region_link" "kanton-basel-stadt" }}

{{ list_article_topics }}
    {{ assign var="cur_topic" $gimme->topic->name }}

    {{ if "Region Basel" eq $cur_topic }}
        {{ assign var="region_link" "region-basel" }}
        {{ assign var="region_name" "Region Basel" }}
    {{ elseif "Kanton Basel-Stadt" eq $cur_topic }}
        {{ assign var="region_link" "kanton-basel-stadt" }}
        {{ assign var="region_name" "Kanton Basel-Stadt" }}
    {{ elseif "Kanton Basel-Landschaft" eq $cur_topic }}
        {{ assign var="region_link" "kanton-basel-landschaft" }}
        {{ assign var="region_name" "Kanton Basel-Landschaft" }}
    {{ elseif "Kanton Aargau" eq $cur_topic }}
        {{ assign var="region_link" "kanton-aargau" }}
        {{ assign var="region_name" "Kanton Aargau" }}
    {{ elseif "Kanton Appenzell Ausserrhoden" eq $cur_topic }}
        {{ assign var="region_link" "kanton-appenzell-ausserrhoden" }}
        {{ assign var="region_name" "Kanton Appenzell Ausserrhoden" }}
    {{ elseif "Kanton Appenzell Innerrhoden" eq $cur_topic }}
        {{ assign var="region_link" "kanton-appenzell-innerrhoden" }}
        {{ assign var="region_name" "Kanton Appenzell Innerrhoden" }}
    {{ elseif "Kanton Bern" eq $cur_topic }}
        {{ assign var="region_link" "kanton-bern" }}
        {{ assign var="region_name" "Kanton Bern" }}
    {{ elseif "Kanton Freiburg" eq $cur_topic }}
        {{ assign var="region_link" "kanton-freiburg" }}
        {{ assign var="region_name" "Kanton Freiburg" }}
    {{ elseif "Kanton Genf" eq $cur_topic }}
        {{ assign var="region_link" "kanton-genf" }}
        {{ assign var="region_name" "Kanton Genf" }}
    {{ elseif "Kanton Glarus" eq $cur_topic }}
        {{ assign var="region_link" "kanton-glarus" }}
        {{ assign var="region_name" "Kanton Glarus" }}
    {{ elseif "Kanton Graubünden" eq $cur_topic }}
        {{ assign var="region_link" "kanton-graubuenden" }}
        {{ assign var="region_name" "Kanton Graubünden" }}
    {{ elseif "Kanton Jura" eq $cur_topic }}
        {{ assign var="region_link" "kanton-jura" }}
        {{ assign var="region_name" "Kanton Jura" }}
    {{ elseif "Kanton Luzern" eq $cur_topic }}
        {{ assign var="region_link" "kanton-luzern" }}
        {{ assign var="region_name" "Kanton Luzern" }}
    {{ elseif "Kanton Neuenburg" eq $cur_topic }}
        {{ assign var="region_link" "kanton-neuenburg" }}
        {{ assign var="region_name" "Kanton Neuenburg" }}
    {{ elseif "Kanton Nidwalden" eq $cur_topic }}
        {{ assign var="region_link" "kanton-nidwalden" }}
        {{ assign var="region_name" "Kanton Nidwalden" }}
    {{ elseif "Kanton Obwalden" eq $cur_topic }}
        {{ assign var="region_link" "kanton-obwalden" }}
        {{ assign var="region_name" "Kanton Obwalden" }}
    {{ elseif "Kanton Schaffhausen" eq $cur_topic }}
        {{ assign var="region_link" "kanton-schaffhausen" }}
        {{ assign var="region_name" "Kanton Schaffhausen" }}
    {{ elseif "Kanton Schwyz" eq $cur_topic }}
        {{ assign var="region_link" "kanton-schwyz" }}
        {{ assign var="region_name" "Kanton Schwyz" }}
    {{ elseif "Kanton Solothurn" eq $cur_topic }}
        {{ assign var="region_link" "kanton-solothurn" }}
        {{ assign var="region_name" "Kanton Solothurn" }}
    {{ elseif "Kanton St. Gallen" eq $cur_topic }}
        {{ assign var="region_link" "kanton-st-gallen" }}
        {{ assign var="region_name" "Kanton St. Gallen" }}
    {{ elseif "Kanton Tessin" eq $cur_topic }}
        {{ assign var="region_link" "kanton-tessin" }}
        {{ assign var="region_name" "Kanton Tessin" }}
    {{ elseif "Kanton Thurgau" eq $cur_topic }}
        {{ assign var="region_link" "kanton-thurgau" }}
        {{ assign var="region_name" "Kanton Thurgau" }}
    {{ elseif "Kanton Uri" eq $cur_topic }}
        {{ assign var="region_link" "kanton-uri" }}
        {{ assign var="region_name" "Kanton Uri" }}
    {{ elseif "Kanton Waadt" eq $cur_topic }}
        {{ assign var="region_link" "kanton-waadt" }}
        {{ assign var="region_name" "Kanton Waadt" }}
    {{ elseif "Kanton Wallis" eq $cur_topic }}
        {{ assign var="region_link" "kanton-wallis" }}
        {{ assign var="region_name" "Kanton Wallis" }}
    {{ elseif "Kanton Zug" eq $cur_topic }}
        {{ assign var="region_link" "kanton-zug" }}
        {{ assign var="region_name" "Kanton Zug" }}
    {{ elseif "Kanton Zürich" eq $cur_topic }}
        {{ assign var="region_link" "kanton-zuerich" }}
        {{ assign var="region_name" "Kanton Zürich" }}

    {{ /if }}
{{ /list_article_topics }}


{{* by default we gonna limit event list to those happening today *}} 
{{ assign var="usedate" $smarty.now|camp_date_format:"%Y-%m-%d" }}
{{ assign var="usedate_link" $usedate }}
{{ if !empty($smarty.get.date) }}
    {{ assign var="usedate" $smarty.get.date|replace:" ":"\\ "|replace:'"':"" }}
{{ /if }}

{{ assign var="usedate_test" $usedate|regex_replace:"/(\d){4}-(\d){2}-(\d){2}/":"ok" }}
{{ if "ok" != $usedate }}
    {{ if "ok" == $usedate_test }}
        {{ assign var="usedate_link" $usedate }}
    {{ /if }}
{{ /if }}


<script type="text/javascript">
$(document).ready(function() {
    update_subnav_links("{{ $usedate_link }}", "{{ $region_link }}");

    highlight_agenda_type("kino");
});

function load_events(ev_type) {
    return true;
};
</script>


        <div class="content-box clearfix agenda-content agenda-single">

            <section>

                <article id="movie_article" class="movie {{*stared*}}">

                    <h2>{{ $gimme->article->headline|strip_tags }}</h2>
                    {{ if $gimme->article->has_image(1) }}
                    <img src="{{ url options="image 1 width 188" }}" alt="{{ $gimme->article->image1->description|replace:'"':'\'' }}" class="thumbnail" />
                    {{ /if }}

                    <ul class="top-list-details">
                        {{ assign var="movie_rating_wv" $gimme->article->movie_rating_wv }}
                        {{ if $movie_rating_wv ne "" }}
                            {{ assign var="movie_rating_wv" 0+$movie_rating_wv }}
                            {{ if $movie_rating_wv ne 0 }}
                                <li><span>Bewertung:</span> <ul class="rating"><li{{ if $movie_rating_wv > 0 }} class="on"{{ /if }}>1</li><li{{ if $movie_rating_wv > 1 }} class="on"{{ /if }}>2</li><li{{ if $movie_rating_wv > 2 }} class="on"{{ /if }}>3</li><li{{ if $movie_rating_wv > 3 }} class="on"{{ /if }}>4</li><li{{ if $movie_rating_wv > 4 }} class="on"{{ /if }}>5</li></ul> <em>{{ $movie_rating_wv }}</em></li>
                            {{ /if }}
                        {{ /if }}
                        {{ if $gimme->article->movie_director ne "" }}
                        <li><span class="movie_info_key">Regisseur:</span> {{ $gimme->article->movie_director|replace:",":", " }}</li>
                        {{ /if }}
                        {{ if $gimme->article->movie_cast ne "" }}
                        <li><span class="movie_info_key">Schauspieler:</span> {{ $gimme->article->movie_cast|replace:",":", " }}</li>
                        {{ /if }}
                        {{ if "" != $gimme->article->minimal_age }}
                            <li><span>Altersfreigabe:</span> ab {{ $gimme->article->minimal_age }}</li>
                        {{ /if }}
                        {{ if $gimme->article->movie_duration ne "" }}
                        {{ if $gimme->article->movie_duration ne "0" }}
                        {{ if $gimme->article->movie_duration ne 0 }}
                        <li><span class="movie_info_key">Spielzeit:</span> {{ $gimme->article->movie_duration }} min.</li>
                        {{ /if }}
                        {{ /if }}
                        {{ /if }}
{{*
                        <li><span>Sprache:</span> E/d/f</li>
*}}
                    </ul>
                    <p>
                    {{ $gimme->article->description }}
                    </p>
{{ if $gimme->article->other }}
                    <p>
                    {{ $gimme->article->other|replace:"<a href=":"<a target='_blank' href="|replace:">http://":">" }}
                    </p>
{{ /if }}

{{*
                    <div class="social-network-box clearfix">
                        <div id="social_bookmarks" class="left"></div>
                        <p class="right">
                            <a href="#" class="grey-button">In Kalender eintragen</a>
                            <a href="#" onclick="window.print();return false" class="grey-button print"><span>Print</span></a>
                            <script type="text/javascript" src="http://s7.addthis.com/js/250/addthis_widget.js#username=sourcefabric"></script>
                        </p>
                    </div>
*}}

{{ if $gimme->article->movie_trailer_vimeo ne "" }}

{{ assign var="vimeo_id" value=$gimme->article->movie_trailer_vimeo }}
{{ assign var="vimeo_width_orig" value=$gimme->article->movie_trailer_width }}
{{ assign var="vimeo_width_orig" value=0+$vimeo_width_orig }}
{{ assign var="vimeo_height_orig" value=$gimme->article->movie_trailer_height }}
{{ assign var="vimeo_height_orig" value=0+$vimeo_height_orig }}

{{* assign var="vimeo_width_show" value="640" *}}
{{* assign var="vimeo_height_show" value="344" *}}
{{ assign var="vimeo_width_show" value="648" }}
{{ assign var="vimeo_height_show" value="359" }}
{{ if $vimeo_width_orig gt 0 }}
    {{ if $vimeo_height_orig gt 0 }}
        {{ assign var="vimeo_height_show" value=$vimeo_width_show * $vimeo_height_orig / $vimeo_width_orig }}
    {{ /if }}
{{ /if }}

                    <div class="movie-trailer">
                        <iframe src="http://player.vimeo.com/video/{{ $vimeo_id }}?title=0&amp;byline=0&amp;portrait=0" width="{{ $vimeo_width_show }}" height="{{ $vimeo_height_show }}" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen>
                        </iframe>
{{*
                        <iframe width="648" height="359" src="http://www.youtube.com/embed/JlBr-3aDTHg" frameborder="0" allowfullscreen></iframe>
*}}
                    </div>
{{ /if }}

{{ assign var="some_images" value=0 }}
{{ if $gimme->article->has_image(1) }}
    {{ assign var="some_images" value=1 }}
{{ /if }}

{{ if $some_images eq 1 }}
                <div class="image-slideshow tabs">

                    <h4>Bilder zum Film</h4>

                    {{ assign var="list_img_rank" 1 }}
                    {{ while $gimme->article->has_image($list_img_rank) }}
                        <div id="image-{{ $list_img_rank }}" class="img-content">
                            <img src="{{ url options="image $list_img_rank height 400" }}" alt="" />
                            <p>{{ $gimme->article->image1->description }}</p>
                        </div>
                        {{ assign var="list_img_rank" $list_img_rank+1 }}
                    {{ /while }}

                    <ul class="slideshow-nav carousel jcarousel-skin-img-slider">
                    {{ assign var="list_img_rank" 1 }}
                    {{ while $gimme->article->has_image($list_img_rank) }}
                        <li><a href="#image-{{ $list_img_rank }}"><img src="{{ url options="image $list_img_rank width 95" }}" alt="" /></a></li>
                        {{ assign var="list_img_rank" $list_img_rank+1 }}
                    {{ /while }}
                    </ul>

                </div>
{{ /if }}

{{ php }}

function parse_date_text($date_time_text)
{
    $dates = array();

    $cur_date = null;

    $gl_has_d = false; // de
    $gl_has_k = false; // dialekt
    $gl_has_f = false; // fr
    $gl_has_t = false; // subtitles

    $date_time_text = strip_tags(str_replace(array('<'), array("\n<"), $date_time_text));
    foreach (explode("\n", $date_time_text) as $one_date_time_str) {
        $one_date_time_str = trim($one_date_time_str);
        if (empty($one_date_time_str)) {
            continue;
        }

        $matches = array();
        if (preg_match('/^(\d{4})-(\d{2})-(\d{2})$/', $one_date_time_str, $matches)) {
            // new date
            $cur_date = $one_date_time_str;
            $dates[$cur_date] = array();

            continue;
        }

        if (null === $cur_date) {
            continue; // this should not occur
        }

        $time_info = explode(':', $one_date_time_str);
        $time_info_size = count($time_info);

        $time_str = $time_info[0];
        $lang_str = ((2 <= $time_info_size) ? $time_info[1] : '');
        $flag_str = ((3 <= $time_info_size) ? $time_info[2] : '');

        $has_d = false;
        $has_k = false;
        $has_f = false;
        $has_t = false;
        if (0 < strlen($lang_str)) {
            if (('D' == substr($lang_str,0,1)) && ('Di' != substr($lang_str,0,2))) {
                $has_d = true;
            }
            if ('dialekt' == strtolower($lang_str)) {
                $has_k = true;
            }
            if ('F' == substr($lang_str,0,1)) {
                $has_f = true;
            }
            if ((!$has_d) && (!$has_k)) {
                foreach(explode('/', $lang_str) as $lang_part) {
                    if ('d' == $lang_part) {
                        $has_t = true;
                        break;
                    }
                }
            }
        }

        $gl_has_d = $gl_has_d || $has_d;
        $gl_has_k = $gl_has_k || $has_k;
        $gl_has_f = $gl_has_f || $has_f;
        $gl_has_t = $gl_has_t || $has_t;

        $dates[$cur_date][] = array('time' => $time_str, 'lang' => $lang_str, 'flag' => $flag_str, 'has_d' => ($has_d ? 1 : 0), 'has_k' => ($has_k ? 1 : 0), 'has_f' => ($has_f ? 1 : 0), 'has_t' => ($has_t ? 1 : 0));

    }

    ksort($dates);
    return array('dates' => $dates, 'langs' => array('d' => ($gl_has_d ? 1 : 0), 'k' => ($gl_has_k ? 1 : 0), 'f' => ($gl_has_f ? 1 : 0), 't' => ($gl_has_t ? 1 : 0)));
}

{{ /php }}


{{* constraints for movie screening list *}}

{{ assign var="movie_key" $gimme->article->movie_key }}
{{ assign var="movie_key" $movie_key|replace:" ":"\\ " }}
{{ assign var="article_number" $gimme->article->number }}
{{ assign var="article_number" $article_number|replace:" ":"\\ " }}

{{ assign var="movie_headline" $gimme->article->headline }}
{{ assign var="movie_headline" $movie_headline|replace:" ":"\\ " }}
{{ assign var="head_constraint" "headline is $movie_headline" }}

{{ assign var="art_constraints" "" }}
{{ if "" eq $movie_key }}
    {{* assign var="art_constraints" "number is $article_number" *}}
    {{ assign var="art_constraints" $head_constraint }}
{{ else }}
    {{ assign var="art_constraints" "movie_key is $movie_key" }}
{{ /if }}


{{ assign var="art_list" "" }}
{{ assign var="art_list_sep" "," }}

{{* assign var="useregion" "Kanton\\ Basel-Stadt" *}}
{{ assign var="useregion" "" }}
{{ assign var="linkregion" "kanton-basel-stadt" }}
{{ if !empty($smarty.get.region) }}
    {{ assign var="useregion_spec" $smarty.get.region }}
    {{ if "region-basel" eq $useregion_spec }}
        {{ assign var="useregion" "Region\\ Basel" }}
        {{ assign var="linkregion" "region-basel" }}
    {{ elseif "kanton-basel-stadt" eq $useregion_spec }}
        {{ assign var="useregion" "Kanton\\ Basel-Stadt" }}
        {{ assign var="linkregion" "kanton-basel-stadt" }}
    {{ elseif "kanton-basel-landschaft" eq $useregion_spec }}
        {{ assign var="useregion" "Kanton\\ Basel-Landschaft" }}
        {{ assign var="linkregion" "kanton-basel-landschaft" }}
    {{ elseif "kanton-aargau" eq $useregion_spec }}
        {{ assign var="useregion" "Kanton\\ Aargau" }}
        {{ assign var="linkregion" "kanton-aargau" }}
    {{ elseif "kanton-appenzell-ausserrhoden" eq $useregion_spec }}
        {{ assign var="useregion" "Kanton\\ Appenzell\\ Ausserrhoden" }}
        {{ assign var="linkregion" "kanton-appenzell-ausserrhoden" }}
    {{ elseif "kanton-appenzell-innerrhoden" eq $useregion_spec }}
        {{ assign var="useregion" "Kanton\\ Appenzell\\ Innerrhoden" }}
        {{ assign var="linkregion" "kanton-appenzell-innerrhoden" }}
    {{ elseif "kanton-bern" eq $useregion_spec }}
        {{ assign var="useregion" "Kanton\\ Bern" }}
        {{ assign var="linkregion" "kanton-bern" }}
    {{ elseif "kanton-freiburg" eq $useregion_spec }}
        {{ assign var="useregion" "Kanton\\ Freiburg" }}
        {{ assign var="linkregion" "kanton-freiburg" }}
    {{ elseif "kanton-genf" eq $useregion_spec }}
        {{ assign var="useregion" "Kanton\\ Genf" }}
        {{ assign var="linkregion" "kanton-genf" }}
    {{ elseif "kanton-glarus" eq $useregion_spec }}
        {{ assign var="useregion" "Kanton\\ Glarus" }}
        {{ assign var="linkregion" "kanton-glarus" }}
    {{ elseif "kanton-graubuenden" eq $useregion_spec }}
        {{ assign var="useregion" "Kanton\\ Graubünden" }}
        {{ assign var="linkregion" "kanton-graubuenden" }}
    {{ elseif "kanton-jura" eq $useregion_spec }}
        {{ assign var="useregion" "Kanton\\ Jura" }}
        {{ assign var="linkregion" "kanton-jura" }}
    {{ elseif "kanton-luzern" eq $useregion_spec }}
        {{ assign var="useregion" "Kanton\\ Luzern" }}
        {{ assign var="linkregion" "kanton-luzern" }}
    {{ elseif "kanton-neuenburg" eq $useregion_spec }}
        {{ assign var="useregion" "Kanton\\ Neuenburg" }}
        {{ assign var="linkregion" "kanton-neuenburg" }}
    {{ elseif "kanton-nidwalden" eq $useregion_spec }}
        {{ assign var="useregion" "Kanton\\ Nidwalden" }}
        {{ assign var="linkregion" "kanton-nidwalden" }}
    {{ elseif "kanton-obwalden" eq $useregion_spec }}
        {{ assign var="useregion" "Kanton\\ Obwalden" }}
        {{ assign var="linkregion" "kanton-obwalden" }}
    {{ elseif "kanton-schaffhausen" eq $useregion_spec }}
        {{ assign var="useregion" "Kanton\\ Schaffhausen" }}
        {{ assign var="linkregion" "kanton-schaffhausen" }}
    {{ elseif "kanton-schwyz" eq $useregion_spec }}
        {{ assign var="useregion" "Kanton\\ Schwyz" }}
        {{ assign var="linkregion" "kanton-schwyz" }}
    {{ elseif "kanton-solothurn" eq $useregion_spec }}
        {{ assign var="useregion" "Kanton\\ Solothurn" }}
        {{ assign var="linkregion" "kanton-solothurn" }}
    {{ elseif "kanton-st-gallen" eq $useregion_spec }}
        {{ assign var="useregion" "Kanton\\ St.\\ Gallen" }}
        {{ assign var="linkregion" "kanton-st-gallen" }}
    {{ elseif "kanton-tessin" eq $useregion_spec }}
        {{ assign var="useregion" "Kanton\\ Tessin" }}
        {{ assign var="linkregion" "kanton-tessin" }}
    {{ elseif "kanton-thurgau" eq $useregion_spec }}
        {{ assign var="useregion" "Kanton\\ Thurgau" }}
        {{ assign var="linkregion" "kanton-thurgau" }}
    {{ elseif "kanton-uri" eq $useregion_spec }}
        {{ assign var="useregion" "Kanton\\ Uri" }}
        {{ assign var="linkregion" "kanton-uri" }}
    {{ elseif "kanton-waadt" eq $useregion_spec }}
        {{ assign var="useregion" "Kanton\\ Waadt" }}
        {{ assign var="linkregion" "kanton-waadt" }}
    {{ elseif "kanton-wallis" eq $useregion_spec }}
        {{ assign var="useregion" "Kanton\\ Wallis" }}
        {{ assign var="linkregion" "kanton-wallis" }}
    {{ elseif "kanton-zug" eq $useregion_spec }}
        {{ assign var="useregion" "Kanton\\ Zug" }}
        {{ assign var="linkregion" "kanton-zug" }}
    {{ elseif "kanton-zuerich" eq $useregion_spec }}
        {{ assign var="useregion" "Kanton\\ Zürich" }}
        {{ assign var="linkregion" "kanton-zuerich" }}
    {{ /if }}
{{ /if }}

{{ assign var="contopic_region" ""}}
{{ assign var="topic_suffix" ":de"}}

{{ if !empty($useregion) }}
    {{ assign var="contopic_region" "topic is $useregion$topic_suffix" }}
{{ /if }}

{{ list_articles ignore_issue="true" ignore_section="true" constraints="$contopic_region $art_constraints section is 72 type is screening " order="byname asc" }}
    {{ if $gimme->article->recommended }}
    <script type="text/javascript">
    $(document).ready(function() {
        $("#movie_article").addClass("stared");
    });
    {{ /if }}

    {{ assign var="date_time_str" $gimme->article->date_time_text|replace:"&nbsp;":" " }}
    {{ php }}
        $date_time_str = $template->get_template_vars('date_time_str');
        $date_time_arr = parse_date_text($date_time_str);
        $template->assign('date_time_arr',$date_time_arr['dates']);
    {{ /php }}

            <div style="margin-right:50px; float:left; width:580px;" class="movie-table">

                    <table cellpadding="0" cellspacing="0">
                        <tbody>
                        <tr>
                        <td rowspan="2">
                    <ul>
                        <li><h5>{{ $gimme->article->organizer }}</h5></li>
                        <li>
                            <p>{{ $gimme->article->street }}<br />
                            {{ $gimme->article->zipcode }} {{ $gimme->article->town }}</p>
                            <p>
                            {{ list_article_locations length="1" }}
                                <a href="http://maps.google.com/maps?hl=de&t=k&q={{ $gimme->location->latitude }},{{ $gimme->location->longitude }}+({{ $gimme->article->organizer|escape:'url' }})&z=17&ll={{ $gimme->location->latitude }},{{ $gimme->location->longitude }}" target="_blank">Google Maps</a><br />
                            {{ /list_article_locations }}
                            {{ if  "" != $gimme->article->web }}
                            <a href="{{ $gimme->article->web }}" target="_blank">{{ $gimme->article->web|replace:"http://":"" }}</a>
                            {{ else }}
                            &nbsp;
                            {{ /if }}
                            </p>
                        </li>
                        <li>
                            {{ if  "" != $gimme->article->phone }}
                            <p>Tel  {{ $gimme->article->phone }}{{* <a href="#" class="info" onClick="alert('wtf here?'); return false;">i</a>*}}</p>
                            {{ else }}
                            <p>&nbsp;</p>
                            {{ /if }}
                        </li>
                    </ul>

                        </td>

                        <!--<thead>-->
                            <!--<tr>-->
                        {{ foreach from=$date_time_arr key=date_time_key item=date_time_day }}
                            <td class="cinema_screen_list date_hl_all date_hl_{{$date_time_key|camp_date_format:"%Y-%m-%d"}}">{{ $date_time_key|camp_date_format:"%W"|truncate:2:'' }} <br />{{ $date_time_key|camp_date_format:"%e.%m" }}</td>
                        {{ /foreach }}
                            </tr>
                        <!--</thead>-->

                        <!--<tbody>-->
                            <tr>
                            {{ foreach from=$date_time_arr key=date_time_key item=date_time_day }}
                                    <td class="screen_time_list date_hl_all date_hl_{{$date_time_key|camp_date_format:"%Y-%m-%d"}}">
                                        <ul style="width:30px;margin-right:0px">
                                                    {{ foreach from=$date_time_day item=date_time_day_parts }}
                                                    {{ assign var="scr_lang_d" $date_time_day_parts.has_d }}
                                                    {{ assign var="scr_lang_k" $date_time_day_parts.has_k }}
                                                    {{ assign var="scr_lang_f" $date_time_day_parts.has_f }}
                                                    {{ assign var="scr_lang_t" $date_time_day_parts.has_t }}
                                                        <li class="movie_lang{{ if 1 == $scr_lang_d }} has_d{{ else }} has_not_d{{ /if }}{{ if 1 == $scr_lang_k }} has_k{{ else }} has_not_k{{ /if }}{{ if 1 == $scr_lang_f }} has_f{{ else }} has_not_f{{ /if }}{{ if 1 == $scr_lang_t }} has_t{{ else }} has_not_t{{ /if }}">
                                                        <span class="info-link">{{ $date_time_day_parts.time }}<span class="title-box top_label">
<!-- -->
                                                        <div>
                                                        <p>{{ $date_time_day_parts.time }}{{ if "" != $date_time_day_parts.lang }}&nbsp;{{ $date_time_day_parts.lang }}{{ /if }}{{ if "" != $date_time_day_parts.flag }}&nbsp;{{ $date_time_day_parts.flag }}{{ /if }}</p>
                                                        </div>
<!-- -->
                                                        </span></span>
                                                        </li>
                                                    {{ /foreach }}
                                        </ul>
                                    </td>
                            {{ /foreach }}
                            </tr>
                        </tbody>
                    </table>

            </div>

{{ /list_articles }}


{{*
                    <div class="movie-table">
                    
                        <ul>
                            <li><h5>Pathe Küchlin</h5></li>
                            <li>
                                <p>Steinvorstadt 55<br />
                                4051 Basel</p>
                                <p><a href="#">Google Maps</a><br />
                                <a href="#">www.pathekuchlin.ch</a></p>
                            </li>
                            <li>
                                <p>Tel  0900 0040 40 <a href="#" class="info">i</a></p>
                            </li>
                            <li>
                                <a href="#" class="grey-button">Ticket kaufen</a>
                            </li>
                        </ul>
                    
                        <table cellpadding="0" cellspacing="0">
                            <thead>
                                <tr>
                                    <td>Do<br />
                                    22.03</td>
                                    <td>Do<br />
                                    22.03</td>
                                    <td class="current">Do<br />
                                    22.03</td>
                                    <td>Do<br />
                                    22.03</td>
                                    <td>Do<br />
                                    22.03</td>
                                    <td>Do<br />
                                    22.03</td>
                                    <td>Do<br />
                                    22.03</td>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td></td>
                                    <td></td>
                                    <td class="current"></td>
                                    <td>11:15 <a href="#" class="info">i</a></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td></td>
                                    <td class="current">11:15 <a href="#" class="info">i</a></td>
                                    <td>13:40 <a href="#" class="info">i</a></td>
                                    <td></td>
                                    <td></td>
                                    <td>13:40 <a href="#" class="info">i</a></td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td></td>
                                    <td class="current"></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td></td>
                                    <td class="current"></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td></td>
                                    <td class="current"></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td></td>
                                    <td class="current"></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                </tr>
                            </tbody>
                        </table>
                    
                    </div>
                    
                    <div class="movie-table">
                    
                        <ul>
                            <li><h5>kult.kino atelier</h5></li>
                            <li>
                                <p>Theaterstrasse 7<br />
                                4051 Basel</p>
                                <p><a href="#">Google Maps</a><br />
                                <a href="#">www.kultkino.ch</a></p>
                            </li>
                            <li>
                                <p>Tel  0900 0040 40 <a href="#" class="info">i</a></p>
                            </li>
                            <li>
                                <a href="#" class="grey-button">Ticket kaufen</a>
                            </li>
                        </ul>
                    
                        <table cellpadding="0" cellspacing="0">
                            <thead>
                                <tr>
                                    <td>Do<br />
                                    22.03</td>
                                    <td>Do<br />
                                    22.03</td>
                                    <td class="current">Do<br />
                                    22.03</td>
                                    <td>Do<br />
                                    22.03</td>
                                    <td>Do<br />
                                    22.03</td>
                                    <td>Do<br />
                                    22.03</td>
                                    <td>Do<br />
                                    22.03</td>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td></td>
                                    <td></td>
                                    <td class="current"></td>
                                    <td>11:15 <a href="#" class="info">i</a></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td></td>
                                    <td class="current">11:15 <a href="#" class="info">i</a></td>
                                    <td>13:40 <a href="#" class="info">i</a></td>
                                    <td></td>
                                    <td></td>
                                    <td>13:40 <a href="#" class="info">i</a></td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td></td>
                                    <td class="current"></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td></td>
                                    <td class="current"></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td></td>
                                    <td class="current"></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td></td>
                                    <td class="current"></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                </tr>
                            </tbody>
                        </table>
                    
                    </div>
*}}

                </article>

            </section>

            <aside>

{{ local }}
{{ set_current_issue }}
{{ set_section number="72" }}
                <a href="{{ uri options="section" }}#/;type:kino;date:{{ $usedate_link }};region:{{ $region_link }}" class="grey-button back-button"><span>Zurück zur Kinoubersicht</span></a>
{{ /local }}

{{*
                <article>
                    <header>
                        <p>Verwandte Artikel</p>
                    </header>
                    <p><strong>Gericht im Senegal erlaubt Wades Kandidatur</strong> Senegals Verfassungsgericht bestätigt umstrittene Kondidatenliste <a href="#" class="more">Weiterlesen</a> <span class="time">23.01.2012</span></p>
                    <p><strong>RBS-Chef verzichtet nach Kritik auf Bonus</strong> Chef der Royal Bank of Scotland lehnt umstrittenen Bonus ab <a href="#" class="more">Weiterlesen</a> <span class="time">23.01.2012</span></p>
                    <p><strong>RBS-Chef verzichtet nach Kritik auf Bonus</strong> Chef der Royal Bank of Scotland lehnt umstrittenen Bonus ab <a href="#" class="more">Weiterlesen</a> <span class="time">23.01.2012</span></p>
                </article>
*}}

                <article>
                    <header>
                        <p><em>Werbung</em></p>
                    </header>
                    <span class="werbung">
<!-- BEGIN ADITIONTAG -->
<script type="text/javascript" src="http://imagesrv.adition.com/js/adition.js"></script>
<div id="adition_tag_460337"></div>
<!-- END ADITIONTAG -->
{{*
                        <img src="pictures/werbung-sidebar.jpg"  rel="resizable" alt="" />
*}}
                    </span>
                </article>

{{*
                <article>
                    <header>
                        <p>Verwandte Artikel</p>
                    </header>
                    <p><img src="pictures/restaurant-img-small-1.jpg" class="left" alt="" /><strong>Lorem Ipsum Dolor</strong> <em>Asiatisch, Modern</em> Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat <a href="#" class="more">Details &amp; Reservieren</a></p>
                    <p><img src="pictures/restaurant-img-small-1.jpg" class="left" alt="" /><strong>Lorem Ipsum Dolor</strong> <em>Asiatisch, Modern</em> Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat <a href="#" class="more">Details &amp; Reservieren</a></p>
                    <p><img src="pictures/restaurant-img-small-1.jpg" class="left" alt="" /><strong>Lorem Ipsum Dolor</strong> <em>Asiatisch, Modern</em> Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat <a href="#" class="more">Details &amp; Reservieren</a></p>
                </article>
*}}
            </aside>

        </div>
        
    </div><!-- / Wrapper -->

    <div id="footer">

{{ include file="_tpl/footer.tpl" }}

    </div><!-- / Footer -->

{{ include file="_tpl/_html-foot.tpl" }}
