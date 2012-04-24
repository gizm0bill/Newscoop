{{ assign var="make_link" 0 }}
{{ assign var="req_movie_key" "" }}
{{ assign var="req_movie_suisa" "" }}
{{ if !empty($smarty.get.key) }}
    {{ assign var="make_link" 1 }}
    {{ assign var="req_movie_key" $smarty.get.key|replace:" ":"\\ "|replace:'"':"" }}
{{ /if }}
{{ if !empty($smarty.get.suisa) }}
    {{ assign var="make_link" 1 }}
    {{ assign var="req_movie_suisa" $smarty.get.suisa|replace:" ":"\\ "|replace:'"':"" }}
{{ /if }}
{{ if $make_link }}
    {{ assign var="req_movie_found" 0 }}
    {{ if $req_movie_suisa != "" }}
        {{ assign var="req_link_con" "movie_suisa is $req_movie_suisa" }}
    {{ /if }}
    {{ if $req_movie_key != "" }}
        {{ assign var="req_link_con" "movie_key is $req_movie_key" }}
    {{ /if }}
    {{* create list on that movie, take one and create link, alike from a real screening list *}}
    {{ list_articles columns="1" length="1" ignore_issue="true" ignore_section="true" constraints="$req_link_con type is screening" }}
<meta http-equiv="refresh" content="0; url={{ url options="article" }}">
        {{ assign var="req_movie_found" 1 }}
    {{ /list_articles }}
    {{ if $req_movie_found eq 0 }}
        {{ include file="404.tpl" }}
    {{ /if }}
{{ else }}


{{ assign var="make_vimeo" 0 }}
{{ assign var="req_vimeo_key" "" }}
{{ if !empty($smarty.get.vimeo) }}
    {{ assign var="make_vimeo" 1 }}
    {{ assign var="req_vimeo_key" $smarty.get.vimeo|replace:" ":"\\ "|replace:'"':"" }}
    {{* assign var="req_vimeo_key" 24936756 *}}
{{ /if }}
{{ if $make_vimeo }}
    {{ assign var="vimeo_height" 310 }}
    {{ assign var="vimeo_width" 550 }}
    <html><body style="width:{{ $vimeo_width }}px;height:{{ $vimeo_height }}px">
    <!--<div>-->
        <div id="vimeo_trailer" class="vimeo_trailer_block" style="width:{{ $vimeo_width }}px;height:{{ $vimeo_height }}px">
        <!--<iframe src="http://player.vimeo.com/video/{{ $req_vimeo_key }}?title=0&amp;byline=0&amp;portrait=0" width="{{ $vimeo_width_show }}" height="{{ $vimeo_height_show }}" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen>-->
        <iframe style="width:{{ $vimeo_width }}px;height:{{ $vimeo_height }}px" src="http://player.vimeo.com/video/{{ $req_vimeo_key }}?title=0&amp;byline=0&amp;portrait=0" width="{{ $vimeo_width }}" height="{{ $vimeo_height }}" frameborder="0">
        </iframe>
        </div>
    <!--</div>-->
    </body></html>
{{ else }}





{{ include file="_tpl/_html-head.tpl" }}

<style type="text/css">

.loading_block_movies {
}
.loading_image_movies {
/*
    float: left;
*/
    margin-left: 25px;
}
.loading_text_movies {
/*
    float: left;
*/
    margin-top: -35px;
    margin-bottom: 150px;
    margin-left: 100px;
}

span span.title-box {
    position: absolute;
}

.top_label {
    z-index: 1000;
}

.event-movies-results article figure.movie_list_thumbnail {
    margin-bottom: 2px;
    width: 115px;
}

.hier_link {
    margin-bottom: 10px;
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
    float: right;
    margin-right:100px;
    margin-bottom:20px;
    font-size: 12px;
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
    region: ''
};

window.update_list_on_params = function(params) {
    var differ = false;
    //var newpage = 0;

    var new_spec = {
        type: 'kino',
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
            //if ("page" != pkey) {
                differ = true;
            //} else {
            //  newpage = parseInt(new_spec[pkey]);
            //}
        }
    }

    //if ((0 != newpage) && (!differ)) {
    //    window.paginate(newpage - 1);
    //    return;
    //}

    if (!differ) {
        return;
    }

    if ('' != new_spec['type']) {
        //$("#was").val(new_spec['type']);
        outline_genre(new_spec['type']);
    }
