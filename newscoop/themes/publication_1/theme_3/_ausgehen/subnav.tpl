<style type="text/css">
#wo {
    border: #cdcdcd solid 1px;
    background-color: #f1f1f1;
    height: 25px;
    width: 136px;
    margin-bottom: 10px;
    height: 28px;
    font-size: 86%;
}

#wann {
    width: 80px !important;
    margin-top: 0px;
    height: 14px;
    background: #fafafa;
    border: 1px inset;
    display: none;
}

#wann_middle {
    margin-top: 6px;
}

#datepicker_single_ul {
    z-index: 600 !important;
}
#ui-datepicker-div {
/*
    top: 234px !important;
*/
    left: 60px !important;
    z-index: 600 !important;
}

.ui-datepicker-prev {
/*
    width: 60px !important;
*/
    width: 30px !important;
}
.ui-datepicker-next {
/*
    width: 60px !important;
*/
    width: 30px !important;
}

.ui-datepicker-group-first {
    margin-left: 11px;
}

.ui-datepicker-trigger {
    display: none;
}
/*
.ui-datepicker-inline-narrow {
    width: 320px !important;
    
}
*/
.top-calendar-narrow {
    width: 322px !important;
}

.agenda-datepicker-narrow {
    width: 320px !important;
}

.place_selector_narrow {
    margin-left: 150px !important;
    margin-top: 12px !important;
}

.place_selector_narrow_alone {
    margin-left: 10px !important;
    margin-top: 12px !important;
}

.nav_events_narrow {
    margin-top: 50px !important;
    margin-left: 10px !important;
}

.nav_events_narrow_alone {
    margin-left: 10px !important;
}

</style>

<script type="text/javascript">
var closing_datepicker_text = 'Fertig';
var desktop_view = true;

function adapt_global_sizes() {
    //var doc_width = $(document).width();
    var doc_width = $(window).width();
    if (769 > doc_width) {
        if (desktop_view) {
            $("#datapicker-button").after($("#wo"));
            if (window.agenda_has_date_picker) {
                $("#wo").addClass("place_selector_narrow");
            }
            else {
                $("#wo").addClass("place_selector_narrow_alone");
            }

            if (window.agenda_has_select_tags) {
                $("#events_nav").addClass("nav_events_narrow");
            }
            else {
                $("#events_nav").addClass("nav_events_narrow_alone");
            }
        }
        desktop_view = false;
    }
    else {
        if (!desktop_view) {
            $("#wo-place").after($("#wo"));
            $("#wo").removeClass("place_selector_narrow");
            $("#events_nav").removeClass("nav_events_narrow");
            $("#events_nav").removeClass("nav_events_narrow_alone");
        }
        desktop_view = true;
    }

};

function get_month_view_count() {
    var month_num = 3;
    var doc_width = $(document).width();
    if (640 > doc_width) {
        month_num = 1;
    }

    if (1 == month_num) {
        $("#agenda-datepicker").addClass("agenda-datepicker-narrow");
        $("#top-calendar").addClass("top-calendar-narrow");
    }
    else {
        $("#agenda-datepicker").removeClass("agenda-datepicker-narrow");
        $("#top-calendar").removeClass("top-calendar-narrow");
    }

    return month_num;
};

var calendar_is_open = false;

function switch_calendar() {
    if (!calendar_is_open) {
        calendar_is_open = true;
        open_calendar();
        return;
    }

    calendar_is_open = false;
    close_calendar();
};

function open_calendar() {
            $("#agenda-datepicker").datepicker("option", "numberOfMonths", get_month_view_count());

/*
            var dateText = $("#wann").val();
            var dateObj = $("#wann").datepicker("getDate");
            $("#wann-picker").val(dateText);
            $("#agenda-datepicker").datepicker("setDate", dateObj);
*/
            update_datepicker_visible();

            //$(this).addClass('active');
            $('#datapicker-button').addClass('active');

            $('#top-calendar').show();
            $('.agenda-top .overlay').fadeIn(500);
/*
            $('#datapicker-button').css('border', '#008148 solid 1px');
            $('#datapicker-button').css('background-color', '#008148');
            $('#datapicker-button').html(closing_datepicker_text);
*/
};

