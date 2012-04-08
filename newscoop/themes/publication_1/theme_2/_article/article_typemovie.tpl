{{ include file="_tpl/_html-head.tpl" }}

<style type="text/css">

.vimeo_trailer_block {
/*
    margin-left: 120px;
*/
    margin-left: 0px;
}

.article_backlinks {
    display: none;
}

.movie_info_key {
    color: #808080;
}

span span.title-box {
    position: absolute;
}

.movie_blog_snippet {
/*
    margin-top: 5px;
    margin-bottom: 5px;
*/
}

.movie_blog_link {
/*
    margin-top: 15px;
    margin-bottom: 5px;
*/
    float: left;
    margin-top: 20px;
}

.wrapper_part {
/*
    position:relative;
*/
}

.table_part {
/*
    position:absolute;
    top:100%;
*/
}

.map_part {
/*
    width: 100%;
*/
}

.image_hidden {
    display: none;
}

.movie_text_hidden {
    display: none;
}

.movie_img_list_hidden {
    display: none;
}

.cinemas_list_map_hidden {
    display: none;
}

.weniger_link {
/*
    font-size: 12px;
    margin-bottom:-20px;
    margin-bottom:20px;
    float: left;
    margin-left:20px;
*/
    float: right;
    margin-right:50px;
}
.cinema_name_list {
/*
    width: 180px;
*/
}
.cinema_screen_list {
    width: 60px;
}
.screen_time_list {
    text-align: center;
    padding: 0;
/*
    margin-left: auto;
    margin-right: auto;
*/
}
.no_movie_found {
    margin-left: 20px;
}
</style>

<script type="text/javascript">

window.set_image_lists = function()
{
    $("a.movie_image_list").fancybox({
        type: 'image'
    });
};

window.position_map = function() {
    $('#table_part_old').removeClass("movie_text_hidden");
    $('#table_part_old').insertBefore('#table_part_new');
};

$(document).ready(function() {
    //window.position_map();
    window.set_image_lists();
    window.set_title_boxes();
    $('#trailer_div').addClass("movie_text_hidden");
});

window.show_more_text = function(rank)
{
    var text_short = "#movie_short_text_" + rank;
    var text_full = "#movie_full_text_" + rank;

    $(text_short).addClass("movie_text_hidden");
    $(text_full).removeClass("movie_text_hidden");
};

window.show_less_text = function(rank)
{
    var text_short = "#movie_short_text_" + rank;
    var text_full = "#movie_full_text_" + rank;

    $(text_short).removeClass("movie_text_hidden");
    $(text_full).addClass("movie_text_hidden");
};

window.set_title_boxes = function() {
    $('.info-link').hover(
        function(){
            $(this).children().children('div').fadeIn(200);
        },
        function(){
            $(this).children().children('div').fadeOut(200);
        }
    );

    //last-child for MSIE
    if ( $.browser.msie ) {
        //$('span.title-box div').append('<div class="ietest"></div>');
        $('span.title-box').prev().hover(
            function(){
                $('.ietest').show();
            },

            function(){
                $('.ietest').hide();
            }
        );
    }
};

