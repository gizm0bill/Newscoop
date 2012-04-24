{{ include file="_tpl/_html-head.tpl" }}

<style type="text/css">

#wann {
    width: 120px !important;
}

.loading_block_events {
    margin-top: 25px;
    margin-bottom: 100px;
    background: none repeat scroll 0 0 #F5F5F5;
}
.loading_image_events {
/*
    float: left;
*/
    margin-left: 25px;
}
.loading_text_events {
/*
    float: left;
*/
    margin-top: -35px;
    margin-bottom: 150px;
    margin-left: 100px;
}

.option_styled {
    background: none repeat scroll 0 0 #FFFFFF;
    border: 1px solid #A5A5A5;
    float: left;
    font-family: Arial,Helvetica,sans-serif;
    font-size: 11px;
    height: 18px;
    line-height: 16px;
/*
    line-height: 16px;
    margin-left: 4px;
    padding: 1px 6px;
*/
    padding: 1px 1px 2px 4px;
    width: 120px;
    /*width: 70px;*/
}

.text_hidden {
    display: none;
}

</style>


<script type="text/javascript">
/* German initialisation for the jQuery UI date picker plugin. */
/* Written by Milian Wolff (mail@milianw.de). */
jQuery(function($){
  $.datepicker.regional['de'] = {
    closeText: 'schließen',
    prevText: '&#x3c;zurück',
    nextText: 'Vor&#x3e;',
    currentText: 'heute',
    monthNames: ['Januar','Februar','März','April','Mai','Juni',
    'Juli','August','September','Oktober','November','Dezember'],
    monthNamesShort: ['Jan','Feb','Mär','Apr','Mai','Jun',
    'Jul','Aug','Sep','Okt','Nov','Dez'],
    dayNames: ['Sonntag','Montag','Dienstag','Mittwoch','Donnerstag','Freitag','Samstag'],
    dayNamesShort: ['So','Mo','Di','Mi','Do','Fr','Sa'],
    dayNamesMin: ['So','Mo','Di','Mi','Do','Fr','Sa'],
    weekHeader: 'Wo',
    dateFormat: 'dd.mm.yy',
    firstDay: 1,
    isRTL: false,
    showMonthAfterYear: false,
    yearSuffix: ''};
  $.datepicker.setDefaults($.datepicker.regional['de']);
});

window.list_spec = {
    date: '',
    region: ''
};

window.update_list_on_params = function(params) {
    var differ = false;
    var newpage = 0;

    var new_spec = {
        date: window.used_date('', true),
        region: 'kanton-basel-stadt'
    };

    var params_array = params.split(";");
    var params_count = params_array.length;
    for (var pind = 0; pind < params_count; pind++) {
        var one_param = params_array[pind];
        one_param = one_param.replace(/^\s+|\s+$/g, "");
        var one_values_array = one_param.split(":");
        var one_values_count = one_values_array.length;
        if (2 != one_values_count) {
            continue;
        }
        var one_key = one_values_array[0];
        if (one_key in window.list_spec) {
            new_spec[one_key] = one_values_array[1];
        }
    }

    for (var pkey in new_spec) {
        if (new_spec[pkey] != window.list_spec[pkey]) {
            differ = true;
        }
    }

    if (!differ) {
        return;
    }

    if ('' != new_spec['region']) {
        $("#wo").val(new_spec['region']);
    }

    if ('' != new_spec['date']) {
        $(".datepicker").datepicker("setDate" , new Date(new_spec['date']));
    }

    window.reload(new_spec['page']);
};

$(document).ready(function() {
    $.address.change(function(event) {
        window.update_list_on_params($.address.value());
    });
    //$("#was").val('alles');
    //$("#was").val('theater');
    $("#wo").val('region-basel');

  // Datepicker
  var dp = $( ".datepicker" ).datepicker({
    showOn: "button",
    buttonImage: "{{ uri static_file="_css/tw2011/img/calendar.png" }}",
    buttonImageOnly: true
  });

    $("#wann").attr('disabled', true);

    $(".datepicker").datepicker("setDate" , new Date());
    $('#ui-datepicker-div').css('display','none'); // see http://stackoverflow.com/questions/5735888/updating-to-latest-jquery-ui-and-datepicker-is-causing-the-datepicker-to-always-b

    $("#wann").change( function() {
        window.reload();
    });

});