//alert(new_spec['region']);
    if ('' != new_spec['region']) {
//        var sel_region = new_spec['region'];
//        sel_region = sel_region.replace(/%20/g, " ");
//        $("#wo").val(sel_region);
        $("#wo").val(new_spec['region']);
//        $('select').dropdownized({fixed:true});
//        $("#wo").selectedIndex = 3;
//        $("#wo").focus();
//alert($("#wo").val());
    }

    if ('' != new_spec['date']) {
        $(".datepicker").datepicker("setDate" , new Date(new_spec['date']));
    }

    //window.reload(new_spec['page']);
    window.reload();
};

window.cinema_map_lists = {};

$(document).ready(function() {
    $.address.change(function(event) {
        window.update_list_on_params($.address.value());
    });
    $("#was").val('kino');
    $("#wo").val('kanton-basel-stadt');

  // Datepicker
  var dp = $( ".datepicker" ).datepicker({
    showOn: "button",
    buttonImage: "{{ uri static_file="_css/tw2011/img/calendar.png" }}",
    buttonImageOnly: true
  });

    $(".datepicker").datepicker("setDate" , new Date());
    $('#ui-datepicker-div').css('display','none'); // see http://stackoverflow.com/questions/5735888/updating-to-latest-jquery-ui-and-datepicker-is-causing-the-datepicker-to-always-b

    window.set_image_lists();
});

window.set_image_lists = function()
{
return;
// TODO:
    $("a.movie_image_list").fancybox({
        type: 'image'
    });
};

window.set_maps_lists = function()
{
    var one_list_values = "";
    for (var one_list_id in window.cinema_map_lists) {
        one_list_values = window.cinema_map_lists[one_list_id];
        if ("" != one_list_values) {
            $("#" + cinemas_list_map_lnk_ + "" + one_list_id).addClass("cinemas_list_map_link");
            $("#" + cinemas_list_map_lnk_ + "" + one_list_id).attr("href", one_list_values);
            $("#" + cinemas_list_map_ + "" + one_list_id).removeClass("cinemas_list_map_hidden");
        }
    }
};

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

function outline_genre(genre) {
    window.what_val = genre;
    $('.li_genre').removeClass('active');
    $('#li_' + genre).addClass('active');

};

function load_genre(genre) {

    outline_genre(genre);

    window.reload();

    //alert("not implemented: " + genre);
    return false;
};

function load_area(area) {
    window.reload();

    //var area_obj = $(area);
    //alert("not implemented: " + area_obj.val());
    return false;
};

function movie_set_lang(movie_id, lang, state) {
    if (state) {
        $("#" + movie_id).removeClass("has_not_" + lang);
        $("#" + movie_id).addClass("has_" + lang);
    }
    else {
        $("#" + movie_id).removeClass("has_" + lang);
        $("#" + movie_id).addClass("has_not_" + lang);
    }
};
function movie_set_recom(movie_id, state) {
    if (state) {
        $("#" + movie_id).addClass("stared");
    }
    else {
        $("#" + movie_id).removeClass("stared");
    }
};

var lang_seen_last = 'all';

function show_lang(spec) {
//return;
    if ('last' == spec) {
        spec = lang_seen_last;
    }
    else {
        lang_seen_last = spec;
    }

    if ('all' == spec) {
        $(".movie_lang").show();
    }
    if ('de' == spec) {
        $(".has_not_d").hide();
        $(".has_d").show();
    }
    if ('dial' == spec) {
        $(".has_not_k").hide();
        $(".has_k").show();
    }
    if ('fr' == spec) {
        $(".has_not_f").hide();
        $(".has_f").show();
    }
    if ('subt' == spec) {
        $(".has_not_t").hide();
        $(".has_t").show();
    }

    $('.movie_sel').removeClass('active');
    $('#movie_sel_' + spec).addClass('active');
};

function show_trailer(vimeo_id) {
return;

    var vimeo_width = "" + 640;
    var vimeo_height = "" + 344;

    var vimeo_id_d = '24936756';

    var trailer_content = '';
    trailer_content += '<div id="vimeo_trailer_hidden_' + vimeo_id + '" style="display:none">';
    trailer_content += '<a href="#vimeo_trailer" id="vimeo_trailer_link_inner_' + vimeo_id + '">Trailer</a>';
    trailer_content += '</div>';
    trailer_content += '<div id="vimeo_trailer_' + vimeo_id + '">';
    trailer_content += '<iframe src="http://player.vimeo.com/video/' + vimeo_id_d + '?title=0&amp;byline=0&amp;portrait=0" width="' + vimeo_width + '" height="' + vimeo_height + '" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen>';
    trailer_content += '</iframe>';
    trailer_content += '</div>';

    $("#vimeo_trailer_outer_" + vimeo_id).html("&nbsp;");
    $("#vimeo_trailer_outer_" + vimeo_id).html(trailer_content);

    $("#vimeo_trailer_link_inner_" + vimeo_id).fancybox({
        type: 'iframe',
        width: 640,
        height: 400
    });

    $("#vimeo_trailer_outer_" + vimeo_id).show();

    $("#vimeo_trailer_link_inner_" + vimeo_id).trigger('click');
};
</script>