window.show_trailer = function(trailer_link) {

var embed_str = '';
embed_str += '<object classid="clsid:6BF52A52-394A-11D3-B153-00C04F79FAA6" id="WindowsMediaPlayer1" width="480" height="300">';
embed_str += ' <param name="URL" value="' + trailer_link + '" ref>';
embed_str += ' <param name="rate" value="1">';
embed_str += ' <param name="balance" value="0">';
embed_str += ' <param name="currentPosition" value="0">';
embed_str += ' <param name="defaultFrame" value>';
embed_str += ' <param name="playCount" value="1">';
embed_str += ' <param name="autoStart" value="1">';
embed_str += ' <param name="currentMarker" value="0">';
embed_str += ' <param name="invokeURLs" value="0">';
embed_str += ' <param name="baseURL" value>';
embed_str += ' <param name="volume" value="50">';
embed_str += ' <param name="mute" value="0">';
embed_str += ' <param name="uiMode" value="full">';
embed_str += ' <param name="stretchToFit" value="-1">';
embed_str += ' <param name="windowlessVideo" value="0">';
embed_str += ' <param name="enabled" value="-1">';
embed_str += ' <param name="enableContextMenu" value="-1">';
embed_str += ' <param name="fullScreen" value="0">';
embed_str += ' <param name="SAMIStyle" value>';
embed_str += ' <param name="SAMILang" value>';
embed_str += ' <param name="SAMIFilename" value>';
embed_str += ' <param name="captioningID" value>';
embed_str += ' <param name="enableErrorDialogs" value="0">';
embed_str += ' <param name="_cx" value="12315">';
embed_str += ' <param name="_cy" value="8210">';
embed_str += '<embed type="application/x-mplayer2" pluginspage="http://www.microsoft.com/Windows/MediaPlayer/" name="mediaplayer1" ShowStatusBar="true" EnableContextMenu="false" autostart="true" width="480" height="300" loop="false" src="' + trailer_link + '" /></object>';



    $('#trailer_div').html("<p>" + embed_str + "</p>");
    //$('#trailer_div').html("<p><embed src='" + trailer_link + "' AUTOPLAY=true WIDTH=480 HEIGHT=300 CONTROLLER=true LOOP=false PLUGINSPAGE='http://www.apple.com/quicktime/'></p>");
    //$('#trailer_div').html("<p><embed src='" + trailer_link + "' AUTOPLAY=false WIDTH=240 HEIGHT=165 CONTROLLER=true LOOP=false PLUGINSPAGE='http://www.apple.com/quicktime/'></p>");
    //$('#trailer_div').html("<p><embed src='" + trailer_link + "' AUTOPLAY=false CONTROLLER=true LOOP=false PLUGINSPAGE='http://www.apple.com/quicktime/'></p>");
    $('#trailer_div').removeClass("movie_text_hidden");
    $('#trailer_link').addClass("movie_text_hidden");
};
</script>


<body>

        <div id="wrapper">
        
{{ omnibox }}
        
        <div class="content-box top-content-fix clearfix article-page event-detail">
    
            <div class="top-werbung">
<!-- BEGIN ADITIONTAG -->
<script type="text/javascript" src="http://imagesrv.adition.com/js/adition.js"></script>
<div id="adition_tag_460331"></div>
<!-- END ADITIONTAG -->            
            </div><!-- /.top-werbung -->
    
{{ include file="_tpl/navigation_top.tpl" }}

<div id="main-nav" class="clearfix">

{{ include file="_tpl/navigation.tpl" }}

{{ include file="_tpl/search_box.tpl" }}
</div>  
                   
            <div class="wide-title">
                <header>
                    {{ include file="_tpl/article_title_tooltip_box.tpl" }}
                </header>
            </div>
                

{{ assign var="movie_rank" 0 }}

                <div id="article-front" class="article-content clearfix">
                <section>
                
                    <article>
                        <h2>{{ strip }}{{ $gimme->article->headline|strip_tags }}{{ /strip }}</h2>

                          {{ assign var="some_genre_info" 0 }}
                          {{ if "" != $gimme->article->genre }}
                              {{ assign var="some_genre_info" 1 }}
                          {{ /if }}
                          {{ if "" != $gimme->article->minimal_age }}
                              {{ assign var="some_genre_info" 1 }}
                          {{ /if }}
                          {{ if 0 != $some_genre_info }}
                          <p>
                              {{ if "" != $gimme->article->genre }}
                                  {{ $gimme->article->genre|replace:",":",&nbsp;" }}
                                  &nbsp;|&nbsp;
                              {{ /if }}
                              {{ if "" != $gimme->article->minimal_age }}
                                  ab {{ $gimme->article->minimal_age }} Jahre
                                  &nbsp;|&nbsp;
                              {{ /if }}
                              Sprache siehe Spielzeit
                          </p>
                          {{ /if }}


{{ assign var="some_images" value=0 }}
{{ if $gimme->article->has_image(1) }}
    {{ assign var="some_images" value=1 }}
{{ /if }}