/*
function outline_type(ev_type) {
//alert(ev_type);

    window.what_val = ev_type;
    //$('.li_genre').removeClass('active');
    //$('#li_' + genre).addClass('active');
    $(".nav_one").removeClass("active");
    $("#nav_" + ev_type).addClass("active");

};
*/

function load_area(area) {
    window.reload();

    //var area_obj = $(area);
    //alert("not implemented: " + area_obj.val());
    return false;
};
</script>

<body>

  <div id="wrapper">
      
{{ include file="_tpl/header-omnibox.tpl" }}

{{ include file="_tpl/header.tpl" }}
        
{{ include file="_ausgehen/subnav.tpl" }}

        {{*<div class="content-box clearfix reverse-columns agenda-content movies-list">*}}
        <div class="content-box clearfix reverse-columns agenda-content">

            <aside>

                <ul id="datepicker_single_ul" style="display:none">
                            <li>
                              <label for="wann">Wann</label>
                                <input type="text" value="" id="wann" class="datepicker" style="width:80px;" />
                            </li>
                </ul>

                <h3>Ort</h3>
                <ul>
                    <li>
                        <select id="wo" name="region" class="omit_dropdown option_styled" onChange="load_area(this); return true;">
                                    <option value="region-basel">Region Basel</option>
                                    <option value="kanton-basel-stadt" selected>Basel-Stadt</option>
                                    <option value="kanton-basel-landschaft">Basel-Landschaft</option>
                                    <option value="kanton-aargau">Aargau</option>
                                    <option value="kanton-appenzell-ausserrhoden">Appenzell Ausserrhoden</option>
                                    <option value="kanton-appenzell-innerrhoden">Appenzell Innerrhoden</option>
                                    <option value="kanton-bern">Bern</option>
                                    <option value="kanton-freiburg">Freiburg</option>
                                    <option value="kanton-genf">Genf</option>
                                    <option value="kanton-glarus">Glarus</option>
                                    <option value="kanton-graubuenden">Graubünden</option>
                                    <option value="kanton-jura">Jura</option>
                                    <option value="kanton-luzern">Luzern</option>
                                    <option value="kanton-neuenburg">Neuenburg</option>
                                    <option value="kanton-nidwalden">Nidwalden</option>
                                    <option value="kanton-obwalden">Obwalden</option>
                                    <option value="kanton-schaffhausen">Schaffhausen</option>
                                    <option value="kanton-schwyz">Schwyz</option>
                                    <option value="kanton-solothurn">Solothurn</option>
                                    <option value="kanton-st-gallen">St. Gallen</option>
                                    <option value="kanton-tessin">Tessin</option>
                                    <option value="kanton-thurgau">Thurgau</option>
                                    <option value="kanton-uri">Uri</option>
                                    <option value="kanton-waadt">Waadt</option>
                                    <option value="kanton-wallis">Wallis</option>
                                    <option value="kanton-zug">Zug</option>
                                    <option value="kanton-zuerich">Zürich</option>
                        </select>
                    </li>
                </ul>

                <h3>Presenting Partner</h3>
                <ul class="partner-list">
                    <li><a href="#"><img src="{{ uri static_file="_ausgehen/pictures/partner-logo-small-1.jpg" }}" alt="" /></a></li>
                    <li><a href="#"><img src="{{ uri static_file="_ausgehen/pictures/partner-logo-small-2.jpg" }}" alt="" /></a></li>
                    <li><a href="#"><img src="{{ uri static_file="_ausgehen/pictures/partner-logo-small-3.jpg" }}" alt="" /></a></li>
                </ul>

                <p><a href="mailto:agenda@tageswoche.ch">Melden Sie Ihre Veranstaltung!</a></p>

            </aside>

            <section>

{{ assign var="load_list" 0 }}
{{ if !empty($smarty.get.load) }}
    {{ if 1 eq $smarty.get.load }}
        {{ assign var="load_list" 1 }}
    {{ /if }}
{{ /if }}

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

{{ assign var="condate" ""}}
{{ assign var="muldate" ""}}
{{ if !empty($usedate) }}
    {{ assign var="condate" "date is $usedate"}}
    {{ assign var="muldate" "start_date: $usedate, end_date: $usedate"}}
{{ /if }}

{{ assign var="useregion" "Kanton\\ Basel-Stadt" }}
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

{{ assign var="contopic_type" ""}}
{{ assign var="contopic_region" ""}}
{{ assign var="topic_suffix" ":de"}}

