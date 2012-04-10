{{ include file="_tpl/_html-head.tpl" }}

<body>

  <div id="wrapper">
      
{{ omnibox }}
        
        <div class="content-box top-content-fix clearfix fokus">
    
            <div class="top-werbung">
<!-- BEGIN ADITIONTAG -->
<script type="text/javascript" src="http://imagesrv.adition.com/js/adition.js"></script>
<div id="adition_tag_460219"></div>
<!-- END ADITIONTAG -->            
            </div>
    
{{ include file="_tpl/navigation_top.tpl" }}

            <div id="main-nav" class="clearfix">

{{ include file="_tpl/navigation.tpl" }}

{{ include file="_tpl/search_box.tpl" }}

            </div>
            
            <section>
              <div class="article-padding">
                    <article>
                        <header>
                            <!-- <p>{{ local }}{{ set_section number="82" }}{{ if !($gimme->section->number == $gimme->default_section->number) }}<a href="{{ url options="section" }}">Aktuelle Nachrichten</a>{{ else }}Aktuelle Nachrichten{{ /if }}{{ /local }} //-->
                            <p>{{ local }}{{ set_section number="82" }}{{ if !($gimme->section->number == $gimme->default_section->number) }}<a href="{{ url options="section" }}">Aktuelle Nachrichten</a>{{ else }}Aktuelle Nachrichten{{ /if }} | {{ set_section number="90" }}{{ if !($gimme->section->number == $gimme->default_section->number) }}<a href="{{ url options="section" }}">English News</a>{{ else }}English News{{ /if }}{{ /local }}</p>
                        </header>
                    </article>

                    {{ $sectionChecked="" }}
                    {{ if !empty($smarty.get.section_no) && in_array($smarty.get.section_no, array("10", "20", "30", "40", "50")) }}
                    {{ $sectionChecked=$smarty.get.section_no }}
                    {{ /if }}
                    <fieldset class="ticker-sort">
                        <ul class="left">
                            <li>
                                <span class="checkbox-placeholder">
                                    <input type="checkbox" id="alle-ressorts" name="alleressorts"{{ if empty($sectionChecked) }} checked="checked"{{ /if }}>
                                    <label for="alle-ressorts">Alle Ressorts</label>
                                </span>
                            </li>
                            <li>
                                <span class="checkbox-placeholder">
                                    <input type="checkbox" id="basel" value="10" name="basel" data-attr="control"{{ if $sectionChecked == "10" }} checked="checked"{{ /if }}>
                                    <label for="basel">Basel</label>
                                </span>
                            </li>
                            <li>
                                <span class="checkbox-placeholder">
                                    <input type="checkbox" id="schweiz" name="schweiz" value="20" data-attr="control"{{ if $sectionChecked == "20" }} checked="checked"{{ /if }}>
                                    <label for="schweiz">Schweiz</label>
                                </span>
                            </li>
                            <li>
                                <span class="checkbox-placeholder">
                                    <input type="checkbox" id="international" name="international" value="30" data-attr="control"{{ if $sectionChecked == "30" }} checked="checked"{{ /if }}>
                                    <label for="international">International</label>
                                </span>
                            </li>
                            <li>
                                <span class="checkbox-placeholder">
                                    <input type="checkbox" id="sport" name="sport" value="40" data-attr="control"{{ if $sectionChecked == "40" }} checked="checked"{{ /if }}>
                                    <label for="sport">Sport</label>
                                </span>
                            </li>
                            <li>
                                <span class="checkbox-placeholder">
                                    <input type="checkbox" id="kultur" name="kultur" value="50" data-attr="control"{{ if $sectionChecked == "50" }} checked="checked"{{ /if }}>
                                    <label for="kultur">Kultur</label>
                                </span>
                            </li>
                        </ul>
                        <span class="nav right">
                          <a class="prev" href="#">< Voheriger Tag</a>
                          <a class="next disable" href="#">Nachster Tag ></a>
                      </span>
                    </fieldset>

                </div>
                
        <div class="one-columns news-tickers clearfix">
                  <h2>Alle Nachrichten des Tages</h2>