{{* present the images if any *}}
{{ if $some_images eq 1 }}
<article>
<div class="loader" style="height: 152px">
                        <ul id="article-triple-carousel" class="article-triple-carousel jcarousel-skin-photoblog">
      {{ assign var="list_img_rank" 1 }}
      {{ while $gimme->article->has_image($list_img_rank) }}
          <li {{ if 1 lt $list_img_rank }}class="image_carousel image_hidden"{{ /if }}>
          <a href="{{ url options="image $list_img_rank" }}" class="movie_image_list" rel="movie_img_list_{{ $movie_rank }}" ><img src="{{ url options="image $list_img_rank width 170 height 113 crop center" }}" rel="" alt="" /></a>
          </li>
          {{ assign var="list_img_rank" $list_img_rank+1 }}
      {{ /while }}
                        </ul>
<div class="loading" style="height: 152px"></div>
</div>
</article>
{{ /if }}



{{ if $gimme->article->movie_trailer_vimeo eq "" }}
{{ if $gimme->article->movie_trailer ne "" }}
<article>
<div style="float:none;">
<p id="trailer_link_ext"><a href="{{ $gimme->article->movie_trailer }}" target="_blank">Trailer</a></p>
</div>
</article>
{{ /if }}
{{ /if }}

<article>
<div class="article-body">

{{ assign var="max_text_len" 250 }}


                          {{ assign var="movie_desc_len" $gimme->article->description|strip_tags|count_characters:true }}
                          {{ assign var="movie_other_len" $gimme->article->other|strip_tags|count_characters:true }}
                          {{ assign var="movie_text_len" $movie_desc_len+$movie_other_len }}

                          {{ if $movie_text_len <= $max_text_len }}
                            <p>{{ $gimme->article->description }}</p>
                            {{ assign var="film_other" $gimme->article->other|strip_tags }}
                            {{ if "" != $film_other }}
                              <p>{{ $gimme->article->other }}</p>
                            {{ /if }}
                          {{ else }}
                            <p id="movie_short_text_{{ $movie_rank }}">
                                {{ $gimme->article->description|strip_tags|truncate:$max_text_len:" [...]" }}
                                &raquo; <a href="#" onclick="window.show_more_text({{ $movie_rank }}); return false;">mehr</a>
                            </p>
                            <div id="movie_full_text_{{ $movie_rank }}" class="movie_text_hidden">
                                <p>{{ $gimme->article->description }}</p>
                                {{ assign var="film_other" $gimme->article->other|strip_tags }}
                                {{ if "" != $film_other }}
                                  <p>{{ $gimme->article->other }}</p>
                                {{ /if }}
                                <p><a class="weniger_link" href="#" onclick="window.show_less_text({{ $movie_rank }}); return false;">weniger</a></p>
                            </div>
                          {{ /if }}



</div>
</article>


{{* if 0 eq 1 *}}
{{ if $gimme->article->movie_trailer_vimeo ne "" }}
<article>
<div style="float:none;">

<script type="text/javascript">
window.make_fancy_trailer = function() {
    return;

    var vimeo_id = "32970344";
    var vimeo_width = "" + 640;
    var vimeo_height = "" + 344;

    var trailer_content = '';
    trailer_content += '<div id="vimeo_trailer_hidden" style="display:none">';
    trailer_content += '<a href="#vimeo_trailer" id="vimeo_trailer_link_inner">Trailer</a>';
    trailer_content += '</div>';
    trailer_content += '<div id="vimeo_trailer">';
    trailer_content += '<iframe src="http://player.vimeo.com/video/' + vimeo_id + '?title=0&amp;byline=0&amp;portrait=0" width="' + vimeo_width + '" height="' + vimeo_height + '" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen>';
    trailer_content += '</iframe>';
    trailer_content += '</div>';

    $("#vimeo_trailer_outer").html("&nbsp;");
    $("#vimeo_trailer_outer").html(trailer_content);

    $("#vimeo_trailer_link_inner").fancybox();
    $("#vimeo_trailer_link_inner").trigger('click');
};
</script>
<!--
<p><a href="#" id="vimeo_trailer_link" onClick="window.make_fancy_trailer(); return false;">Vimeo Test</a></p>
<div style="display:none;" id="vimeo_trailer_outer">&nbsp;
</div>--><!-- vimeo_trailer_outer -->