{{ if !empty($usetype) }}
    {{ assign var="contopic_type" "topic is $usetype$topic_suffix"}}
{{ /if }}

{{ if !empty($useregion) }}
    {{ assign var="contopic_region" "topic is $useregion$topic_suffix"}}
{{ /if }}


                    <div id="event_agenda_results" class="event-agenda-results">

{{ assign var="map_article_list" "" }}
{{ assign var="map_article_list_sep" "," }}
{{ assign var="movie_rank" 0 }}
{{ assign var="max_text_len" 250 }}
{{ assign var="lastmovname" "" }}

{{ if 1 eq $load_list }}

                <h2>Kino</h2>

{{ assign var=today_date "2011-11-01" }}
{{ assign var=today_date $smarty.now|date_format:"%Y-%m-%d" }}
{{ assign var=condate "" }}
{{ assign var=condate_real "publish_date is $today_date" }}
{{* list_articles columns="$colcount" ignore_issue="true" ignore_section="true" constraints="$condate $contopic_region $contopic_type section is 72 type is screening matchalltopics " order="byname asc" length=5 *}}
{{* list_articles columns="$colcount" ignore_issue="true" ignore_section="true" constraints="$condate $contopic_region $contopic_type section is 72 type is screening matchalltopics " order="byname asc" length=5 *}}
{{ list_articles columns="$colcount" ignore_issue="true" ignore_section="true" constraints=" $contopic_region section is 72 type is screening matchalltopics " order="bycustom.num.movie_rating_wv.0 desc byname asc" movie_screening="$muldate" }}
    {{ if $lastmovname != $gimme->article->headline }}
        {{ if "" != $lastmovname }}
                      </article>
        {{ /if }}
        {{ assign var="movie_rank" $movie_rank+1 }}
        {{ if 4 > $movie_rank }}

                      <article id="movie_{{ $movie_rank }}" class="movie {{* stared *}} movie_lang has_not_d has_not_k has_not_f has_not_t">
                          <h3><a href="{{ uri options="article" }}?region={{ $linkregion }}">{{ $gimme->article->headline }}</a> {{ if $recommended }}<small class="tw_recommended"></small>{{ /if }}</h3>
                            <ul class="top-list-details">
                                {{ assign var="movie_rating_wv" $gimme->article->movie_rating_wv }}
                                {{ if $movie_rating_wv ne "" }}
                                    {{ assign var="movie_rating_wv" 0+$movie_rating_wv }}
                                    {{ if $movie_rating_wv ne 0 }}
                                        <li><span>Bewertung:</span> <ul class="rating"><li{{ if $movie_rating_wv > 0 }} class="on"{{ /if }}>1</li><li{{ if $movie_rating_wv > 1 }} class="on"{{ /if }}>2</li><li{{ if $movie_rating_wv > 2 }} class="on"{{ /if }}>3</li><li{{ if $movie_rating_wv > 3 }} class="on"{{ /if }}>4</li><li{{ if $movie_rating_wv > 4 }} class="on"{{ /if }}>5</li></ul> <em>{{ $movie_rating_wv }}</em></li>
                                    {{ /if }}
                                {{ /if }}
                            </ul>
        {{ /if }}
    {{ /if }}
    {{ assign var="lastmovname" $gimme->article->headline }}
        {{ if 4 > $movie_rank }}

                        <li><h5>{{ $gimme->article->organizer }}</h5></li>
        {{ /if }}
{{ /list_articles }}

{{ if $movie_rank eq 0 }}
    <div class="no_movie_found">Ihre Suche ergab keine Treffer</div>
{{ /if }}

{{ local }}
{{ set_current_issue }}
{{ set_section number="72" }}
                <a href="{{ uri options="section" }}#/;type:kino;date:{{ $usedate_link }};region:{{ $linkregion }}" class="grey-button more-arrow"><span>Mehr Filme</span></a>
{{ /local }}

                <h2>Theater</h2>

{{ assign var="colcount" 3 }}
{{ assign var="event_rank" 0 }}

