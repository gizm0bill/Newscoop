{{ include file="_tpl/_html-head.tpl" }}<body>

<style type="text/css">
.image_hidden {
    display: none;
}

.canceled_sign {
/*
    color: #bb2200;
    padding: 4px 8px 4px 8px;
    background-color: #ff8060;
*/
    background: none repeat scroll 0 0 #ff0000;
    color: #FFFFFF;
    font-size: 10px;
    padding: 1px 4px;
    text-transform: uppercase;
}
</style>


        <div id="wrapper">
        
{{ omnibox }}
        
        <div class="content-box top-content-fix clearfix article-page">
    
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

{{* what date should be used; and whether this event is at that date at all *}}
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
{{ if !empty($smarty.get.date) }}
    {{ assign var="usedate" $smarty.get.date|replace:" ":"\\ "|replace:'"':"" }}
{{ /if }}
{{ assign var="usedate_gr" "9999-12-31" }}
{{ assign var="usedate_ls" "0001-01-01" }}

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


{{ if $date_found ne 1 }}
    {{* Date not found! *}}
{{ /if }}

                   
            <div class="wide-title">
                <header>
                    <p>{{ list_article_topics }}{{ $gimme->topic->name }}{{ if $gimme->current_list->at_end }}{{ else }}, {{ /if }}{{ /list_article_topics }}</p>
                    {{ include file="_tpl/article_title_tooltip_box.tpl" }}
                </header>
            </div>
                
                <div id="article-front" class="article-content clearfix">
                <section>
                
                    <article>
                        <h2>{{ strip }}{{ $gimme->article->headline|strip_tags|replace:'\\':'\'' }}{{ /strip }}</h2>
                        {{ if $canceled_date eq 1 }}<p><span class="canceled_sign">Abgesagt</span></p>{{ /if }}
                        {{ if $postponed_date eq 1 }}<p><span class="canceled_sign">Verschoben</span></p>{{ /if }}
                        <p>{{ $usedate_show }}, {{ $date_time_text }} 
                          <strong> {{ if $gimme->article->organizer }}- {{ $gimme->article->organizer|replace:'\\':'\'' }}{{ /if }}{{ if $gimme->article->town }}, {{ $gimme->article->town }}{{ /if }}</strong>
                        </p> 


{{ assign var="more_images" value=0 }}
{{ if $gimme->article->has_image(2) }}
    {{ assign var="more_images" value=1 }}
{{ /if }}

{{* if article has more different pictures, slideshow will be shown with first image as part of it, otherwise just the figure tag is used without ul and li *}}
{{ if $more_images eq 0 }}
    {{ if $gimme->article->has_image(1) }}<figure><img src="{{ url options="image 1" }}" alt="{{ $gimme->article->image1->description }}" /></figure>{{ /if }}
{{ else }}
                        <ul id="article-single-carousel" class="jcarousel-skin-article-single">
      {{ assign var="list_img_rank" 1 }}
      {{ while $gimme->article->has_image($list_img_rank) }}
                            <li {{ if 1 lt $list_img_rank }}class="image_carousel image_hidden"{{ /if }}>
          <figure><img src="{{ url options="image $list_img_rank" }}" /></figure>
          {{ assign var="list_img_rank" $list_img_rank+1 }}
                            </li>
      {{ /while }}
                        </ul>
{{ /if }}


<div class="article-body">
<p>{{ $gimme->article->description }}</p>
{{ if $gimme->article->other }}<p>{{ $gimme->article->other }}</p>{{ /if }}
                        <div class="content-werbung left" style="margin: 0 127px; float: none">
                            <header>
                                <p>Werbung</p>
                            </header>
                            <span class="werbung">
<!-- BEGIN ADITIONTAG -->
<script type="text/javascript" src="http://imagesrv.adition.com/js/adition.js"></script>
<div id="adition_tag_460343"></div>
<!-- END ADITIONTAG -->   
                            </span>
                        </div>
</div>

                    </article>
                    
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
                            <li><a href="{{ url options="section" }}">Zur Veranstaltungsübersicht</a></li>
                            {{ /local }}
                        </ul>
                    </article>                    
                    
{{* MOST POPULAR ARTICLES *}}
{{ include file="_tpl/article_most_popular.tpl" }} 

                </section>

{{* SIDEBAR INFO *}}
                

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

                <aside>
                
                    <article class="event-detail">
                    {{ if $date_found eq 1 }}
                        <p class="tag-list">Datum:
                        <span>{{ $usedate_show }}</span></p>
                    {{ /if }} 
                    {{ if $one_time }}
                        <p class="tag-list">Zeit:
                        <span>{{ $one_time }} Uhr</span></p>
                    {{ /if }}
                    {{ if $gimme->article->street }}
                        <p class="tag-list">Adresse: 
                        <span>{{ $gimme->article->street|regex_replace:"/\"(.*?)\"/":"&#171;$1&#187;" }}, {{ $gimme->article->town }} {{ $gimme->article->zipcode }}</span></p>
                    {{ /if }}
                    {{ if $gimme->article->web }}
                        <p class="tag-list">Web:
                        <span><a href="{{ $gimme->article->web }}">{{ $gimme->article->web }}</a></span></p>
                    {{ /if }}     
                    {{ if $gimme->article->email }}
                        <p class="tag-list">E-Mail:
                        <span><a href="mailto:{{ $gimme->article->email }}">{{ $gimme->article->email }}</a></span></p>
                    {{ /if }}    
                    {{ if $gimme->article->genre }}
                        <p class="tag-list">Genre:
                        <span>{{ $gimme->article->genre|regex_replace:"/\"(.*?)\"/":"&#171;$1&#187;" }}</span></p>
                    {{ /if }}  
                    {{ if $gimme->article->languages }}
                        <p class="tag-list">Languages:
                        <span>{{ $gimme->article->languages|regex_replace:"/\"(.*?)\"/":"&#171;$1&#187;" }}</span></p>
                    {{ /if }}          
                    {{ if !($date_price == "") }}
                        <p class="tag-list">Prices:
                        <span>{{ $date_price|regex_replace:"/\"(.*?)\"/":"&#171;$1&#187;" }}</span></p>
                    {{ /if }}   
                    {{ if $gimme->article->minimal_age }}
                        <p class="tag-list">Minimal age:
                        <span>{{ $gimme->article->minimal_age }}</span></p>
                    {{ /if }}                                                                                                                             
                    </article>
                    
{{* MAP - display only if set *}}
{{ if $gimme->article->has_map }}
                    <article class="location-detail">
                        <p class="small-box-title">Ort der Veranstaltung:</p>
                        <figure>
    {{ map open_map_on_click=true show_open_link="" show_reset_link=false popup_width="1000" popup_height="750" area_show="focus" show_locations_list="false" auto_focus=false width="100%" height="250" }}
                        </figure>
                    </article>
{{ /if }}
                    
                    <article>
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

</body>
</html>
