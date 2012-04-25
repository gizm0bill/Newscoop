<style type="text/css">
#wann {
    width: 80px !important;
    margin-top: 0px;
    height: 12px;
    background: #fafafa;
}

#wann_middle {
    margin-top: 6px;
}

.ui-datepicker-prev {
    width: 60px !important;
}
.ui-datepicker-next {
    width: 60px !important;
}
</style>

<script type="text/javascript">
/* German initialisation for the jQuery UI date picker plugin. */
/* Written by Milian Wolff (mail@milianw.de). */
jQuery(function($){
  $.datepicker.regional['de'] = {
    closeText: 'schließen',
    prevText: '&#x3c;&nbsp;zurück',
    nextText: 'Vor&nbsp;&#x3e;',
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
    numberOfMonths: 3,
    showMonthAfterYear: false,
    yearSuffix: ''};
  $.datepicker.setDefaults($.datepicker.regional['de']);


  // Datepicker
  var dp = $( ".datepicker" ).datepicker({
    showOn: "button",
    buttonImage: "{{ uri static_file="_css/tw2011/img/calendar.png" }}",
    buttonImageOnly: true
  });

    $("#wann").attr('disabled', true);
    $("#wann_middle").click( function () {
        $(".datepicker").datepicker("show");
    });

    $(".datepicker").datepicker("setDate" , new Date());
    $('#ui-datepicker-div').css('display','none'); // see http://stackoverflow.com/questions/5735888/updating-to-latest-jquery-ui-and-datepicker-is-causing-the-datepicker-to-always-b

    $("#wann").change( function() {
        window.reload();
    });

});
</script>

        <div class="content-box agenda-top">

            <div id="datepicker_single_ul" style="display:none">
                <div id="wann_middle" class="left">
                        <input type="text" value="" id="wann" class="datepicker" style="width:80px;" />
                </div>
            </div>
            <a href="#" id="date_picker_button_new" class="trigger grey-button arrow" style="display:none">Heute, 7.3.</a>
            <div id="top-calendar" class="clearfix" style="display:none'>
            
                <ul class="left">
                    <li><a href="#">Morgen</a></li>
                    <li><a href="#">nächste 7 T.</a></li>
                    <li>
                        <fieldset>
                            <input type="text" />
                            <span>bis</span>
                            <input type="text" />
                        </fieldset>
                    </li>
                    <li>
                        <input type="submit" value="Fertig" class="button" />
                    </li>
                </ul>
            
                <div id="agenda-datepicker"></div>
            
            </div>
            
            <ul class="nav">
{{ local }}
{{* agenda *}}
{{ set_current_issue }}
{{ set_section number="70" }}
                <li id="nav_all" class="nav_one active"><a href="{{ uri options="section" }}">Alles</a></li>
{{* movies *}}
{{ set_current_issue }}
{{ set_section number="72" }}
                <li id="nav_kino" class="nav_one"><a href="{{ uri options="section" }}">Kino</a></li>
{{* events *}}
{{ set_current_issue }}
{{ set_section number="71" }}
                <li id="nav_theater" class="nav_one"><a href="{{ uri options="section" }}#/;type:theater" onClick="return load_events('theater');">Theater</a></li>
                <li id="nav_musik" class="nav_one"><a href="{{ uri options="section" }}#/;type:musik" onClick="return load_events('musik');">Konzerte</a></li>
                <li id="nav_party" class="nav_one"><a href="{{ uri options="section" }}#/;type:party" onClick="return load_events('party');">Partys</a></li>
                <li id="nav_ausstellung" class="nav_one"><a href="{{ uri options="section" }}#/;type:ausstellung" onClick="return load_events('ausstellung');">Ausstellungen</a></li>
                <li id="nav_andere" class="nav_one"><a href="{{ uri options="section" }}#/;type:andere" onClick="return load_events('andere');">Andere</a></li>
{{*
                <!--<li id="nav_restaurants" class="nav_one"><a href="{{ uri options="section" }}restaurants/">Restaurants</a></li>-->
*}}
            </ul>
{{ /local }}
        
        </div>
