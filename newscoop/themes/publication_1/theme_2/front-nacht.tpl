{{ include file="_tpl/_html-head.tpl" }}

<body>

  <div id="wrapper">
      
{{ omnibox }}
        
        <div class="content-box top-content-fix clearfix">
    
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
                    <article>
                        <header>
                            <p>Aktuelle Nachrichten</p>
                        </header>
                    </article>
                
        <div class="one-columns top-content-fix bottom-fix news-tickers clearfix">

{{ if intval(date('H')) <= 7 }}{{* show news for latest 10h from 0am to 7am *}}
{{ $datetimeLimit=date_create("-10 hours") }}
{{ else }}{{* show news for latest 6 hours from 7am to 12pm *}}
{{ $datetimeLimit=date_create("-6 hours") }}
{{ /if }}
{{ list_articles length="6" ignore_issue="true" ignore_section="true" order="bypriority asc" constraints="type is newswire section not 90 publish_datetime greater_equal `$datetimeLimit->format('Y-m-d H:i')`" }}

{{ if $gimme->current_list->at_beginning }}
                    <ul>
{{ /if }}                    
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

{{ if $gimme->current_list->at_end }}                       
                    </ul>
{{ /if }}   
{{ /list_articles }}

        <span class="footer-div">
        <a href="{{ local }}{{ set_section number="82" }}{{ url options="section" }}{{ /local }}" class="button right">Weitere News</a>
        </span>
                
                <div class="two-columns clearfix">

                <article>
                    <header>
                        <p>Werbung</p>
                    </header>

                    <span class="werbung">
<!-- BEGIN ADITIONTAG -->
<script type="text/javascript" src="http://imagesrv.adition.com/js/adition.js"></script>
<div id="adition_tag_460061"></div>
<!-- END ADITIONTAG -->
                    </span>              
                </article>

                
{{* COMMUNITY QUOTES *}}
{{ include file="_tpl/communityquotes_front.tpl" }}

                </div>
                
            </section>
            
            <aside>

{{ list_playlist_articles length="3" id="6" }}                
                <article>
                    <header>
                        <p>{{ $gimme->article->dateline }}</p>
                        <small><a href="{{ url options="article" }}#comments">{{ $gimme->article->comment_count }} Kommentare</a></small>
                    </header>
                    <figure>
                        <a href="{{ url options="article" }}">{{ include file="_tpl/img/img_300x200.tpl" }}</a>
                    </figure>
                    <h2><a href="{{ url options="article" }}">{{ $gimme->article->name|replace:'  ':'<br />' }}</a>{{ include file="_tpl/article_title_tooltip_box.tpl" }}
                    {{ include file="_tpl/article_title_tooltip_box.tpl" }}</h2>
                    {{ $gimme->article->teaser|strip_tags }}{{* strip tags to make sure there is no line break between teaser and authors *}}
                    <small><a href="{{ url options="article" }}">Von {{ list_article_authors }}{{ $gimme->author->name }}{{ if $gimme->current_list->at_end}}{{ else }}, {{ /if }}{{ /list_article_authors }}</a></small>
                </article>
{{ /list_playlist_articles }}
                            
            </aside>
        
        </div>

        <div class="content-box clearfix">
                
            <section>

{{* WOCHENDEBATTE teaser for front page *}}
{{ include file="_tpl/debate_front.tpl" }}

{{* ARTICLE FRONT PAGE *}}
{{ list_playlist_articles length="4" id="6" }}
{{ if $gimme->current_list->index == 4 }}
{{ include file="_tpl/list-article-teaser-front.tpl" }}
{{ /if }}
{{ /list_playlist_articles }}

{{* DOSSIER *}}
{{ include file="_tpl/dossier_front.tpl" }}
            
                <article>
                    <header>
                        <p>Werbung</p>
                    </header>
                    <span class="werbung">
<!-- BEGIN ADITIONTAG -->
<script type="text/javascript" src="http://imagesrv.adition.com/js/adition.js"></script>
<div id="adition_tag_460062"></div>
<!-- END ADITIONTAG -->
                    </span>                    
                </article>
                
{{* FOTOBLOG *}}
{{ include file="_tpl/fotoblog_front.tpl" }}