<body>

  <div id="wrapper">
      
{{ include file="_tpl/header-omnibox.tpl" }}

{{ include file="_tpl/header.tpl" }}
        
{{ include file="_ausgehen/subnav.tpl" }}

        
        <div class="content-box clearfix reverse-columns agenda-content movies-list">



            <aside>

                <ul style="display:none">
                            <li>
                              <label for="wann">Wann</label>
                                <input type="text" value="" id="wann" class="datepicker" style="width:80px;" />
                            </li>
                </ul>
                
<!--
                <h3>Sortieren nach</h3>
                <ul class="categories">
                    <li><a href="#" onClick="alert('Not implemented.'); return false;">Bewertung</a></li>
                    <li><a href="#" onClick="alert('Not implemented.'); return false;">Besucherzahlen</a></li>
                    <li class="active"><a href="#" onClick="alert('Just this.'); return false;">alphabetisch</a></li>
                </ul>
-->
                
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
                
                <h3>Genre</h3>
                <ul class="categories">
                        <li class="active li_genre" id="li_kino"><a href="#" onClick="load_genre('kino'); return false;">Alles</a></li>
                        <li class="li_genre" id="li_abenteuer"><a href="#" onClick="load_genre('abenteuer'); return false;">Abenteuer</a></li>
                        <li class="li_genre" id="li_action"><a href="#" onClick="load_genre('action'); return false;">Action</a></li>
                        <li class="li_genre" id="li_adult"><a href="#" onClick="load_genre('adult'); return false;">Adult</a></li>
                        <li class="li_genre" id="li_animation"><a href="#" onClick="load_genre('animation'); return false;">Animation</a></li>
                        <li class="li_genre" id="li_biografie"><a href="#" onClick="load_genre('biografie'); return false;">Biografie</a></li>
                        <li class="li_genre" id="li_crime"><a href="#" onClick="load_genre('crime'); return false;">Crime</a></li>
                        <li class="li_genre" id="li_dokumentation"><a href="#" onClick="load_genre('dokumentation'); return false;">Dokumentation</a></li>
                        <li class="li_genre" id="li_drama"><a href="#" onClick="load_genre('drama'); return false;">Drama</a></li>
                        <li class="li_genre" id="li_familienfilm"><a href="#" onClick="load_genre('familienfilm'); return false;">Familienfilm</a></li>
                        <li class="li_genre" id="li_fantasy"><a href="#" onClick="load_genre('fantasy'); return false;">Fantasy</a></li>
                        <li class="li_genre" id="li_film-noir"><a href="#" onClick="load_genre('film-noir'); return false;">Film-Noir</a></li>
                        <li class="li_genre" id="li_historischer"><a href="#" onClick="load_genre('historischer'); return false;">Historisch</a></li>
                        <li class="li_genre" id="li_horror"><a href="#" onClick="load_genre('horror'); return false;">Horror</a></li>
                        <li class="li_genre" id="li_komoedie"><a href="#" onClick="load_genre('komoedie'); return false;">Komödie</a></li>
                        <li class="li_genre" id="li_kriegsfilm"><a href="#" onClick="load_genre('kriegsfilm'); return false;">Kriegsfilm</a></li>
                        <li class="li_genre" id="li_kurzfilm"><a href="#" onClick="load_genre('kurzfilm'); return false;">Kurzfilm</a></li>
                        <li class="li_genre" id="li_musical"><a href="#" onClick="load_genre('musical'); return false;">Musical</a></li>
                        <li class="li_genre" id="li_musikfilm"><a href="#" onClick="load_genre('musikfilm'); return false;">Musikfilm</a></li>
                        <li class="li_genre" id="li_mystery"><a href="#" onClick="load_genre('mystery'); return false;">Mystery</a></li>
                        <li class="li_genre" id="li_romanze"><a href="#" onClick="load_genre('romanze'); return false;">Romanze</a></li>
                        <li class="li_genre" id="li_sci-fi"><a href="#" onClick="load_genre('sci-fi'); return false;">Sci-Fi</a></li>
                        <li class="li_genre" id="li_sport"><a href="#" onClick="load_genre('sport'); return false;">Sport</a></li>
                        <li class="li_genre" id="li_thriller"><a href="#" onClick="load_genre('thriller'); return false;">Thriller</a></li>
                        <li class="li_genre" id="li_western"><a href="#" onClick="load_genre('western'); return false;">Western</a></li>
                        <li class="li_genre" id="li_andere"><a href="#" onClick="load_genre('andere'); return false;">Andere</a></li>
                </ul>
                
