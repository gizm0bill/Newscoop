{{ include file="_tpl/_html-head.tpl" }}
<script type="text/javascript">
window.agenda_has_select_tags = false;
window.agenda_has_date_picker = false;
</script>

<link rel="canonical" href="{{ uri options="article" }}" />
{{*
<script type="text/javascript">
$(document).ready(function() {
    var canonical = $("link[rel=canonical]").attr("href");
    //alert(canonical);
});
</script>
*}}
<body>

{{ include file="_tpl/_netmetrix-stats.tpl" }}

    <div id="wrapper">

{{ include file="_tpl/header-omnibox.tpl" }}

{{ include file="_tpl/header.tpl" }}

{{ include file="_ausgehen/subnav.tpl" }}

{{ assign var="region_name" "Kanton Basel-Stadt" }}
{{ assign var="region_link" "kanton-basel-stadt" }}
{{ assign var="event_type_name" "Alles" }}
{{ assign var="event_type_link" "all" }}

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

    {{ elseif "Theater Veranstaltung" eq $cur_topic }}
        {{ assign var="event_type_link" "theater" }}
        {{ assign var="event_type_name" "Theater" }}
    {{ elseif "Musik Veranstaltung" eq $cur_topic }}
        {{ assign var="event_type_link" "musik" }}
        {{ assign var="event_type_name" "Konzerte" }}
    {{ elseif "Party Veranstaltung" eq $cur_topic }}
        {{ assign var="event_type_link" "party" }}
        {{ assign var="event_type_name" "Party" }}
    {{ elseif "Ausstellung Veranstaltung" eq $cur_topic }}
        {{ assign var="event_type_link" "ausstellung" }}
        {{ assign var="event_type_name" "Ausstellungen" }}
    {{ elseif "Andere Veranstaltung" eq $cur_topic }}
        {{ assign var="event_type_link" "andere" }}
        {{ assign var="event_type_name" "Andere" }}

    {{ /if }}
{{ /list_article_topics }}

{{*
RN-{{ $region_name }}-RN
RL-{{ $region_link }}-RL

ETN-{{ $event_type_name }}-ETN
ETL-{{ $event_type_link }}-ETL
*}}

{{ php }}
function get_display_date($usedate)
{
    $usedate_show = '';

    $usedate_arr = explode('-', $usedate);
    if (3 == count($usedate_arr)) {
        $usedate_show .= ltrim($usedate_arr[2]);
        $usedate_show .= '.';
        $usedate_show .= ltrim($usedate_arr[1]);
        $usedate_show .= '.';
        $usedate_show .= ltrim($usedate_arr[0]);
    }

    return $usedate_show;
}

function get_display_date_time($date_time_text)
{
    return trim(strip_tags($date_time_text));
}

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

function get_voided_state($multi_void_text, $req_date)
{
    $req_date = trim($req_date);
    if (empty($req_date)) {
        return false;
    }

    $cur_date = null;

    $multi_void_text = strip_tags(str_replace(array('<'), array("\n<"), $multi_void_text));
    foreach (explode("\n", $multi_void_text) as $one_date_void_str) {
        $one_date_void_str = trim($one_date_void_str);
        if (empty($one_date_void_str)) {
            continue;
        }

        $matches = array();
        if (preg_match('/^(\d{4})-(\d{2})-(\d{2})$/', $one_date_void_str, $matches)) {
            // new date
            $cur_date = $one_date_void_str;

            if ($cur_date == $req_date) {
                return true;
            }
        }
    }

    return false;
}
{{ /php }}

{{ assign var="date_found" 0 }}
{{ assign var="date_found_gr" 0 }}
{{ assign var="date_found_ls" 0 }}
{{ assign var="curdate" $smarty.now|camp_date_format:"%Y-%m-%d" }}
{{ assign var="usedate" $curdate }}
{{ assign var="usedate_link" $usedate }}
{{ if !empty($smarty.get.date) }}
    {{ assign var="usedate" $smarty.get.date|replace:" ":"\\ "|replace:'"':"" }}
{{ /if }}
{{ assign var="usedate_gr" "9999-12-31" }}
{{ assign var="usedate_ls" "0001-01-01" }}