{{ if $smarty.get.page }}{{ assign var="page" value=$smarty.get.page }}{{ else }}{{ assign var="page" value="1" }}{{ /if }}

{{ $oneback=date("Y-m-d", time() - $smarty.get.day * 24 * 3600) }}
{{ $oneback_end=date("Y-m-d", time() - $smarty.get.day * 24 * 3600 + 24 * 3600) }}

{{ if !empty($smarty.get.sections) }}
{{ $sections=sprintf("insection is %s", implode("|", $smarty.get.sections)) }}
{{ elseif !empty($sectionChecked) }}
{{ $sections=sprintf("insection is %s", $sectionChecked) }}
{{ /if }}

{{ list_articles columns="20" ignore_issue="true" ignore_section="true" constraints="type is newswire $sections section not 90 publish_date greater_equal $oneback publish_date smaller $oneback_end" order="bypriority asc" }}
{{ if $gimme->current_list->at_beginning }}                  
<ul id="newswire-articles">
{{ /if }}                    

{{ if $gimme->current_list->row == $page }}
                      <li>
                          <article>
                                {{ if $gimme->article->has_image(1) }}
                                <figure>
                                    <a href="{{ url options="article" }}">{{ include file="_tpl/img/img_108x80.tpl" }}</a>
                                </figure>
                                {{ /if }}
                                
{{ $diff=date_diff(date_create('now'), date_create($gimme->article->publish_date)) }}
<small class="date relative">{{ $gimme->section->name }} vor
{{ if $diff->d }} {{ $diff->d }} {{ if $diff->d > 1 }}Tagen{{ else }}Tag{{ /if }}{{ /if }}
{{ if $diff->h && (!$diff->d || empty($short)) }} {{ $diff->h }} Std.{{ /if }}
{{ if !$diff->d && $diff->i && (empty($short) || !$diff->h) }} {{ $diff->i }} Min.{{ /if }}
{{ if !$diff->d && !$diff->h && !$diff->i && $diff->s }} {{ $diff->s }} Sek.{{ /if }}
</small>

                                <h3><a href="{{ url options="article" }}">{{ $gimme->article->NewsLineText }}{{ if !$gimme->article->NewsLineText }}{{ $gimme->article->title }}{{ /if }}</a></h3>
                                <p>{{ include file="_tpl/admin_frontpageedit.tpl" }}{{ $gimme->article->DataLead }} <a href="{{ url options="article" }}">Weiterlesen</a></p>
                            </article>
                        </li>
{{ /if }}

{{ if $gimme->current_list->at_end }}                       
</ul>
{{ /if }}   
{{ /list_articles }}
                 
{{* pagination. here we repeat the same article list, check which page is active and create links to other pages *}}

{{ list_articles columns="20" ignore_issue="true" ignore_section="true" constraints="type is newswire $sections section not 90 publish_date greater_equal $oneback publish_date smaller $oneback_end" }}                
{{ if $gimme->current_list->count gt 20 }}
    {{ if $gimme->current_list->at_beginning }}
                <p class="pagination reverse-border">
    {{ /if }}
    {{ if $gimme->current_list->column == 1 }}
        {{ if $gimme->current_list->row == $page }}
                    <span>{{ $gimme->current_list->row }}</span>
        {{ else }}
            <a href="{{ local }}{{ set_section number="82" }}{{ uri options="section" }}?day={{ $smarty.get.day }}&page={{ $gimme->current_list->row }}{{ /local }}">{{ $gimme->current_list->row }}</a>
        {{ /if }}                    
    {{ /if }}
    {{ if $gimme->current_list->row == $page }}
    {{ if $gimme->current_list->column == 20 || $gimme->current_list->at_end }}
                    <span class="nav right">
                        {{ assign var="prevpage" value=$page-1 }}
                        {{ assign var="nextpage" value=$page+1 }}
                        {{ if $prevpage gt 0 }}<a href="{{ local }}{{ set_section number="82" }}{{ uri options="section" }}?day={{ $smarty.get.day }}&page={{ $prevpage }}{{ /local }}" class="prev">Previous</a>{{ /if }}
                        {{ if $nextpage lt $gimme->current_list->count/20+1 }}<a href="{{ local }}{{ set_section number="82" }}{{ uri options="section" }}?day={{ $smarty.get.day }}&page={{ $nextpage }}{{ /local }}" class="next">Next</a>{{ /if }}
                    </span>
                    {{* <a class="button right" href="#">Alle anzeigen</a> *}}               
    {{ /if }}
    {{ /if }}
    {{ if $gimme->current_list->at_end }}     
                </p>
    {{ /if }}
{{ /if }}
{{ /list_articles }}
                </div>

                