{{ assign var="vimeo_id" value=$gimme->article->movie_trailer_vimeo }}
{{ assign var="vimeo_width_orig" value=$gimme->article->movie_trailer_width }}
{{ assign var="vimeo_width_orig" value=0+$vimeo_width_orig }}
{{ assign var="vimeo_height_orig" value=$gimme->article->movie_trailer_height }}
{{ assign var="vimeo_height_orig" value=0+$vimeo_height_orig }}

{{ assign var="vimeo_width_show" value="640" }}
{{ assign var="vimeo_height_show" value="344" }}
{{ if $vimeo_width_orig gt 0 }}
    {{ if $vimeo_height_orig gt 0 }}
        {{ assign var="vimeo_height_show" value=$vimeo_width_show * $vimeo_height_orig / $vimeo_width_orig }}
    {{ /if }}
{{ /if }}

<div id="vimeo_trailer" class="vimeo_trailer_block">
<iframe src="http://player.vimeo.com/video/{{ $vimeo_id }}?title=0&amp;byline=0&amp;portrait=0" width="{{ $vimeo_width_show }}" height="{{ $vimeo_height_show }}" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen>
</iframe>
</div>

</div>
</article>
{{ /if }}
{{* /if *}}


{{ php }}

function parse_date_text($date_time_text)
{
    $dates = array();

    $cur_date = null;

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

        $dates[$cur_date][] = array('time' => $time_str, 'lang' => $lang_str, 'flag' => $flag_str);

    }

    ksort($dates);
    return $dates;
}

{{ /php }}


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
    {{ assign var="contopic_region" "topic is $useregion$topic_suffix"}}
{{ /if }}

<div>

                        <header>
<p>
{{ if !empty($useregion) }}
{{ $useregion|replace:"\\":"" }}
{{ else }}
Schweiz
{{ /if }}
</p>
                        </header>
</div>
<div id="wrapper_part" class="wrapper_part_not">
<div id="table_part_old" class="table_part_old movie_text_hidden_not">

                    <div id="event_movies_results" class="event-movies-results">
{{ assign var="art_list_map" 0 }}
{{ assign var="art_list_map_count" "" }}
{{ list_articles ignore_issue="true" ignore_section="true" constraints="$contopic_region $art_constraints section is 72 type is screening " order="byname asc" }}
                      <article>

    {{ assign var="art_number" $gimme->article->number }}
    {{ assign var="art_list" "$art_list$art_list_sep$art_number" }}

    {{ if $gimme->article->has_map }}
        {{ assign var="art_list_map" "$art_list_map$art_list_sep$art_number" }}
        {{ assign var="art_list_map_count" $art_list_map_count+1 }}
    {{ /if }}


    {{ assign var="date_time_str" $gimme->article->date_time_text|replace:"&nbsp;":" " }}
    {{ php }}
        $date_time_str = $template->get_template_vars('date_time_str');
        $date_time_arr = parse_date_text($date_time_str);
        $template->assign('date_time_arr',$date_time_arr);
    {{ /php }}

            <table cellpadding="0" cellspacing="0">
                <thead>
                    <tr>
                        <th class="cinema_name_list"><h3>{{ $gimme->article->organizer }}</h3></th>
                        {{ foreach from=$date_time_arr key=date_time_key item=date_time_day }}
                            <td class="cinema_screen_list">{{ $date_time_key|camp_date_format:"%W"|truncate:2:'' }} <span>{{ $date_time_key|camp_date_format:"%e.%m" }}</span></td>
                        {{ /foreach }}
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <th>
                            <dl>
                                <dt>
                                    {{ if  "" != $gimme->article->web }}
                                        <a href="{{ $gimme->article->web }}" target="_blank" >Zur Website</a><br />
                                    {{ else }}
                                        &nbsp;
                                    {{ /if }}
                                    <div id="cinemas_list_map_{{ $movie_rank }}" class="cinemas_list_map_hidden">
                                        <a id="cinemas_list_map_lnk_{{ $movie_rank }}" href="#" rel="cinemas_list_map_group_{{ $movie_rank }}">Karte</a>
                                    </div>
                                    <br />
                                    {{ if  "" != $gimme->article->phone }}
                                        Tel: {{ $gimme->article->phone }}
                                    {{ else }}
                                        &nbsp;
                                    {{ /if }}
                                </dt>
                                <dd>
                                    {{ $gimme->article->street }}<br />
                                    {{ $gimme->article->zipcode }} {{ $gimme->article->town }}<br />
                                </dd>
                            </dl>
                        </th>
                        {{ foreach from=$date_time_arr key=date_time_key item=date_time_day }}
                                        <td class="screen_time_list">
                                            <ul>
                                                {{ foreach from=$date_time_day item=date_time_day_parts }}
                                                    <li><span class="info-link">{{ $date_time_day_parts.time }}<span class="title-box top_label">
                                                    <div>
                                                    <p>{{ $date_time_day_parts.time }}{{ if "" != $date_time_day_parts.lang }}&nbsp;{{ $date_time_day_parts.lang }}{{ /if }}{{ if "" != $date_time_day_parts.flag }}&nbsp;{{ $date_time_day_parts.flag }}{{ /if }}</p>
                                                    </div>
                                                    </span></span>
                                                    </li>
                                                {{ /foreach }}
                                            </ul>
                                        </td>
                        {{ /foreach }}
                    </tr>
                </tbody>
            </table>

                    </article>