<!--
                <h3>Kino</h3>
                <ul class="categories">
                    <li class="active"><a href="#">Alle</a></li>
                    <li><a href="#">Pathe Küchlin</a></li>
                    <li><a href="#">kult.kino atelier</a></li>
                    <li><a href="#">kult.kino camera</a></li>
                    <li><a href="#">Pathe Eldorado</a></li>
                    <li><a href="#">Stadtkino Basel</a></li>
                    <li><a href="#">rex</a></li>
                    <li><a href="#">capitol</a></li>
                    <li><a href="#">studio central</a></li>
                    <li><a href="#">kult.kino club</a></li>
                    <li><a href="#">Pathe Plaza</a></li>
                    <li><a href="#">Neues Kino</a></li>
                </ul>
-->
                
                <h3>Sprache</h3>
                <ul class="categories">
                    <li id="movie_sel_all" class="active movie_sel movie_sel_all"><a href="#" onClick="show_lang('all'); return false;">Alle</a></li>
                    <li id="movie_sel_de" class="movie_sel movie_sel_de"><a href="#" onClick="show_lang('de'); return false;">Deutsch</a></li>
                    <li id="movie_sel_dial" class="movie_sel movie_sel_dial"><a href="#" onClick="show_lang('dial'); return false;">Dialekt</a></li>
                    <li id="movie_sel_fr" class="movie_sel movie_sel_fr"><a href="#" onClick="show_lang('fr'); return false;">Französisch</a></li>
                    <li id="movie_sel_subt" class="movie_sel movie_sel_subt"><a href="#" onClick="show_lang('subt'); return false;">Original + Untertitel</a></li>
                </ul>
                
<!--
                <h3>Altersfreigabe</h3>
                <ul class="categories">
                    <li class="active"><a href="#">Alle</a></li>
                    <li><a href="#">ab 16</a></li>
                    <li><a href="#">ab 12</a></li>
                    <li><a href="#">ab 6</a></li>
                </ul>
-->
                
                <h3>Presenting Partner</h3>
                <ul class="partner-list">
                    <li><a href="#"><img src="{{ uri static_file="_ausgehen/pictures/partner-logo-small-3.jpg" }}" alt="" /></a></li>
                </ul>
            
            </aside>


            <section>
                <!--<div class="event-finder">-->

{{ assign var="load_list" 0 }}
{{ if !empty($smarty.get.load) }}
    {{ if 1 eq $smarty.get.load }}
        {{ assign var="load_list" 1 }}
    {{ /if }}
{{ /if }}

{{* by default we gonna limit event list to those happening today *}} 
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
    {{ if "abenteuer" eq $usetype_spec }}
        {{ assign var="usetype" "Abenteuer\\ Film" }}
    {{ elseif "action" eq $usetype_spec }}
        {{ assign var="usetype" "Action\\ Film" }}
    {{ elseif "adult" eq $usetype_spec }}
        {{ assign var="usetype" "Adult\\ Film" }}
    {{ elseif "animation" eq $usetype_spec }}
        {{ assign var="usetype" "Animation\\ Film" }}
    {{ elseif "biografie" eq $usetype_spec }}
        {{ assign var="usetype" "Biografie\\ Film" }}
    {{ elseif "crime" eq $usetype_spec }}
        {{ assign var="usetype" "Crime\\ Film" }}
    {{ elseif "dokumentation" eq $usetype_spec }}
        {{ assign var="usetype" "Dokumentation\\ Film" }}
    {{ elseif "drama" eq $usetype_spec }}
        {{ assign var="usetype" "Drama\\ Film" }}
    {{ elseif "familienfilm" eq $usetype_spec }}
        {{ assign var="usetype" "Familienfilm\\ Film" }}
    {{ elseif "fantasy" eq $usetype_spec }}
        {{ assign var="usetype" "Fantasy\\ Film" }}
    {{ elseif "film-noir" eq $usetype_spec }}
        {{ assign var="usetype" "Film-Noir\\ Film" }}
    {{ elseif "historischer" eq $usetype_spec }}
        {{ assign var="usetype" "Historischer\\ Film" }}
    {{ elseif "horror" eq $usetype_spec }}
        {{ assign var="usetype" "Horror\\ Film" }}
    {{ elseif "komoedie" eq $usetype_spec }}
        {{ assign var="usetype" "Komödie\\ Film" }}
    {{ elseif "kriegsfilm" eq $usetype_spec }}
        {{ assign var="usetype" "Kriegsfilm\\ Film" }}
    {{ elseif "kurzfilm" eq $usetype_spec }}
        {{ assign var="usetype" "Kurzfilm\\ Film" }}
    {{ elseif "musical" eq $usetype_spec }}
        {{ assign var="usetype" "Musical\\ Film" }}
    {{ elseif "musikfilm" eq $usetype_spec }}
        {{ assign var="usetype" "Musikfilm\\ Film" }}
    {{ elseif "mystery" eq $usetype_spec }}
        {{ assign var="usetype" "Mystery\\ Film" }}
    {{ elseif "romanze" eq $usetype_spec }}
        {{ assign var="usetype" "Romanze\\ Film" }}
    {{ elseif "sci-fi" eq $usetype_spec }}
        {{ assign var="usetype" "Sci-Fi\\ Film" }}
    {{ elseif "sport" eq $usetype_spec }}
        {{ assign var="usetype" "Sport\\ Film" }}
    {{ elseif "thriller" eq $usetype_spec }}
        {{ assign var="usetype" "Thriller\\ Film" }}
    {{ elseif "western" eq $usetype_spec }}
        {{ assign var="usetype" "Western\\ Film" }}
    {{ elseif "andere" eq $usetype_spec }}
        {{ assign var="usetype" "Anderer\\ Film" }}
    {{ /if }}
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

