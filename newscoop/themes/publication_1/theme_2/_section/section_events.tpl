{{ include file="_tpl/_html-head.tpl" }}

<style type="text/css">

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
    type: '',
    date: '',
    region: '',
    page: 0
};

window.update_list_on_params = function(params) {
    var differ = false;
    var newpage = 0;

    var new_spec = {
        type: 'alles',
        date: window.used_date('', true),
        region: 'kanton-basel-stadt',
        page: 1
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
            if ("page" != pkey) {
                differ = true;
            } else {
                newpage = parseInt(new_spec[pkey]);
            }
        }
    }

    if ((0 != newpage) && (!differ)) {
        window.paginate(newpage - 1);
        return;
    }

    if (!differ) {
        return;
    }

    if ('' != new_spec['type']) {
        $("#was").val(new_spec['type']);
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
    $("#was").val('alles');
    $("#wo").val('region-basel');

  // Datepicker
  var dp = $( ".datepicker" ).datepicker({
    showOn: "button",
    buttonImage: "{{ uri static_file="_css/tw2011/img/calendar.png" }}",
    buttonImageOnly: true
  });

    $(".datepicker").datepicker("setDate" , new Date());
    $('#ui-datepicker-div').css('display','none'); // see http://stackoverflow.com/questions/5735888/updating-to-latest-jquery-ui-and-datepicker-is-causing-the-datepicker-to-always-b
});
</script>


{{ php }}

function get_time_text($multi_time_text, $req_date)
{
    $req_date = trim($req_date);
    if (empty($req_date)) {
        return '';
    }

    $time = array();

    $cur_date = null;

    $multi_time_text = strip_tags(str_replace(array('<'), array("\n<"), $multi_time_text));
    foreach (explode("\n", $multi_time_text) as $one_date_time_str) {
        $one_date_time_str = trim($one_date_time_str);
        if (empty($one_date_time_str)) {
            continue;
        }

        $matches = array();
        if (preg_match('/^(\d{4})-(\d{2})-(\d{2})$/', $one_date_time_str, $matches)) {
            // new date
            $cur_date = $one_date_time_str;

            if ($cur_date == $req_date) {
                $time = array();
            }

            continue;
        }

        if (null !== $cur_date) {
            if ($cur_date != $req_date) {
                continue; // only taking times of specified date, or of overall info
            }
        }

        $time[] = $one_date_time_str;

    }

    $time_str = implode("\n<br />\n", $time);

    return $time_str;
}

{{ /php }}

<body>

  <div id="wrapper">
      
{{ omnibox }}
        
        <div class="content-box top-content-fix clearfix agenda">
    
            <div class="top-werbung">
<!-- BEGIN ADITIONTAG -->
<script type="text/javascript" src="http://imagesrv.adition.com/js/adition.js"></script>
<div id="adition_tag_460063"></div>
<!-- END ADITIONTAG -->            
            </div><!-- /.top-werbung -->
    
{{ include file="_tpl/navigation_top.tpl" }}

            <div id="main-nav" class="clearfix">

{{ include file="_tpl/navigation.tpl" }}

{{ include file="_tpl/search_box.tpl" }}

            </div>
            
            <section>
              <div class="article-padding">
                <article>
                        <header>
                            <p>Von der TagesWoche empfohlen</p>
                        </header>
                    </article>
                  <div class="article-list-view padding-fix bottom-fix fixBackground">
                    <div class="loader" style="height:215px">
                        <ul id="quotes-carousel" class="jcarousel-skin-quotes">
                                            
{{ list_playlist_articles id="12" }}

                            <li>
                                <article>
                                    <header>
                                    <p>{{ $gimme->article->dateline }}&nbsp;</p>
                                    {{ include file="_tpl/article_info_box.tpl" }}
                                    </header>
                                    <figure>
                                        <a href="{{ uri options="article" }}">{{ include file="_tpl/img/img_300x200.tpl" }}</a>
                                    </figure>
                                    <h3><a href="{{ uri options="article" }}">{{ $gimme->article->name|replace:'  ':'<br />' }}</a>{{ include file="_tpl/article_title_tooltip_box.tpl" }}</h3>
                                    <p>{{ include file="_tpl/admin_frontpageedit.tpl" }}{{ $gimme->article->teaser|strip_tags|regex_replace:"/\"(.*?)\"/":"&#171;$1&#187;" }}{{* strip tags to make sure there is no line break between teaser and authors *}}
                                    <a href="{{ uri options="article" }}">mehr</a>
                                    </p>
                                </article>
                            </li>
                            