{{ assign var="usedate_test" $usedate|regex_replace:"/(\d){4}-(\d){2}-(\d){2}/":"ok" }}
{{ if "ok" != $usedate }}
    {{ if "ok" == $usedate_test }}
        {{ assign var="usedate_link" $usedate }}
    {{ /if }}
{{ /if }}

{{ assign var="cur_date_rank" 0 }}
{{ foreach from=$gimme->article->dates item="date_cur" }}
  {{ if "schedule" eq $date_cur->field_name }}

    {{ assign var="cur_date_rank" $cur_date_rank+1 }}
    {{ assign var="one_date" $date_cur->start_date }}
    {{ assign var="one_date" $one_date|camp_date_format:"%Y-%m-%d" }}
    {{ if $one_date == $usedate }}
        {{ assign var="date_found" 1 }}
    {{ /if }}

    {{ if $one_date > $usedate }}
        {{ if $one_date < $usedate_gr }}
            {{ assign var="usedate_gr" $one_date }}
            {{ assign var="date_found_gr" 1 }}
        {{ /if }}
    {{ /if }}

    {{ if $one_date < $usedate }}
        {{ if $one_date > $usedate_ls }}
            {{ assign var="usedate_ls" $one_date }}
            {{ assign var="date_found_ls" 1 }}
        {{ /if }}
    {{ /if }}

  {{ /if }}
{{ /foreach }}

{{ if $date_found eq 0 }}
    {{ if $date_found_gr eq 0 }}
        {{ if $date_found_ls eq 1 }}
            {{ assign var="usedate" $usedate_ls }}
            {{ assign var="date_found" 1 }}
        {{ /if }}
    {{ else }}
        {{ assign var="usedate" $usedate_gr }}
        {{ assign var="date_found" 1 }}
    {{ /if }}
{{ /if }}

{{ assign var="voided_date" 0 }}
{{ assign var="postponed_date" 0 }}
{{ foreach from=$gimme->article->dates item="date_cur" }}
  {{ assign var="date_cur_start_date" $date_cur->start_date|camp_date_format:"%Y-%m-%d" }}

  {{ if $usedate eq $date_cur_start_date }}
    {{ if "voided" eq $date_cur->field_name }}
      {{ assign var="voided_date" 1 }}
    {{ /if }}
    {{ if "postponed" eq $date_cur->field_name }}
      {{ assign var="postponed_date" 1 }}
    {{ /if }}
  {{ /if }}
{{ /foreach }}

{{ assign var="one_time" "" }}
{{ assign var="multi_time_text" $gimme->article->multi_time|replace:"&nbsp;":" " }}


{{ assign var="usedate_show" "" }}
{{ assign var="date_time_text" $gimme->article->date_time_text }}
{{ php }}
    $req_date = $template->get_template_vars('usedate');
    $req_date_found = 0 + $template->get_template_vars('date_found');

    $date_time_text = '' . $template->get_template_vars('date_time_text');
    $date_time_text = get_display_date_time($date_time_text);
    $template->assign('date_time_text', $date_time_text);

    if ($req_date_found) {

        $req_date_show = get_display_date($req_date);
        $template->assign('usedate_show', $req_date_show);

    }

    //$req_date = $template->get_template_vars('usedate');
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

{{ php }}
    $one_time = '' . $template->get_template_vars('one_time');
    $date_time_text = '' . $template->get_template_vars('date_time_text');
    if (6 > strlen($date_time_text)) {
        if (!empty($one_time)) {
            $date_time_text = $one_time;
        }
        $date_time_text .= ' Uhr';
        $template->assign('date_time_text', $date_time_text);
    }
{{ /php }}

{{ assign var="canceled_date" 0 }}
{{ if $voided_date eq 1 }}
  {{ if $date_found eq 1 }}
      {{ assign var="canceled_date" 1 }}
  {{ /if }}
{{ /if }}


{{ php }}

function get_price_text($multi_price_text, $req_date)
{
    $req_date = trim($req_date);
    if (empty($req_date)) {
        return '';
    }

    $price = array();

    $cur_date = null;

    $multi_price_text = strip_tags(str_replace(array('<'), array("\n<"), $multi_price_text));
    foreach (explode("\n", $multi_price_text) as $one_date_price_str) {
        $one_date_price_str = trim($one_date_price_str);
        if (empty($one_date_price_str)) {
            continue;
        }

        $matches = array();
        if (preg_match('/^(\d{4})-(\d{2})-(\d{2})$/', $one_date_price_str, $matches)) {
            // new date
            $cur_date = $one_date_price_str;

            if ($cur_date == $req_date) {
                $price = array();
            }

            continue;
        }

        if (null !== $cur_date) {
            if ($cur_date != $req_date) {
                continue; // only taking prices of specified date, or of overall info
            }
        }

        $price[] = $one_date_price_str;

    }

    $price_str = implode("\n<br />\n", $price);

    return $price_str;
}