{{ /list_articles }}

            </div><!-- event_movies_results -->
</div><!-- table_part_old -->

<div id="map_part" class="map_part">


</div><!-- map_part -->

<div id="table_part_new" class="table_part_new">
</div><!-- table_part_new -->

</div><!-- wrapper_part -->

                    
{{ include file="_tpl/article_social_box.tpl" }}                  
                    
{{* LINKS TO FRONT AND SECTION PAGE *}} 
                     <article class="more-info">
                        <header>                   
                            <p>Mehr entdecken auf TagesWoche.ch</p>
                        </header>
                        <ul class="details">
                            {{ local }}
                            {{ set_publication identifier="1" }}
                            {{ set_current_issue }}
                            <li><a href="{{ url options="issue" }}">Zur Startseite</a></li>
                            <li><a href="{{ url options="section" }}">Zur Kinoübersicht</a></li>
                            {{ /local }}
                        </ul>
                    </article>                      
                    
{{ include file="_tpl/article_most_popular.tpl" }} 

                </section>

{{* SIDEBAR INFO *}}
                
                <aside>
                    
                
                    <article class="event-info">
<ul class="simple-list">
{{ if $gimme->article->movie_director ne "" }}
<li><span class="movie_info_key">Regie:</span> {{ $gimme->article->movie_director|replace:",":", " }}</li>
{{ /if }}
{{ if $gimme->article->movie_cast ne "" }}
<li><span class="movie_info_key">Schauspieler:</span> {{ $gimme->article->movie_cast|replace:",":", " }}</li>
{{ /if }}
{{ if $gimme->article->movie_year ne "" }}
{{ if $gimme->article->movie_year ne "0" }}
{{ if $gimme->article->movie_year ne 0 }}
<li><span class="movie_info_key">Jahr:</span> {{ $gimme->article->movie_year }}</li>
{{ /if }}
{{ /if }}
{{ /if }}
{{ if $gimme->article->movie_country ne "" }}
<li><span class="movie_info_key">Land:</span> {{ $gimme->article->movie_country }}</li>
{{ /if }}
{{ if $gimme->article->movie_duration ne "" }}
{{ if $gimme->article->movie_duration ne "0" }}
{{ if $gimme->article->movie_duration ne 0 }}
<li><span class="movie_info_key">Dauer:</span> {{ $gimme->article->movie_duration }} min.</li>
{{ /if }}
{{ /if }}
{{ /if }}
{{ if $gimme->article->movie_suisa ne "" }}
{{ if $gimme->article->movie_suisa ne "0" }}
{{ if $gimme->article->movie_suisa ne 0 }}
<li><span class="movie_info_key">Suisa-Nr:</span> {{ $gimme->article->movie_suisa }}</li>
{{ /if }}
{{ /if }}
{{ /if }}
{{ if $gimme->article->movie_imdb ne "" }}
{{ if $gimme->article->movie_imdb ne "0" }}
{{ if $gimme->article->movie_imdb ne 0 }}
{{ if 0 eq 1 }}
<li><span class="movie_info_key">IMDb:</span> <a href="http://www.imdb.com/title/tt{{ $gimme->article->movie_imdb }}" target="_blank">{{ $gimme->article->movie_imdb }}</a></li>
{{ /if }}
{{ /if }}
{{ /if }}
{{ /if }}
{{* we should take publisher, not producers *}}
{{ if $gimme->article->movie_producer ne "" }}
{{ if 0 eq 1 }}
<li><span class="movie_info_key">Produzent(en):</span> {{ $gimme->article->movie_producer|replace:",":", " }}</li>
{{ /if }}
{{ /if }}
{{ if $gimme->article->movie_distributor ne "" }}
<li><span class="movie_info_key">Verleih:</span> {{ $gimme->article->movie_distributor }}</li>
{{ /if }}
</ul>
                    </article>