{{ assign var="colcount" 10 }}

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
//echo 'xxx ' . $lang_str . ' yyy';
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
//print_r(array('dates' => $dates, 'langs' => array('d' => ($gl_has_d ? 1 : 0), 'f' => ($gl_has_f ? 1 : 0), 't' => ($gl_has_t ? 1 : 0))));
    return array('dates' => $dates, 'langs' => array('d' => ($gl_has_d ? 1 : 0), 'k' => ($gl_has_k ? 1 : 0), 'f' => ($gl_has_f ? 1 : 0), 't' => ($gl_has_t ? 1 : 0)));
}

{{ /php }}


                    <div id="event_movies_results" class="event-movies-results">
{{ assign var="map_article_list" "" }}
{{ assign var="map_article_list_sep" "," }}
{{ assign var="movie_rank" 0 }}
{{ assign var="max_text_len" 250 }}
{{ assign var="lastmovname" "" }}
{{ if 1 eq $load_list }}
{{ assign var=today_date "2011-11-01" }}
{{ assign var=today_date $smarty.now|date_format:"%Y-%m-%d" }}
{{ assign var=condate "" }}
{{ assign var=condate_real "publish_date is $today_date" }}
{{* list_articles columns="$colcount" ignore_issue="true" ignore_section="true" constraints="$condate $contopic_region $contopic_type section is 72 type is screening matchalltopics " order="byname asc" movie_screening="$muldate" length=5 *}}
{{* list_articles columns="$colcount" ignore_issue="true" ignore_section="true" constraints="$condate $contopic_region $contopic_type section is 72 type is screening matchalltopics " order="byname asc" length=5 *}}
{{ list_articles columns="$colcount" ignore_issue="true" ignore_section="true" constraints="$condate $contopic_region $contopic_type section is 72 type is screening matchalltopics " order="byname asc" }}
    {{ if $lastmovname != $gimme->article->headline }}
        {{ if "" != $lastmovname }}
                      <script type="text/javascript">
                      window.cinema_map_lists[{{ $movie_rank}}] = "{{ $map_article_list }}";
                      </script>
                      </article>
            {{ assign var="cur_article_number" $gimme->article->number }}
            {{ assign var="map_article_list" "$cur_article_number" }}
        {{ /if }}
                          {{ assign var="movie_rank" $movie_rank+1 }}
                      <article id="movie_{{ $movie_rank }}" class="movie {{* stared *}} movie_lang has_not_d has_not_k has_not_f has_not_t">
                          {{ assign var="movie_desc_len" $gimme->article->description|strip_tags|count_characters:true }}
                          {{ assign var="movie_other_len" $gimme->article->other|strip_tags|count_characters:true }}
                          {{ assign var="movie_text_len" $movie_desc_len+$movie_other_len }}

                          {{ if $gimme->article->has_image(1) }}
                          <img src="{{ url options="image 1 width 188" }}" alt="{{ $gimme->article->image1->description|replace:'"':'\'' }}" class="thumbnail" />
                          {{ /if }}

                            {{* <a href="#" class="grey-button trailer-button" onClick="show_trailer('{{ $gimme->article->movie_trailer_vimeo }}'); return false;"><span>Trailer anschauen</span></a> *}}
                          {{ assign var="vimeo_trailer_id" $gimme->article->movie_trailer_vimeo }}
                          {{* assign var="vimeo_trailer_id" 24936756 *}}
                          {{ if $vimeo_trailer_id ne "" }}
                            <a href="{{ uri options='section' }}?vimeo={{ $vimeo_trailer_id }}" class="grey-button trailer-button"; return false;"><span>Trailer anschauen</span></a>
                          {{ /if }}
                          {{ assign var="recommended" $gimme->article->recommended }}
                          <h3><a href="{{ uri options="article" }}?region={{ $linkregion }}">{{ $gimme->article->headline }}</a> {{ if $recommended }}<small class="tw_recommended"></small>{{ /if }}</h3>
                          {{ if $gimme->article->movie_trailer_vimeo ne "" }}
                            <div style="display:none;" id="vimeo_trailer_outer_{{$gimme->article->movie_trailer_vimeo}}">&nbsp;
                            </div><!-- vimeo_trailer_outer -->
                          {{ /if }}
                            <ul class="top-list-details">
                                {{ assign var="movie_rating_wv" $gimme->article->movie_rating_wv }}
                                {{ if $movie_rating_wv ne "" }}
                                    {{ assign var="movie_rating_wv" 0+$movie_rating_wv }}
                                    {{ if $movie_rating_wv ne 0 }}
                                        <li><span>Bewertung:</span> <ul class="rating"><li{{ if $movie_rating_wv > 0 }} class="on"{{ /if }}>1</li><li{{ if $movie_rating_wv > 1 }} class="on"{{ /if }}>2</li><li{{ if $movie_rating_wv > 2 }} class="on"{{ /if }}>3</li><li{{ if $movie_rating_wv > 3 }} class="on"{{ /if }}>4</li><li{{ if $movie_rating_wv > 4 }} class="on"{{ /if }}>5</li></ul> <em>{{ $movie_rating_wv }}</em></li>
                                    {{ /if }}
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
                                <!--<li><span>Sprache:</span> E/d/f</li>-->
                            </ul>

                          <p>
                          {{ if $movie_text_len <= $max_text_len }}
                            {{ $gimme->article->description }}
                            {{ assign var="film_other" $gimme->article->other|strip_tags }}
                            {{ if "" != $film_other }}
                              <br />{{ $gimme->article->other }}
                            {{ /if }}
                          {{ else }}
                            <span id="movie_short_text_{{ $movie_rank }}">
                                {{ $gimme->article->description|strip_tags|truncate:$max_text_len:" [...]" }}
                            </span>
                          {{ /if }}
                          <a href="{{ url options="article" }}?region={{ $linkregion }}">Details, Trailer & Bilder</a></p>


        {{ assign var="lastmovname" $gimme->article->headline }}
    {{ else }}
            {{ assign var="cur_article_number" $gimme->article->number }}
            {{ assign var="map_article_list" "$map_article_list$map_article_list_sep$cur_article_number" }}
    {{ /if }}
    {{ assign var="lastmovname" $gimme->article->headline }}

    {{ assign var="date_time_str" $gimme->article->date_time_text|replace:"&nbsp;":" " }}
    {{ assign var="movie_lang_d" "0" }}
    {{ assign var="movie_lang_f" "0" }}
    {{ assign var="movie_lang_t" "0" }}
    {{ php }}
        $date_time_str = $template->get_template_vars('date_time_str');
        $date_time_arr = parse_date_text($date_time_str);
        $template->assign('date_time_arr',$date_time_arr['dates']);
        $template->assign('movie_lang_d',$date_time_arr['langs']['d']);
        $template->assign('movie_lang_k',$date_time_arr['langs']['k']);
        $template->assign('movie_lang_f',$date_time_arr['langs']['f']);
        $template->assign('movie_lang_t',$date_time_arr['langs']['t']);
    {{ /php }}
            <div class="movie-table movie_lang{{ if 1 == $movie_lang_d }} has_d{{ else }} has_not_d{{ /if }}{{ if 1 == $movie_lang_k }} has_k{{ else }} has_not_k{{ /if }}{{ if 1 == $movie_lang_f }} has_f{{ else }} has_not_f{{ /if }}{{ if 1 == $movie_lang_t }} has_t{{ else }} has_not_t{{ /if }}">
            <div class="data_movie data_movie_{{ $movie_rank }}" style="display:none;">
                {{ if 1 == $movie_lang_d }}
                d_{{ $movie_rank }};
                {{ /if }}
                {{ if 1 == $movie_lang_k }}
                k_{{ $movie_rank }};
                {{ /if }}
                {{ if 1 == $movie_lang_f }}
                f_{{ $movie_rank }};
                {{ /if }}
                {{ if 1 == $movie_lang_t }}
                t_{{ $movie_rank }};
                {{ /if }}

                {{ if $gimme->article->recommended }}
                r_{{ $movie_rank }};
                {{ /if }}
            </div>
                <ul>
                        <li><h5>{{ $gimme->article->organizer }}</h5></li>
                        <li>
                            <p>{{ $gimme->article->street }}<br />
                            {{ $gimme->article->zipcode }} {{ $gimme->article->town }}</p>
                            <p>
                            {{ list_article_locations length="1" }}
                                <a href="http://maps.google.com/maps?t=k&z=15&q={{ $gimme->location->latitude }},{{ $gimme->location->longitude }}+({{ $gimme->article->organizer|escape:'url' }})&z=17&ll={{ $gimme->location->latitude }},{{ $gimme->location->longitude }}" target="_blank">Google Maps</a><br />
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

                    <table cellpadding="0" cellspacing="0">
                        <thead>
                            <tr>
                        {{ foreach from=$date_time_arr key=date_time_key item=date_time_day }}
                            <td class="cinema_screen_list date_hl_all date_hl_{{$date_time_key|camp_date_format:"%Y-%m-%d"}}">{{ $date_time_key|camp_date_format:"%W"|truncate:2:'' }} <br />{{ $date_time_key|camp_date_format:"%e.%m" }}</td>
                        {{ /foreach }}
                            </tr>
                        </thead>

                        <tbody>
                            <tr>
                            {{ foreach from=$date_time_arr key=date_time_key item=date_time_day }}
                                    <td class="screen_time_list date_hl_all date_hl_{{$date_time_key|camp_date_format:"%Y-%m-%d"}}">
                                        <!--<ul>-->
                                                    {{ foreach from=$date_time_day item=date_time_day_parts }}
                                                    {{ assign var="scr_lang_d" $date_time_day_parts.has_d }}
                                                    {{ assign var="scr_lang_k" $date_time_day_parts.has_k }}
                                                    {{ assign var="scr_lang_f" $date_time_day_parts.has_f }}
                                                    {{ assign var="scr_lang_t" $date_time_day_parts.has_t }}
                                                        <li class="movie_lang{{ if 1 == $scr_lang_d }} has_d{{ else }} has_not_d{{ /if }}{{ if 1 == $scr_lang_k }} has_k{{ else }} has_not_k{{ /if }}{{ if 1 == $scr_lang_f }} has_f{{ else }} has_not_f{{ /if }}{{ if 1 == $scr_lang_t }} has_t{{ else }} has_not_t{{ /if }}">
                                                        <span class="info-link">{{ $date_time_day_parts.time }}<span class="title-box top_label">