</section>

<script>$(function() {
var day = {{ $smarty.get.day|default:0 }};
var sections = [];
{{ if !empty($sectionChecked) }}sections.push("{{ $sectionChecked }}");{{ /if }}

// set pagination for controlls
var setPagination = function() {
    // pagination
    $('section .pagination a').click(function() {
        var currentPage = parseInt($('span', $(this).closest('.pagination')).first().html());
        if ($(this).hasClass('prev')) {
            var page = currentPage - 1;
        } else if ($(this).hasClass('next')) {
            var page = currentPage + 1;
        } else {
            var page = $(this).html();
        }
        reload(day, page, sections);
        return false;
    });
}

setPagination();

// reload page content by given params
var reload = function(day, page, sections) {
    // update page
    $.get("{{ local }}{{ set_section number="82" }}{{ url options="section" }}{{ /local }}", {
            'page': page,
            'sections': sections,
            'day': day
        }, function (data, textStatus, jqXHR) {
        var dom = $(data);

        $('section .news-tickers').html($('section .news-tickers', dom).html());
        setPagination();

        window.set_cufon_fonts();
        Cufon.now();
    });
};

// prev next day buttons
$('.ticker-sort .prev, .ticker-sort .next').click(function() {
    if ($(this).hasClass('next')) {
        day--;
        if (day < 0) { // out of range
            $(this).addClass('disable');
            day = 0;
            return;
        } else if (day == 0) {
            $(this).addClass('disable');
        }
    } else {
        $('.next', $(this).closest('.ticker-sort')).removeClass('disable');
        day++;
    }

    reload(day, 1, sections);
    return false;
});

// topics select
$('.ticker-sort input:checkbox').not('#alle-ressorts').change(function() {
    section = $(this).attr('value');
    if (this.checked) {
        sections.push(section);
        $('#alle-ressorts').removeAttr('checked');
    } else {
        sections.splice(sections.indexOf(section), 1);
        if (!$('.ticker-sort input:checkbox:checked').size()) {
            $('#alle-ressorts').attr('checked', 'checked');
        }
    }

    reload(day, 1, sections);
    return false;
});

// topics all switch
$('.ticker-sort #alle-ressorts').change(function() {
    if (this.checked) {
        $('.ticker-sort input:checkbox:checked').not($(this)).removeAttr('checked', null);
        sections = [];
        reload(day, 1, sections);
    } else {
        $(this).attr('checked', 'checked');
    }
    return false;
});

});</script>
            
            <aside>

                    <article>
                        <header>
                            <p>Aktuelle Top-Themen</p>
                        </header>
                        <ul class="simple-list">
{{ list_playlist_articles length="3" id="6" }}                        
                            <li><a href="{{ url options="article" }}">{{ $gimme->article->name }}</a></li>
{{ /list_playlist_articles }}
                        </ul>
                    </article>
                
                <article>
                    <header>
                        <p>Werbung</p>
                    </header>
                    <span class="werbung">
<!-- BEGIN ADITIONTAG -->
<script type="text/javascript" src="http://imagesrv.adition.com/js/adition.js"></script>
<div id="adition_tag_460220"></div>
<!-- END ADITIONTAG -->
                    </span>
                </article>
                            
            </aside>
        
        </div>

{{ include file="_tpl/footer.tpl" }}

    </div><!-- / Wrapper -->   

{{* JAVASCRIPT FOOTER *}}
{{ include file="_tpl/_footer_javascript.tpl" }}

</body>
</html>