{{* MAP - display only if set *}}
{{ if 0 lt $art_list_map_count }}
                    <article class="location-info">
<header>
                        <p class="small-box-title">Karte</p>
</header>
                        <figure>

{{ set_map
    label="movie screenings"
    articles="$art_list_map"
    max_points=1000
}}

{{ map show_locations_list=true show_reset_link=false show_open_link=false open_map_on_click=false popup_width="1000" popup_height="750" max_zoom=16 area_show="focus_empty" show_locations_list="false" width="100%" height="300" }}

                        </figure>
                    </article>
{{ /if }}

                    <article>
<header>
    <p>Lichtspiele - der TagesWoche Filmblog</p>
</header>

{{ assign var="blog_rank" 0 }}
{{ list_articles length="3" ignore_publication="true" ignore_issue="true" ignore_section="true" order="byLastUpdate desc" constraints="type is blog issue is 3 section is 42" }}
    {{ if $gimme->current_list->at_beginning }}
    <ul class="simple-list">
    {{ /if }}
    {{ assign var="blog_rank" $blog_rank+1 }}
    <li class="movie_blog_snippet"><a href="http://{{ $gimme->publication->site }}{{ uri options="article" }}">{{ $gimme->article->title }}</a></li>
    {{ if $gimme->current_list->at_end }}
    </ul>
    <footer>
    <a class="movie_blog_link" href="http://{{ $gimme->publication->site }}{{ uri options="section" }}">Zum Filmblog</a>
    </footer>
    {{ /if }}
{{ /list_articles }}

                    </article>

                    <article class="content-werbung">
                        <header>
                            <p>Werbung</p>
                        </header>
                        <span class="werbung">
<!-- BEGIN ADITIONTAG -->
<script type="text/javascript" src="http://imagesrv.adition.com/js/adition.js"></script>
<div id="adition_tag_460337"></div>
<!-- END ADITIONTAG -->
                        </span>
                    </article>

                </aside>
                
            </div><!-- / Front article side -->
       
        </div>

{{* FOOTER *}}
{{ include file="_tpl/footer.tpl" }}

    </div><!-- / Wrapper -->   

{{* JAVASCRIPT FOOTER *}}
{{ include file="_tpl/_footer_javascript.tpl" }}
<link rel="stylesheet" href="{{ $view->baseUrl('js/jquery/fancybox/jquery.fancybox-1.3.4.css') }}" type="text/css" media="screen" />

</body>
</html>