{{ /php }}

{{ assign var="multi_price_text" $gimme->article->prices|replace:"&nbsp;":" " }}
{{ assign var="date_price" "" }}

{{ php }}
    $req_date = $template->get_template_vars('usedate');
    $req_date_found = 0 + $template->get_template_vars('date_found');

    if ($req_date_found) {

        $multi_price_text = $template->get_template_vars('multi_price_text');
        $date_time_arr = get_display_date($date_time_str);

        $date_price = get_price_text($multi_price_text, $req_date);
        $date_price = trim($date_price);

        if (!empty($date_price)) {
            $template->assign('date_price', $date_price);
        }

    }
{{ /php }}

<script type="text/javascript">
$(document).ready(function() {
    update_subnav_links("{{ $usedate_link }}", "{{ $region_link }}");

    highlight_agenda_type("{{ $event_type_link }}");
});

function load_events(ev_type) {
    return true;
};
</script>

        <div class="content-box clearfix agenda-content agenda-single">

            <section>

{{ local }}
{{ set_current_issue }}
{{ set_section number="71" }}
                <header class="mobile-header">
                        <p><a href="{{ uri options="section" }}#/;type:{{ $event_type_link }};date:{{ $usedate_link }};region:{{ $region_link }};page:1" class="grey-button back-button">Zurück zur Veranstaltungen</a></p>
                </header>
{{ /local }}

                <article class="event {{ if $canceled_date eq 1 }}off{{ /if }}">

                    <h2>{{ $gimme->article->headline|replace:'\\':'\'' }}{{ if $canceled_date eq 1 }} <small>abgesagt</small>{{ /if }}{{ if $postponed_date eq 1 }} <small>verschoben</small>{{ /if }}</h2>

                    <ul class="top-list-details">
{{*
                        <li class="buy-button"><a href="#" class="grey-button">Ticket kaufen </a></li>
*}}
{{ if $gimme->article->genre }}
                        <li><span>Genre:</span>{{ $gimme->article->genre|regex_replace:"/\"(.*?)\"/":"&#171;$1&#187;" }}</li>
{{ /if }}
{{ if ($gimme->article->town || $gimme->article->organizer) }}
                        <li><span>Wo:</span>{{ if $gimme->article->organizer }} {{ $gimme->article->organizer|replace:'\\':'\'' }}{{ if $gimme->article->town }},{{ /if }}{{ /if }}{{ if $gimme->article->town }} {{ $gimme->article->town }}{{ /if }}</li>
{{ /if }}
{{ if $date_found eq 1 }}
                        <li><span>Wann:</span> {{ $usedate_show }}{{ if $one_time }}, {{ $one_time|replace:".":":" }} Uhr{{ /if }}</li>
{{ /if }}
{{ if !($date_price == "") }}
                        <li><span>Preise:</span> {{ $date_price|regex_replace:"/\"(.*?)\"/":"&#171;$1&#187;" }}</li>
{{ /if }}
{{ if $gimme->article->minimal_age }}
                        <li><span>Mindestalter:</span> {{ $gimme->article->minimal_age }}</li>
{{ /if }}
{{ if $gimme->article->languages }}
                        <li><span>Sprache:</span> {{ $gimme->article->languages|regex_replace:"/\"(.*?)\"/":"&#171;$1&#187;" }}</li>
{{ /if }}
                    </ul>
                    <p>
                    {{ $gimme->article->description }}
                    </p>
{{ if $gimme->article->other }}
                    <p>
                    {{ $gimme->article->other|replace:"<a href=":"<a target='_blank' href="|replace:">http://":">" }}
                    </p>
{{ /if }}
                </article>

                {{ include file="_tpl/social-bookmarks.tpl" }}

            </section>

            <aside>
            