<!--
                                                        <div>
                                                        <p>{{ $date_time_day_parts.time }}{{ if "" != $date_time_day_parts.lang }}&nbsp;{{ $date_time_day_parts.lang }}{{ /if }}{{ if "" != $date_time_day_parts.flag }}&nbsp;{{ $date_time_day_parts.flag }}{{ /if }}</p>
                                                        </div>
-->
                                                        </span></span>
                                                        </li>
                                                    {{ /foreach }}
                                        <!--</ul>-->
                                    </td>
                            {{ /foreach }}
                            </tr>
                        </tbody>
                    </table>
            </div>
{{ /list_articles }}
        {{ if "" != $lastmovname }}
                      <script type="text/javascript">
                      window.cinema_map_lists[{{ $movie_rank}}] = "{{ $map_article_list }}";
                      </script>
                      </article>
            {{ assign var="map_article_list" "" }}
        {{ /if }}
{{ if $movie_rank eq 0 }}
    <div class="no_movie_found">Ihre Suche ergab keine Treffer</div>
{{ else}}
              </article>
{{ /if }}

{{ else }}

{{ list_articles length="1" }}{{* dummy list to have the list id *}}
    {{ $list_name=$gimme->current_list_id() }}
{{ /list_articles }}
<figure class="loading_block_movies">
  <div class="loading_image_movies">
    <img src="{{ uri static_file='_css/tw2011/img/loading_big.gif' }}">
  </div>
  <div class="loading_text_movies">
    Das aktuelle Programm wird geladen.
  </div>