{{ /list_playlist_articles }}        
                    
                        </ul>                    
                    <div class="loading" style="height:215px"></div></div>
                    </div>
                </div>
                
{{ if $smarty.get.page }}{{ assign var="page" value=$smarty.get.page }}{{ else }}{{ assign var="page" value="1" }}{{ /if }}                
                
                <div class="event-finder">
                
                  <article>
                      <header>
                            <p>Veranstaltungen suchen</p>
                        </header>
                    </article>
                    
                    <fieldset class="event-search">
                      <ul class="clearfix">
                          <li>
                              <label for="was">Was</label>
                                <span class="select-box">
                                  <select id="was" name="was" class="option_styled">
                                    <option value="alles" selected>Alles</option>
                                    <option value="ausstellung">Ausstellung</option>
                                    <option value="theater">Theater</option>
<!--
                                    <option value="konzert">Konzert</option>
-->
                                    <option value="musik">Musik</option>
                                    <option value="party">Party</option>
<!--
                                    <option value="zirkus">Zirkus</option>
-->
                                    <option value="andere">Andere</option>
                                  </select>
                                </span>
                            </li>
                            <li>
                              <label for="wann">Wann</label>
                                <input type="text" value="" id="wann" class="datepicker" />
                            </li>
                            <li>
                              <label for="wo">Wo</label>
                                <span class="select-box">
                                  <select id="wo" name="wo" class="option_styled">
                                    <option value="region-basel" selected>Region Basel</option>
                                    <option value="kanton-basel-stadt">Basel-Stadt</option>
                                    <option value="kanton-basel-landschaft">Basel-Landschaft</option>
                                    <option value="kanton-aargau">Aargau</option>
                                    <option value="kanton-appenzell Ausserrhoden">Appenzell Ausserrhoden</option>
                                    <option value="kanton-appenzell Innerrhoden">Appenzell Innerrhoden</option>
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
                                </span>
                            </li>
                            <li class="right">
                              <button class="button" id="suchen">SUCHEN</button>
                            </li>
                        </ul>
                    </fieldset>                  

{{ assign var="load_list" 0 }}
{{ if !empty($smarty.get.load) }}
    {{ if 1 eq $smarty.get.load }}
        {{ assign var="load_list" 1 }}
    {{ /if }}
{{ /if }}

{{* by default I would limit event list to those happening today *}} 
{{ assign var="usedate" $smarty.now|camp_date_format:"%Y-%m-%d" }}
{{ if !empty($smarty.get.date) }}
    {{ assign var="usedate" $smarty.get.date|replace:" ":"\\ "|replace:'"':"" }}
{{ /if }}

{{ assign var="condate" ""}}
{{ assign var="muldate" ""}}
{{ if !empty($usedate) }}
    {{ assign var="condate" "date is $usedate"}}
    {{ assign var="muldate" "start_date: $usedate, end_date: $usedate"}}
{{ /if }}

{{ assign var="usetype" "" }}
{{ if !empty($smarty.get.type) }}
    {{ assign var="usetype_spec" $smarty.get.type }}
    {{ if "ausstellung" eq $usetype_spec }}
        {{ assign var="usetype" "Ausstellung\\ Veranstaltung" }}
    {{ elseif "theater" eq $usetype_spec }}
        {{ assign var="usetype" "Theater\\ Veranstaltung" }}
    {{ elseif "konzert" eq $usetype_spec }}
        {{ assign var="usetype" "Konzert\\ Veranstaltung" }}
    {{ elseif "musik" eq $usetype_spec }}
        {{ assign var="usetype" "Musik\\ Veranstaltung" }}
    {{ elseif "party" eq $usetype_spec }}
        {{ assign var="usetype" "Party\\ Veranstaltung" }}
    {{ elseif "zirkus" eq $usetype_spec }}
        {{ assign var="usetype" "Zirkus\\ Veranstaltung" }}
    {{ elseif "andere" eq $usetype_spec }}
        {{ assign var="usetype" "Andere\\ Veranstaltung" }}
    {{ /if }}
{{ /if }}