function close_calendar() {
            //$(this).removeClass('active');
            $('#datapicker-button').removeClass('active');

            $('#top-calendar').hide();
            $('.agenda-top .overlay').fadeOut(500);
/*
            $('#datapicker-button').css('border', '#CDCDCD solid 1px');
            $('#datapicker-button').css('background-color', '#F1F1F1');
*/
            $('#datapicker-button').html('');
            update_datepicker_button();
            //$('#datapicker-button').html('Heute, 7.3.');

            var dateText = $("#wann-picker").val();
            var to_reload = false;
            if ($("#wann").val() != dateText) {
                to_reload = true;
            }
            $("#wann").datepicker("setDate", dateText);
            $("#wann").val(dateText);
            //alert($("#wann").val());
            if (to_reload) {
                window.reload();
            }

};

/* German initialisation for the jQuery UI date picker plugin. */
/* Written by Milian Wolff (mail@milianw.de). */
$(document).ready(function() {

    adapt_global_sizes();
    setInterval("adapt_global_sizes();", 2000);

  $.datepicker.regional['de'] = {
    closeText: 'schließen',
//    prevText: '&#x3c;&nbsp;zurück',
//    nextText: 'Vor&nbsp;&#x3e;',
    prevText: '&#x3c;',
    nextText: '&#x3e;',
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
    numberOfMonths: get_month_view_count(),
    showMonthAfterYear: false,
    yearSuffix: ''};
  $.datepicker.setDefaults($.datepicker.regional['de']);

    var todayObj = new Date();
    var mindateObj = new Date();
    mindateObj.setDate(todayObj.getDate() - 30);
    var maxdateObj = new Date();
    maxdateObj.setDate(todayObj.getDate() + 90);

  // Datepicker
  var dp_wann = $("#wann").datepicker({
        minDate: mindateObj,
        maxDate: maxdateObj,
        showOn: "button",
        buttonImage: "{{ uri static_file="_css/tw2011/img/calendar.png" }}",
        buttonImageOnly: true
  });

  //var dp = $(".datepicker").datepicker({});
  var dp = $("#agenda-datepicker").datepicker({
        minDate: mindateObj,
        maxDate: maxdateObj,
        onSelect: function(dateText, inst) {
            $("#wann-picker").val(dateText);
            switch_calendar();
        },
        showOn: "button",
        buttonImage: "{{ uri static_file="_css/tw2011/img/calendar.png" }}",
        buttonImageOnly: true
  });

    //$("#agenda-datepicker").datepicker("minDate", mindateObj);
    //$("#agenda-datepicker").datepicker("maxDate", maxdateObj);

    //$('.agenda-top a.trigger').toggle();
/*
    $('#datapicker-button').toggle(
        function(){
        },
        function(){
        }
    );
*/
    $('#datapicker-button').click( function() { switch_calendar(); return false; });

    $("#wann").attr('disabled', true);

    $("#wann_middle").click( function () {
        $(".datepicker").datepicker("show");
    });

    //$(".datepicker").datepicker("setDate", new Date());
    var date_ini = new Date();
    $("#wann").datepicker("setDate", date_ini);
    $("#datapicker-button").datepicker("setDate", date_ini);
    $("#wann-picker").val(format_day_string(date_ini));

    $('#ui-datepicker-div').css('display','none'); // see http://stackoverflow.com/questions/5735888/updating-to-latest-jquery-ui-and-datepicker-is-causing-the-datepicker-to-always-b

    $("#wann").change( function() {
        window.reload();
    });

    //$("#date_picker_button_new").hide();
    $("#top-calendar").hide();
    //$("#date_picker_button_new").show();
    //$("#top-calendar").show();

    //$("#datepicker_single_ul").show();

});