{{ assign var="usetype" "Theater\\ Veranstaltung" }}
{{ assign var="topic_suffix" ":de"}}
{{ assign var="contopic_type" "topic is $usetype$topic_suffix"}}
{{ list_articles columns="$colcount" ignore_issue="true" ignore_section="true" constraints="$contopic_region $contopic_type section is 71 type is event matchalltopics " length="$colcount" schedule="$muldate"}}
    <article class="{{ if $gimme->article->recommended }} stared{{ /if }}">
        {{ assign var="event_rank" $event_rank+1 }}
        {{ if $gimme->article->has_image(1) }}
            {{ if 250 < $gimme->article->image1->width }}
                <img src="{{ url options="image 1 width 250" }}" alt="{{ $gimme->article->image1->description|replace:'"':'\'' }}" />
            {{ else }}
                <img src="{{ url options="image 1 " }}" alt="{{ $gimme->article->image1->description|replace:'"':'\'' }}" />
            {{ /if }}
        {{ /if }}
        <h3><a href="{{ uri options="article" }}?date={{$usedate}}">{{ $gimme->article->headline|replace:'\\':'\'' }}</a></h3>
        {{ if $gimme->article->genre }}<h6>{{ $gimme->article->genre }}</h6>{{ /if }}
        <p>
        {{ $gimme->article->description|truncate:300 }}
        <a href="{{ uri options="article" }}?date={{$usedate}}">Details</a>
        </p>
    </article>
{{ /list_articles }}

{{ if $event_rank eq 0 }}
    <div class="no_movie_found">Ihre Suche ergab keine Treffer</div>
{{ /if }}

{{* here the tw staff event *}}
{{ list_articles ignore_issue="true" constraints="type is news print is off" length=1 }}
            <article class="featured">
                <header>
                    <p><a href="{{ uri options="article" }}">TagesWoche empfielt</a></p>
                </header>
                {{ if $gimme->article->has_image(1) }}
                    {{ if 250 < $gimme->article->image1->width }}
                        <img src="{{ url options="image 1 width 250" }}" alt="{{ $gimme->article->image1->description|replace:'"':'\'' }}" />
                    {{ else }}
                        <img src="{{ url options="image 1 " }}" alt="{{ $gimme->article->image1->description|replace:'"':'\'' }}" />
                    {{ /if }}
                {{ /if }}
                <h3><a href="{{ uri options="article" }}">{{ $gimme->article->name|replace:'  ':'<br />' }}</a></h3>
                <h6>{{ $gimme->article->lede }}</h6>
                <p>{{ $gimme->article->body|strip_tags|truncate:300 }}
                <a href="{{ uri options="article" }}">Details</a>
                </p>
            </article>
{{ /list_articles }}

{{ local }}
{{ set_current_issue }}
{{ set_section number="71" }}
                <a href="{{ uri options="section" }}#/;type:theater;date:{{ $usedate_link }};region:{{ $linkregion }};page:1" class="grey-button more-arrow"><span>Mehr Theater</span></a>
{{ /local }}

{{ else }}
<figure class="loading_block_agenda">
  <div class="loading_image_agenda">
    <img src="{{ uri static_file='_css/tw2011/img/loading_big.gif' }}">
  </div>
  <div class="loading_text_agenda">
    Das aktuelle Programm wird geladen.
  </div>
</figure>
{{ /if }}


            </section>

<script type="text/javascript">
window.used_date = function(separator, value_only) {
    var when = "" + $("#wann").val();
    when = escape(when.replace(/^\s+|\s+$/g, ""));

    var evdate = "";
    var evdateobj = null;
    var evdate_day = "";
    var evdate_month = "";
    var evdate_year = "";

    if ("" != when) {
        if (!evdateobj) {
            evdateobj = $(".datepicker").datepicker("getDate");
        }
    }
    if (!evdateobj) {
        evdateobj = new Date();
    }
    var has_get_date = false;
    if ('getDate' in evdateobj) {
        has_get_date = true;
    }
    if (!has_get_date) {
        evdateobj = new Date();
    }

    evdate_day = evdateobj.getDate();
    if (10 > evdate_day) {
        evdate_day = "0" + evdate_day;
    }
    evdate_month = evdateobj.getMonth() + 1;
    if (10 > evdate_month) {
        evdate_month = "0" + evdate_month;
    }
    evdate_year = evdateobj.getFullYear();

    $(".datepicker").datepicker("setDate" , evdateobj);

    var date_value = evdate_year + "-" + evdate_month + "-" + evdate_day;
    if (value_only) {
        return date_value;
    }

    return separator + "date=" + date_value;
};

window.used_place = function(separator, value_only) {
    var where = "" + $("#wo").val();
    where = escape(where.replace(/^\s+|\s+$/g, ""));

    var spec = "";

    if ("" == where) {
        where = "kanton-basel-stadt";
        //return "";
    }


    if (value_only) {
        return where;
    }

    spec = separator + "region=" + where;

    return spec;
};