{{* ARTICLE FRONT PAGE *}}
{{ list_playlist_articles length="5" id="6" }}
{{ if $gimme->current_list->index == 5 }}
{{ include file="_tpl/list-article-teaser-front.tpl" }}
{{ /if }}
{{ /list_playlist_articles }}

       
{{* FURTHER FRONT PAGE ARTICLES - use counter to group and cut off previously listed articles *}}

<article>
        <header>
        <p>Weitere Schlagzeilen</p>
    </header>
    <div class="loader" style="height:297px">
        <ul id="themes-carousel" class="jcarousel-skin-quotes">
{{ list_playlist_articles length="14" columns="5" id="6" }}
{{ if $gimme->current_list->index > 5 }}
  {{ if $gimme->current_list->column == 1 }}
      <li>
        <ul class="theme-list">
  {{ /if }}
          <li>
            <p>{{ $gimme->section->name }}
              <a href="{{ url options="article" }}">{{ strip }}
                {{ if $gimme->article->SEO_title|trim !== "" }}
                    {{ $gimme->article->SEO_title|escape:'html'|trim }}
                {{ else }}
                    {{ $gimme->article->name|escape:'html'|trim }}
                {{ /if }}
              {{ /strip }}</a>
            </p>
          </li>
  {{ if ($gimme->current_list->column == 5) || $gimme->current_list->at_end }}
        </ul>
      </li>
  {{ /if }}
{{ /if }}
{{ /list_playlist_articles }}
        </ul>
        <p class="right-align">Weiterblättern</p>
    <div class="loading" style="height:297px"></div></div>
</article>

        <p class="right-align">&nbsp;</p>  
           
{{ list_articles length="1" ignore_issue="true" ignore_section="true" order="byLastUpdate desc" constraints="type is news show_big_map_on_front is on" }}                
                <article>
                        <header>
                        <p>Mapping</p>
                        <a href="#" class="trigger">Open</a>
                    {{ include file="_tpl/article_info_box.tpl" }}
                    </header>{{ include file="_tpl/admin_frontpageedit.tpl" }}
                    <h2><a href="{{ url options="article" }}">{{ $gimme->article->name|replace:'  ':'<br />' }}</a></h2>
                    <p>{{ $gimme->article->lede }}</a></p>
                    <figure>
                        {{ if $gimme->article->has_map }}
                        {{ map show_locations_list="false" width="640" height="280" show_reset_link="false" auto_focus=false }}
                        {{ /if }}
                    </figure>
                </article>
{{ /list_articles }}
                
{{ include file="_tpl/list-blog-teaser-front.tpl" }}
                
            </section>

            
            <aside>

{{* WEATHER WIDGET *}}
                 <article>
                    <header>
                        <p>Wettervorhersagen</p>
                    </header>
                    <div style="text-align: center">
                    {{ include file="_tpl/weather_sidebar.tpl" }}
                    </div>
                </article>

{{* COMMUNITY ACTIVITY STREAM *}}
{{ include file="_tpl/community_activitystream.tpl" }}   

{{* PINNWAND (notice board) *}}
{{ include file="_tpl/noticeboard_announcement.tpl" }}  
                
{{* TWITTER WIDGET *}}
{{ include file="_tpl/twitter_sidebar.tpl" }}
            
{{* PARTNER BUTTONS *}}
{{ include file="_tpl/sidebar_partner_buttons.tpl" }}

{{* BLOG TEASERS *}}
{{ include file="_tpl/sidebar_blog_teaser.tpl" blogpl="Blog teasers - front" }}

{{* LINKS *}}
{{ include file="_tpl/sidebar_links.tpl" linksvar="Front" }}
                
{{* PRINT FRONT PAGE *}}
        {{ include file="_tpl/cover_page.tpl" }}
            
            </aside>
            
        </div>
        
{{* COMMUNITY AVATARS *}}
{{ include file="_tpl/avatars_front.tpl" }}

{{* FOOTER *}}
{{ include file="_tpl/footer.tpl" }}

    </div><!-- / Wrapper -->   

{{* JAVASCRIPT FOOTER *}}
{{ include file="_tpl/_footer_javascript.tpl" }}

</body>