{{ assign var="useregion" "Region\\ Basel" }}
{{ if !empty($smarty.get.region) }}
    {{ assign var="useregion_spec" $smarty.get.region }}
    {{ if "region-basel" eq $useregion_spec }}
        {{ assign var="useregion" "Region\\ Basel" }}
    {{ elseif "kanton-basel-stadt" eq $useregion_spec }}
        {{ assign var="useregion" "Kanton\\ Basel-Stadt" }}
    {{ elseif "kanton-basel-landschaft" eq $useregion_spec }}
        {{ assign var="useregion" "Kanton\\ Basel-Landschaft" }}
    {{ elseif "kanton-aargau" eq $useregion_spec }}
        {{ assign var="useregion" "Kanton\\ Aargau" }}
    {{ elseif "kanton-appenzell-ausserrhoden" eq $useregion_spec }}
        {{ assign var="useregion" "Kanton\\ Appenzell\\ Ausserrhoden" }}
    {{ elseif "kanton-appenzell-innerrhoden" eq $useregion_spec }}
        {{ assign var="useregion" "Kanton\\ Appenzell\\ Innerrhoden" }}
    {{ elseif "kanton-bern" eq $useregion_spec }}
        {{ assign var="useregion" "Kanton\\ Bern" }}
    {{ elseif "kanton-freiburg" eq $useregion_spec }}
        {{ assign var="useregion" "Kanton\\ Freiburg" }}
    {{ elseif "kanton-genf" eq $useregion_spec }}
        {{ assign var="useregion" "Kanton\\ Genf" }}
    {{ elseif "kanton-glarus" eq $useregion_spec }}
        {{ assign var="useregion" "Kanton\\ Glarus" }}
    {{ elseif "kanton-graubuenden" eq $useregion_spec }}
        {{ assign var="useregion" "Kanton\\ Graubünden" }}
    {{ elseif "kanton-jura" eq $useregion_spec }}
        {{ assign var="useregion" "Kanton\\ Jura" }}
    {{ elseif "kanton-luzern" eq $useregion_spec }}
        {{ assign var="useregion" "Kanton\\ Luzern" }}
    {{ elseif "kanton-neuenburg" eq $useregion_spec }}
        {{ assign var="useregion" "Kanton\\ Neuenburg" }}
    {{ elseif "kanton-nidwalden" eq $useregion_spec }}
        {{ assign var="useregion" "Kanton\\ Nidwalden" }}
    {{ elseif "kanton-obwalden" eq $useregion_spec }}
        {{ assign var="useregion" "Kanton\\ Obwalden" }}
    {{ elseif "kanton-schaffhausen" eq $useregion_spec }}
        {{ assign var="useregion" "Kanton\\ Schaffhausen" }}
    {{ elseif "kanton-schwyz" eq $useregion_spec }}
        {{ assign var="useregion" "Kanton\\ Schwyz" }}
    {{ elseif "kanton-solothurn" eq $useregion_spec }}
        {{ assign var="useregion" "Kanton\\ Solothurn" }}
    {{ elseif "kanton-st-gallen" eq $useregion_spec }}
        {{ assign var="useregion" "Kanton\\ St.\\ Gallen" }}
    {{ elseif "kanton-tessin" eq $useregion_spec }}
        {{ assign var="useregion" "Kanton\\ Tessin" }}
    {{ elseif "kanton-thurgau" eq $useregion_spec }}
        {{ assign var="useregion" "Kanton\\ Thurgau" }}
    {{ elseif "kanton-uri" eq $useregion_spec }}
        {{ assign var="useregion" "Kanton\\ Uri" }}
    {{ elseif "kanton-waadt" eq $useregion_spec }}
        {{ assign var="useregion" "Kanton\\ Waadt" }}
    {{ elseif "kanton-wallis" eq $useregion_spec }}
        {{ assign var="useregion" "Kanton\\ Wallis" }}
    {{ elseif "kanton-zug" eq $useregion_spec }}
        {{ assign var="useregion" "Kanton\\ Zug" }}
    {{ elseif "kanton-zuerich" eq $useregion_spec }}
        {{ assign var="useregion" "Kanton\\ Zürich" }}
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

<small><a href="mailto:agenda@tageswoche.ch">Veranstaltung melden</a></small>

{{ assign var="colcount" 10 }}

<div id="newslist">
{{ if 1 eq $load_list }}
{{ list_articles columns="$colcount" ignore_issue="true" ignore_section="true" constraints="$contopic_region $contopic_type section is 71 type is event matchalltopics " length="$colcount" schedule="$muldate"}}
    {{ if $gimme->current_list->column == "1" }}
                    <ul class="event-search-results">
    {{ /if }}
                        <li>
                            <h3><a href="{{ uri options="article" }}?date={{$usedate}}">{{ if $gimme->article->genre }}{{ $gimme->article->genre }}: {{ /if }}{{ $gimme->article->headline|replace:'\\':'\'' }}</a></h3>
                            <p>{{ $gimme->article->description|truncate:140 }} <a href="{{ uri options="article" }}?date={{$usedate}}">Details</a></p>