</figure>
{{ /if }}

                    </div>
                
                <!--</div>-->
                
            </section>

<script type="text/javascript">
function update_movie_props() {
    $(".data_movie").each(function(ind_elm, elm) {
        var elm_cont = $(elm).html();
        var elm_cont_arr = elm_cont.split(';');
        var elm_cont_len = elm_cont_arr.length;
        for (var ec_ind = 0; ec_ind < elm_cont_len; ec_ind++) {
            var cur_cont = elm_cont_arr[ec_ind];
            cur_cont = cur_cont.replace(/\s/gm,'');
            if (0 == cur_cont.length) {
                continue;
            }
            cur_cont_arr = cur_cont.split('_', 2);
            if (2 != cur_cont_arr.length) {
                continue;
            }
            cur_cont_key = cur_cont_arr[0];
            cur_cont_val = cur_cont_arr[1];

            {
                var movie_prop = cur_cont_key;
                var movie_id = "#movie_" + cur_cont_val;
                if ('d' == movie_prop) {
                    $(movie_id).removeClass("has_not_d");
                    $(movie_id).addClass("has_d");
                }
                if ('k' == movie_prop) {
                    $(movie_id).removeClass("has_not_k");
                    $(movie_id).addClass("has_k");
                }
                if ('f' == movie_prop) {
                    $(movie_id).removeClass("has_not_f");
                    $(movie_id).addClass("has_f");
                }
                if ('t' == movie_prop) {
                    $(movie_id).removeClass("has_not_t");
                    $(movie_id).addClass("has_t");
                }
                if ('r' == movie_prop) {
                    $(movie_id).addClass("stared");
                }
            }

        }

    });
};

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