window.set_list_content = function(data, direct) {
    if (direct) {
        $('#event_agenda_results').html(data);
        //$('#newslist').html(data);
        //$('#newslist_pagination').html('&nbsp;');
        return;
    }

    var dom = $(data);
    $('#event_agenda_results').html($('#event_agenda_results', dom).html());
    //$('#newslist').html($('#newslist', dom).html());
    //$('#newslist_pagination').html($('#newslist_pagination', dom).html());

    //window.set_cufon_fonts();
    //Cufon.now();
};

window.get_basic_path = function() {
    return "{{ local }}{{ set_section number="70" }}{{ uri options="section" }}{{ /local }}" + "?load=1";
};

//window.what_val = 'alles';
//window.what_val = 'theater';

window.reload = function(page) {
    if (undefined === page) {
        page = 1;
    }
    page = parseInt(page);


    var path = window.get_basic_path();
    var path_spec = "";
    var separator = "&";

    //var what = "" + $("#was").val();
    //var what = window.what_val;
    //what = escape(what.replace(/^\s+|\s+$/g, ""));

    //var what_val = "alles";
    //var what_val = "theater";
    //if (("" != what) && ("undefined" != what)) {
    //    path += separator + "type=" + what;
    //    path_spec += separator + "type=" + what;
    //    what_val = what;
    //}

    var evdate = window.used_date(separator);
    if ("" != evdate) {
        path += evdate;
        path_spec += evdate;
    }
    var when_val = window.used_date('', true);

    var evplace = window.used_place(separator);
    if ("" != evplace) {
        path += evplace;
        path_spec += evplace;
    }
    var where_val = window.used_place('', true);

    window.last_search = path;

    if ("" != path_spec) {
        path_spec = path_spec.replace(/&/g, ";");
        path_spec = path_spec.replace(/=/g, ":");
    }

    window.last_search_spec = path_spec;

    $('#suchen').attr("disabled", true);
    $('#suchen').addClass('ui-state-disabled');

    content_loading();

    $.get(path, {}, function (data, textStatus, jqXHR) {
        window.list_spec['date'] = when_val;
        window.list_spec['region'] = where_val;

        $.address.value(path_spec);
        window.set_list_content(data);
        $('#suchen').attr("disabled", false);
        $('#suchen').removeClass('ui-state-disabled');
    });
};

function content_loading() {
//return;
    ini_data = "";
    ini_data += '<figure class="loading_block_events">' + "\n";
    ini_data += '  <div class="loading_image_events">' + "\n";
    ini_data += '    <img src="{{ uri static_file='_css/tw2011/img/loading_big.gif' }}">' + "\n";
    ini_data += '  </div>' + "\n";
    ini_data += '  <div class="loading_text_events">' + "\n";
    ini_data += '    Das aktuelle Programm wird geladen.' + "\n";
    ini_data += '  </div>' + "\n";
    ini_data += '</figure>' + "\n";
    ini_data += '<div id="page_list_name" class="text_hidden">{{ $list_name }}</div>';

    window.set_list_content(ini_data, true);
};

window.last_search = window.get_basic_path();
window.last_search_spec = "";

$(document).ready(function() {
    $( "#suchen" ).click(function() {
        window.reload();
    });

    $("#date_picker_button_new").hide();
    $("#top-calendar").hide();

    $("#datepicker_single_ul").show();
});

function load_events(ev_type) {
    //window.what_val = ev_type;
    //outline_type(ev_type);
    //window.reload();
    //return false;
    return true;
};
</script>


        </div>

    <div id="footer">

{{ include file="_tpl/footer.tpl" }}

    </div><!-- / Footer -->

{{ include file="_tpl/_html-foot.tpl" }}

    </div><!-- / Wrapper -->   

{{* JAVASCRIPT FOOTER *}}
{{* include file="_tpl/_footer_javascript.tpl" *}}
<link rel="stylesheet" href="{{ $view->baseUrl('js/jquery/fancybox/jquery.fancybox-1.3.4.css') }}" type="text/css" media="screen" />
<script type="text/javascript" src="{{ uri static_file='_js/libs/jquery.address.js' }}"></script>
<script type="text/javascript" src="{{ uri static_file='_js/libs/fancybox/jquery.fancybox-1.3.4.pack.js' }}"></script>

</body>
</html>