{{ assign var="one_time" "" }}
{{ assign var="multi_time_text" $gimme->article->multi_time|replace:"&nbsp;":" " }}

{{ php }}

$req_date = $template->get_template_vars('usedate');
$multi_time_text = $template->get_template_vars('multi_time_text');
$one_time = get_time_text($multi_time_text, $req_date);
$template->assign('one_time', $one_time);

{{ /php }}

{{ if $one_time eq '' }}
{{ foreach from=$gimme->article->dates item='date' }}
    {{ if $date->field_name eq 'schedule' }}
        {{ assign var="one_date" $date->start_date }}
        {{ assign var="one_date" $one_date|camp_date_format:"%Y-%m-%d" }}
        {{ if $one_date == $usedate }}
            {{ assign var="one_time" $date->start_time|camp_date_format:"%H.%i" }}
        {{ /if }}
    {{ /if }}
{{ /foreach }}
{{ /if }}

                            <p>{{ if $gimme->article->organizer }}{{ $gimme->article->organizer|replace:'\\':'\'' }}, {{ /if }}{{ if $one_time }}{{ $one_time }} Uhr {{ /if }}{{ $usedate|camp_date_format:"%e.%m.%Y" }}</p>
                        </li>
    {{ if ($gimme->current_list->column == "$colcount") || $gimme->current_list->at_end }}
                    </ul>
    {{ /if }}
    {{ $page_count=ceil($gimme->current_list->count/$colcount) }}
    {{ $page_offset=intval($gimme->url->get_parameter($gimme->current_list_id())) }}
    {{ $list_name=$gimme->current_list_id() }}
{{ /list_articles }}
{{ else }}
{{ list_articles length="1" }}{{* dummy list to have the list id *}}
    {{ $list_name=$gimme->current_list_id() }}
{{ /list_articles }}
<figure class="loading_block_events">
  <div class="loading_image_events">
    <img src="{{ uri static_file='_css/tw2011/img/loading_big.gif' }}">
  </div>
  <div class="loading_text_events">
    Das aktuelle Programm wird geladen.
  </div>
</figure>
{{ /if }}
<div id="page_list_name" class="text_hidden">{{ $list_name }}</div>
</div>

{{* pagination. here we check which page is active and create links to other pages *}}

{{ if 1 eq $load_list }}
{{ $prev_page=floor($page_offset/$colcount)}}
{{ if $page_offset eq ($prev_page*$colcount) }}
{{ $prev_page=$prev_page-1 }}
{{ /if }}
{{ $next_page=ceil($page_offset/$colcount)}}
{{ if $page_offset eq ($next_page*$colcount) }}
{{ $next_page=$next_page+1 }}
{{ /if }}
{{ /if }}

<div id="newslist_pagination">
{{ if 1 eq $load_list }}
{{ if $page_count gt 1 }}
<p class="pagination">
    {{ for $i=0 to $page_count - 1 }}
        {{ $curr_offset=$i*$colcount }}
        {{ if $curr_offset != $page_offset }}
        <a href="#" onclick="window.paginate({{ $i }}, '{{ $list_name }}', {{ $colcount }}); return false;">{{ $i+1 }}</a>
        {{ else }}
        <span style="font-weight: bold; text-decoration: none">{{ $i+1 }}</span>
        {{ $remi=$i+1 }}
        {{ /if }}
    {{ /for }}
    <span class="nav right">
    {{ if 0 le $prev_page }}<a href="#" }}" onclick="window.paginate({{ $prev_page }}, '{{ $list_name }}', {{ $colcount }}); return false;" class="prev">Previous</a>{{ /if }}
    {{ if $page_count gt $next_page }}<a href="#" onclick="window.paginate({{ $next_page }}, '{{ $list_name }}', {{ $colcount }}); return false;" class="next">Next</a>{{ /if }}
    </span>
</p>
{{ /if }}
{{ /if }}
</div>
                </div>
                <div style="margin: 15px 0; display: block">
<!-- BEGIN ADITIONTAG -->
<script type="text/javascript" src="http://imagesrv.adition.com/js/adition.js"></script>
<div id="adition_tag_460065"></div>
<!-- END ADITIONTAG -->                
                </div> 
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

window.set_list_content = function(data) {
    var dom = $(data);
    $('#newslist').html($('#newslist', dom).html());
    $('#newslist_pagination').html($('#newslist_pagination', dom).html());

    window.set_cufon_fonts();
    Cufon.now();
};