{{ local }}
{{ set_current_issue }}
{{ set_section number="71" }}
                <div class="mobile-hide">
                <a href="{{ uri options="section" }}#/;type:{{ $event_type_link }};date:{{ $usedate_link }};region:{{ $region_link }};page:1" class="grey-button back-button"><span>Zurück zur Veranstaltungen</span></a>
                </div>
{{ /local }}
                
{{ if $gimme->article->has_image(1) }}
                <article>
                    <header></header>
                    <img src="{{ url options="image 1 width 300" }}" alt="{{ $gimme->article->image1->description|replace:'"':'\'' }}" />
                </article>
{{ /if }}
                
                <article class="contact-info">
                    <header></header>
{{ if $gimme->article->organizer }}
                    <h4>{{ $gimme->article->organizer|replace:'\\':'\'' }}</h4>
{{ /if }}
{{ if $gimme->article->town }}
                    <p>{{ if $gimme->article->street }}{{ $gimme->article->street|regex_replace:"/\"(.*?)\"/":"&#171;$1&#187;" }},{{ /if }} {{ $gimme->article->zipcode }} {{ $gimme->article->town }}</p>
{{ /if }}
{{ if $gimme->article->phone }}
                    <p>{{ $gimme->article->phone }}<br />
{{ /if }}
{{ if $gimme->article->email }}
                    <a href="mailto:{{ $gimme->article->email }}">{{ $gimme->article->email }}</a><br />
{{ /if }}
{{ if $gimme->article->web }}
                    <a href="{{ $gimme->article->web }}" target="_blank">{{ $gimme->article->web|replace:"http://":"" }}</a></p>
{{ /if }}
                    {{ list_article_locations length="1" }}
                    <figure>
                        <div class="map-holder"><iframe width="304" height="180" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="http://maps.google.com/maps?hl=de&q={{ $gimme->location->latitude }},{{ $gimme->location->longitude }}+({{ $gimme->article->organizer|escape:'url' }})&ll={{ $gimme->location->latitude }},{{ $gimme->location->longitude }}&hnear={{ $gimme->article->town|escape:'url' }},+Switzerland&t=m&ie=UTF8&z=16&output=embed"></iframe></div>
{{*
                        <div class="map-holder"><iframe width="304" height="180" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="http://maps.google.com/maps?f=q&amp;source=s_q&amp;hl=de&amp;geocode=&amp;q={{ $gimme->location->latitude }},{{ $gimme->location->longitude }}+({{ $gimme->article->organizer|escape:'url' }})&amp;ll={{ $gimme->location->latitude }},{{ $gimme->location->longitude }}&amp;t=m&amp;ie=UTF8&amp;&amp;z=13&amp;output=embed"></iframe></div>
                        <div class="map-holder"><iframe width="304" height="180" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="http://maps.google.com/maps?f=q&amp;source=s_q&amp;hl=de&amp;geocode=&amp;q={{ $gimme->location->latitude }},{{ $gimme->location->longitude }}+({{ $gimme->article->organizer|escape:'url' }})&amp;t=m&amp;ie=UTF8&amp;hq=&amp;hnear={{ $gimme->article->town|escape:'url' }},+Switzerland&amp;z=13&amp;output=embed"></iframe></div>
                        <div class="map-holder"><iframe width="304" height="180" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="http://maps.google.com/maps?f=q&amp;source=s_q&amp;hl=de&amp;geocode=&amp;q=basel&amp;sll=37.0625,-95.677068&amp;sspn=46.36116,112.412109&amp;t=m&amp;ie=UTF8&amp;hq=&amp;hnear=Basle,+Basel-Stadt,+Switzerland&amp;z=13&amp;ll=47.557421,7.592573&amp;output=embed"></iframe></div>
*}}
                    </figure>
                    {{ /list_article_locations }}
                </article>
                
                <article class="mobile-hide">
                    <header>
                        <p><em>Werbung</em></p>
                    </header>
                    <span class="werbung">
<!-- BEGIN ADITIONTAG -->
<script type="text/javascript" src="http://imagesrv.adition.com/js/adition.js"></script>
<div id="adition_tag_460337"></div>
<!-- END ADITIONTAG -->
                    </span>
                </article>
            
            </aside>
        	
        </div>
        
    </div><!-- / Wrapper -->

    <div id="footer">

{{ include file="_tpl/footer.tpl" }}

    </div><!-- / Footer -->

{{ include file="_tpl/_html-foot.tpl" }}
