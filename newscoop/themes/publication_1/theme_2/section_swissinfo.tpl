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
                            <p>{{ local }}{{ set_section number="82" }}{{ if !($gimme->section->number == $gimme->default_section->number) }}<a href="{{ uri options="section" }}">Aktuelle Nachrichten</a>{{ else }}Aktuelle Nachrichten{{ /if }} | {{ set_section number="90" }}{{ if !($gimme->section->number == $gimme->default_section->number) }}<a href="{{ uri options="section" }}">English News</a>{{ else }}English News{{ /if }}{{ /local }}</p>
                        </header>
                    </article>
                </div>
                
        <div class="one-columns news-tickers clearfix">
                  <h2>Latest English News</h2>

{{ if $smarty.get.page }}{{ assign var="page" value=$smarty.get.page }}{{ else }}{{ assign var="page" value="1" }}{{ /if }}

{{ list_articles columns="10" length="20" ignore_issue="true" ignore_section="true" constraints="type is newswire section is 90" order="bypublishdate desc" }}
{{ if $gimme->current_list->at_beginning }}                  
<ul id="newswire-articles">
{{ /if }} 
{{ if $gimme->current_list->row == $page }}                   
                      <li>
                          <article>
                                {{ if $gimme->article->has_image(1) }}
                                <figure>
                                    <a href="{{ uri options="article" }}">{{ include file="_tpl/img/img_108x80.tpl" }}</a>
                                </figure>
                                {{ /if }}
                                
{{ $diff=date_diff(date_create('now'), date_create($gimme->article->publish_date)) }}
<small class="date relative">{{ $gimme->section->name }} vor
{{ if $diff->d }} {{ $diff->d }} {{ if $diff->d > 1 }}Tagen{{ else }}Tag{{ /if }}{{ /if }}
{{ if $diff->h && (!$diff->d || empty($short)) }} {{ $diff->h }} Std.{{ /if }}
{{ if !$diff->d && $diff->i && (empty($short) || !$diff->h) }} {{ $diff->i }} Min.{{ /if }}
{{ if !$diff->d && !$diff->h && !$diff->i && $diff->s }} {{ $diff->s }} Sek.{{ /if }}
</small>

                                <h3><a href="{{ uri options="article" }}">{{ $gimme->article->name }}</a></h3>
                                <p>{{ include file="_tpl/admin_frontpageedit.tpl" }}{{ $gimme->article->NewsLineText }} <a href="{{ uri options="article" }}">Weiterlesen</a></p>
                            </article>
                        </li>
{{ /if }}
{{ if $gimme->current_list->at_end }}                       
                    </ul>
{{ /if }}                    
{{ /list_articles }}  
             
{{* pagination. here we repeat the same article list, check which page is active and create links to other pages *}}

{{ list_articles columns="10" length="20" ignore_issue="true" ignore_section="true" constraints="type is newswire section is 90" order="bypublishdate desc" }}
{{ if $gimme->current_list->count gt 10 }}
    {{ if $gimme->current_list->at_beginning }}
                <p class="pagination reverse-border">
    {{ /if }}
    {{ if $gimme->current_list->column == 1 }}
        {{ if $gimme->current_list->row == $page }}
                    <span>{{ $gimme->current_list->row }}</span>
        {{ else }}
            <a href="{{ local }}{{ set_section number="90" }}{{ uri options="section" }}?page={{ $gimme->current_list->row }}{{ /local }}">{{ $gimme->current_list->row }}</a>
        {{ /if }}                    
    {{ /if }}
    {{ if $gimme->current_list->row == $page }}
    {{ if $gimme->current_list->column == 10 || $gimme->current_list->at_end }}
                    <span class="nav right">
                        {{ assign var="prevpage" value=$page-1 }}
                        {{ assign var="nextpage" value=$page+1 }}
                        {{ if $prevpage gt 0 }}<a href="{{ local }}{{ set_section number="90" }}{{ uri options="section" }}?page={{ $prevpage }}{{ /local }}" class="prev">Previous</a>{{ /if }}
                        {{ if $nextpage lt $gimme->current_list->count/10+1 }}<a href="{{ local }}{{ set_section number="90" }}{{ uri options="section" }}?page={{ $nextpage }}{{ /local }}" class="next">Next</a>{{ /if }}
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


            
            <aside>

                    <article>
                        <header>
                            <p>Aktuelle Top-Themen</p>
                        </header>
                        <ul class="simple-list">
{{ list_playlist_articles length="3" id="6" }}                        
                            <li><a href="{{ uri options="article" }}">{{ $gimme->article->name }}</a></li>
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