window.paginate = function(page, listname, setcount) {
    if (typeof listname == "undefined") {
        listname = "" + $("#page_list_name").html();
    }
    listname = listname.replace(/^\s+|\s+$/g, "");
    if (typeof setcount == "undefined") {
        setcount = {{ $colcount }};
    }

    var offset = page * setcount;
    var path = window.last_search + "&page=" + page + "&" + listname + "=" + offset;

    var path_spec = window.last_search_spec;
    path_spec = path_spec.replace(/;page:\d+/g, "");

    var page_value = parseInt(page) + 1;
    path_spec += ";page:" + page_value;


    $.get(path, {}, function (data, textStatus, jqXHR) {
        window.list_spec['page'] = page_value;
        $.address.value(path_spec);

        window.set_list_content(data);
    });
};

window.get_basic_path = function() {
    return "{{ local }}{{ set_section number="71" }}{{ uri options="section" }}{{ /local }}" + "?load=1";
};

window.reload = function(page) {
    if (undefined === page) {
        page = 1;
    }
    page = parseInt(page);


    var path = window.get_basic_path();
    var path_spec = "";
    var separator = "&";

    var what = "" + $("#was").val();
    what = escape(what.replace(/^\s+|\s+$/g, ""));

    var what_val = "alles";
    if ("" != what) {
        path += separator + "type=" + what;
        path_spec += separator + "type=" + what;
        what_val = what;
    }

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
    if (page) {
        path += separator + "page=" + page;
        path_spec += separator + "page=" + page;
    }

    if ("" != path_spec) {
        path_spec = path_spec.replace(/&/g, ";");
        path_spec = path_spec.replace(/=/g, ":");
    }

    window.last_search_spec = path_spec;

    if (1 < page) {
        // we need to have set the environment for pagination as if the page was loaded
        window.list_spec['type'] = what_val;
        window.list_spec['date'] = when_val;
        window.list_spec['region'] = where_val;
        window.list_spec['page'] = 1;

        window.paginate(page - 1);
        return;
    }

    $('#suchen').attr("disabled", true);
    $('#suchen').addClass('ui-state-disabled');
    $.get(path, {}, function (data, textStatus, jqXHR) {
        window.list_spec['type'] = what_val;
        window.list_spec['date'] = when_val;
        window.list_spec['region'] = where_val;
        window.list_spec['page'] = 1;

        $.address.value(path_spec);
        window.set_list_content(data);
        $('#suchen').attr("disabled", false);
        $('#suchen').removeClass('ui-state-disabled');
    });
};

window.last_search = window.get_basic_path();
window.last_search_spec = "";

$(document).ready(function() {
    $( "#suchen" ).click(function() {
        window.reload();
    });
});
</script>

            
            <aside>
{{ local }}
{{ set_current_issue }}
{{ set_section number="50" }}            
{{ list_articles length="5" constraints="type is news" }}
{{ if $gimme->current_list->at_beginning }}               
                <article>
                  <header>
                      <p> Aus der Rubrik Kultur</p>
                    </header>
                    <ul class="simple-list no-padding">
{{ /if }}                    
                        <li><a href="{{ uri options="article" }}">{{ $gimme->article->name }}</a></li>
{{ if $gimme->current_list->at_end }}                        
                    </ul>
                </article>
{{ /if }}
{{ /list_articles }}
{{ /local }}                

{{* BLOG TEASERS *}}
{{ include file="_tpl/sidebar_blog_teaser.tpl" blogpl="Blog teasers - Veranstaltungen" }}

{{* PARTNER BUTTONS *}}
{{ include file="_tpl/sidebar_partner_buttons.tpl" }}

{{* TEASER BOXES *}}
{{ include file="_tpl/sidebar_teaser_boxes.tpl" }}
                
                <article>
                    <header>
                        <p>Werbung</p>
                    </header>
                    <span class="werbung">
<!-- BEGIN ADITIONTAG -->
<script type="text/javascript" src="http://imagesrv.adition.com/js/adition.js"></script>
<div id="adition_tag_460064"></div>
<!-- END ADITIONTAG -->
                    </span>
                </article>
                            
            </aside>
        
        </div>

{{ include file="_tpl/footer.tpl" }}

    </div><!-- / Wrapper -->   

{{* JAVASCRIPT FOOTER *}}
{{ include file="_tpl/_footer_javascript.tpl" }}
<script type="text/javascript" src="{{ uri static_file='_js/libs/jquery.address.js' }}"></script>

</body>
</html>