function update_datepicker_button() {
    if ($('#datapicker-button').html() == closing_datepicker_text) {
        return;
    }

    var chosen_date = $("#wann").val();
    var dateObj = $("#wann").datepicker("getDate");
    var display_date = dateObj.getDate() + "." + (dateObj.getMonth() + 1) + "." + dateObj.getFullYear();

    var testObj = new Date();
    var today_str = format_day_string(testObj);
    testObj.setDate(testObj.getDate() + 1);
    var tommorow_str = format_day_string(testObj);

    if (chosen_date == today_str) {
        display_date = 'Heute, ' + dateObj.getDate() + "." + (dateObj.getMonth() + 1) + ".";
    }
    if (chosen_date == tommorow_str) {
        display_date = 'Morgen, ' + dateObj.getDate() + "." + (dateObj.getMonth() + 1) + ".";
    }

    $('#datapicker-button').html(display_date);
};

function update_datepicker_visible() {
    var dateText = $("#wann").val();
    var dateObj = $("#wann").datepicker("getDate");
    $("#wann-picker").val(dateText);
    $("#agenda-datepicker").datepicker("setDate", dateObj);

    update_datepicker_button();
};

function update_subnav_links(link_date, link_region) {
    var old_link = "";
    var new_link = "";

    var repl_links = [
        "nav_all_link",
        "nav_kino_link", 
        "nav_theater_link",
        "nav_musik_link",
        "nav_party_link",
        "nav_ausstellung_link",
        "nav_andere_link"
    ];
    var repl_count = repl_links.length;

    if (/^(\d){4}-(\d){2}-(\d){2}$/.test(link_date)) {
        for (var dind = 0; dind < repl_count; dind++) {
            var d_ident = "#" + repl_links[dind];

            old_link = $(d_ident).attr("href");
            new_link = old_link.replace(/;date:[\d-]+/i, ";date:"+link_date);
            $(d_ident).attr("href", new_link);
        }
    }

    if (/^[a-zA-Z-]+$/.test(link_region)) {
        for (var rind = 0; rind < repl_count; rind++) {
            var r_ident = "#" + repl_links[rind];

            old_link = $(r_ident).attr("href");
            new_link = old_link.replace(/;region:[a-zA-Z-]+/i, ";region:"+link_region);
            $(r_ident).attr("href", new_link);
        }
    }

};

function highlight_agenda_type(ag_type) {
    $(".nav_one").removeClass("active");

    $("#nav_" + ag_type).addClass("active");
};

function format_day_string(dateObj) {
    var day_str = "00" + dateObj.getDate();
    day_str = day_str.substr(day_str.length - 2, 2);
    var month_str = "00" + (dateObj.getMonth() + 1);
    month_str = month_str.substr(month_str.length - 2, 2);

    var dateText = day_str + '.' + month_str + '.' + dateObj.getFullYear();
    return dateText;
};

function agenda_set_tomorrow() {
    var dateObj = new Date();
    dateObj.setDate(dateObj.getDate() + 1);
/*
    var day_str = "00" + dateObj.getDate();
    day_str = day_str.substr(day_str.length - 2, 2);
    var month_str = "00" + (dateObj.getMonth() + 1);
    month_str = month_str.substr(month_str.length - 2, 2);

    var dateText = day_str + '.' + month_str + '.' + dateObj.getFullYear();
*/
    var dateText = format_day_string(dateObj);
    $("#wann-picker").val(dateText);

    $("#agenda-datepicker").datepicker("setDate", dateText);
    //$("#wann").datepicker("setDate", dateText);

    switch_calendar();
};

function agenda_set_today() {
    var dateObj = new Date();
/*
    var day_str = "00" + dateObj.getDate();
    day_str = day_str.substr(day_str.length - 2, 2);
    var month_str = "00" + (dateObj.getMonth() + 1);
    month_str = month_str.substr(month_str.length - 2, 2);

    var dateText = day_str + '.' + month_str + '.' + dateObj.getFullYear();
*/
    var dateText = format_day_string(dateObj);
    $("#wann-picker").val(dateText);

    $("#agenda-datepicker").datepicker("setDate", dateText);
    //$("#wann").datepicker("setDate", dateText);

    switch_calendar();
};