window.set_cufon_fonts = function() {
    // TODO
};


function show_highlight(date) {
//alert(date);
    $('.date_hl_all').removeClass('current');
    $('.date_hl_' + date).addClass('current');
};

window.set_list_content = function(data, direct) {
//alert(data);
//alert($('#event_movies_results', dom).html());
    if (direct) {
        $('#event_movies_results').html(data);
    }
    else {
        var dom = $(data);
        $('#event_movies_results').html($('#event_movies_results', dom).html());
    }

    window.set_image_lists();

    window.set_cufon_fonts();
    //Cufon.now(); // TODO!!!

    window.set_title_boxes();

    update_movie_props();

    show_lang('last');

    show_highlight(window.list_spec['date']);

    $(".trailer-button").fancybox({
        type: 'iframe',
        width: 570,
        height: 330,
        modal: false,
        showCloseButton: true,
        hideOnContentClick: false
    });
};

window.get_basic_path = function() {
    return "{{ local }}{{ set_section number="72" }}{{ uri options="section" }}{{ /local }}" + "?load=1";
};

window.what_val = 'kino';

window.reload = function(page) {
    if (undefined === page) {
        page = 1;
    }
    page = parseInt(page);


    var path = window.get_basic_path();
    var path_spec = "";
    var separator = "&";

    //var what = "" + $("#was").val();
    var what = window.what_val;
    what = escape(what.replace(/^\s+|\s+$/g, ""));

    var what_val = "kino";
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

    if ("" != path_spec) {
        path_spec = path_spec.replace(/&/g, ";");
        path_spec = path_spec.replace(/=/g, ":");
    }

    window.last_search_spec = path_spec;

    $('#suchen').attr("disabled", true);
    $('#suchen').addClass('ui-state-disabled');

    ini_data = "";
    //ini_data += '<html><body><div id="event_movies_results" class="event-movies-results">' + "\n";
    ini_data += '<figure class="loading_block_movies">' + "\n";
    ini_data += '  <div class="loading_image_movies">' + "\n";
    ini_data += '    <img src="{{ uri static_file='_css/tw2011/img/loading_big.gif' }}">' + "\n";
    ini_data += '  </div>' + "\n";
    ini_data += '  <div class="loading_text_movies">' + "\n";
    ini_data += '    Das aktuelle Programm wird geladen.' + "\n";
    ini_data += '  </div>' + "\n";
    ini_data += '</figure>' + "\n";
    //ini_data += '</div></body></html>' + "\n";

    window.set_list_content(ini_data, true);

    $.get(path, {}, function (data, textStatus, jqXHR) {
        //if (path != window.last_search) {
        //    return;
        //}

        window.list_spec['type'] = what_val;
        window.list_spec['date'] = when_val;
        window.list_spec['region'] = where_val;

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

    $("#date_picker_button_new").hide();
    $("#top-calendar").hide();

    $(".nav_one").removeClass("active");
    $("#nav_kino").addClass("active");
});

function load_events(ev_type) {
    return true;
};
</script>
            
        </div>


{{ include file="_tpl/_html-foot.tpl" }}

    </div><!-- / Wrapper -->   

{{* JAVASCRIPT FOOTER *}}
{{* include file="_tpl/_footer_javascript.tpl" *}}
<link rel="stylesheet" href="{{ $view->baseUrl('js/jquery/fancybox/jquery.fancybox-1.3.4.css') }}" type="text/css" media="screen" />
<script type="text/javascript" src="{{ uri static_file='_js/libs/jquery.address.js' }}"></script>
<script type="text/javascript" src="{{ uri static_file='_js/libs/fancybox/jquery.fancybox-1.3.4.pack.js' }}"></script>

</body>
</html>
{{ /if }}
{{ /if }}