</script>

        <div class="content-box agenda-top">

            <div id="datepicker_single_ul" style="display:none">
                <div id="wann_middle" class="left">
                        <input type="text" value="" id="wann" class="datepicker_orig" style="width:80px;" />
                </div>
            </div>

            {{ assign var="month_str" $smarty.now|date_format:"%m" }}
            {{ php }}
                $month_str = $template->get_template_vars('month_str');
                $month_str = ltrim($month_str, "0");
                $template->assign('month_str', $month_str);
            {{ /php }}
            <a style="display:none;" id="datapicker-button" href="#" class="trigger grey-button arrow">Heute, {{ $smarty.now|date_format:"%e" }}.{{ $month_str }}.</a>
            <div id="top-calendar" class="clearfix" style="width:644px;height:292px;">
            
                <ul class="left" style="margin-top:20px;">
                    <li style="position:absolute;margin-left:0px;"><a href="#" onClick="agenda_set_today(); return false;">Heute</a></li>
                    <li style="position:absolute;margin-left:60px;"><a href="#" onClick="agenda_set_tomorrow(); return false;">Morgen</a></li>
                    <li style="display:none;">
                        <fieldset>
                            <input id="wann-picker" type="text" disabled="disabled" style="background:#ffffff;" />
                        </fieldset>
                    </li>
                    <li style="display:none;">
                        <input type="submit" value="Fertig" class="button" />
                    </li>
                </ul>
            
                <div id="agenda-datepicker" style="position:absolute;margin-left:-10px;margin-top:50px;margin-bottom:8px;"></div>
            
            </div>

            <ul class="nav" id="events_nav">
{{ local }}
{{* agenda *}}
{{ set_current_issue }}
{{ set_section number="70" }}
                <li id="nav_all" class="nav_one active"><a id="nav_all_link" href="{{ uri options="section" }}#/;date:{{ $smarty.now|camp_date_format:"%Y-%m-%d" }};region:kanton-basel-stadt">Alles</a></li>
{{* movies *}}
{{ set_current_issue }}
{{ set_section number="72" }}
                <li id="nav_kino" class="nav_one"><a id="nav_kino_link" href="{{ uri options="section" }}#/;type:kino;date:{{ $smarty.now|camp_date_format:"%Y-%m-%d" }};region:kanton-basel-stadt">Kino</a></li>
{{* events *}}
{{ set_current_issue }}
{{ set_section number="71" }}
                <li id="nav_theater" class="nav_one"><a id="nav_theater_link" href="{{ uri options="section" }}#/;type:theater;date:{{ $smarty.now|camp_date_format:"%Y-%m-%d" }};region:kanton-basel-stadt;page:1" onClick="return load_events('theater');">Theater</a></li>
                <li id="nav_musik" class="nav_one"><a id="nav_musik_link" href="{{ uri options="section" }}#/;type:musik;date:{{ $smarty.now|camp_date_format:"%Y-%m-%d" }};region:kanton-basel-stadt;page:1" onClick="return load_events('musik');">Konzerte</a></li>
                <li id="nav_party" class="nav_one"><a id="nav_party_link" href="{{ uri options="section" }}#/;type:party;date:{{ $smarty.now|camp_date_format:"%Y-%m-%d" }};region:kanton-basel-stadt;page:1" onClick="return load_events('party');">Partys</a></li>
                <li id="nav_ausstellung" class="nav_one"><a id="nav_ausstellung_link" href="{{ uri options="section" }}#/;type:ausstellung;date:{{ $smarty.now|camp_date_format:"%Y-%m-%d" }};region:kanton-basel-stadt;page:1" onClick="return load_events('ausstellung');">Ausstellungen</a></li>
                <li id="nav_andere" class="nav_one"><a id="nav_andere_link" href="{{ uri options="section" }}#/;type:andere;date:{{ $smarty.now|camp_date_format:"%Y-%m-%d" }};region:kanton-basel-stadt;page:1" onClick="return load_events('andere');">Diverse</a></li>
{{*
                <!--<li id="nav_restaurants" class="nav_one"><a href="{{ uri options="section" }}restaurants/">Restaurants</a></li>-->
*}}
            </ul>
{{ /local }}
        
        </div>
