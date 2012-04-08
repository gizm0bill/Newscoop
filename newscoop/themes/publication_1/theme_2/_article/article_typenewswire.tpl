{{ include file="_tpl/_html-head.tpl" }}<body>

        <div id="wrapper">
{{ dynamic }}
{{ omnibox }}
{{ /dynamic }}
        
        <div class="content-box top-content-fix clearfix article-page">
    
            <div class="top-werbung">
<!-- BEGIN ADITIONTAG -->
<script type="text/javascript" src="http://imagesrv.adition.com/js/adition.js"></script>
<div id="adition_tag_460216"></div>
<!-- END ADITIONTAG -->            
            </div><!-- /.top-werbung -->
    
{{ include file="_tpl/navigation_top.tpl" }}

<div id="main-nav" class="clearfix">

{{ include file="_tpl/navigation.tpl" }}

{{ include file="_tpl/search_box.tpl" }}
</div>  
                   
            <div class="wide-title">
                <header>
                    <p>{{ $gimme->article->keywords }}&nbsp;</p>
                    {{ include file="_tpl/article_title_tooltip_box.tpl" }}
                </header>
            </div>
                
                <div id="article-front" class="article-content clearfix">
                {{* FLIP BUTTON *}}
                <a href="#" id="flip-to-rear" class="flip-button"><span>Rückseite</span></a>
                <section>
                
                    <article class="article-text">
                        <h2>{{ $gimme->article->name|strip_tags }}</h2>
                        <p><small>{{ $gimme->article->last_update|camp_date_format:"%e.%c.%Y, %H:%i" }} Uhr</small></p>
                        <p>  
                          <strong>{{ if $gimme->article->type_name == "news" }}{{ $gimme->article->lede }}{{ elseif $gimme->section->number == 90 }}{{ $gimme->article->NewsLineText }}{{ else }}{{ $gimme->article->DataLead|replace:'h2>':'h4>'|replace:'b>':'h4>' }}{{ /if }}</strong>
                          {{* if $gimme->article->AuthorNames != "" }}{{ $gimme->article->AuthorNames }}, {{ /if }}{{ $gimme->article->NewsProduct }}{{ list_article_authors }}{{ if $gimme->current_list->at_beginning }}{{ if $gimme->author->name != 'ingest' }}{{ if $gimme->article->NewsProduct }}, {{ /if }}{{ /if }}{{ /if }}{{ if $gimme->author->name != 'ingest' }}{{ $gimme->author->name }}{{ if $gimme->current_list->at_end }}{{ else }}, {{ /if }}{{ /if }}{{ /list_article_authors **** CHANGED ACCORDING TO WOBS-987 ON MARCH 6th ****}} 
                          {{ list_article_authors }}{{ if $gimme->current_list->at_beginning }}Von {{ /if }}{{ if $gimme->current_list->at_end }}{{ if $gimme->current_list->index > 1 }} und {{ /if }}{{ else }}{{ if $gimme->current_list->index > 1 }}, {{ /if }}{{ /if }}{{ $gimme->author->name }}{{ if $gimme->current_list->at_end }} {{ /if }}{{ /list_article_authors }}
                        </p> 

{{ assign var="lastimg" value=0 }}
{{ list_article_images }}
{{ if ($gimme->image->article_index gt 11) && ($gimme->image->article_index lt 100) }}{{ assign var="lastimg" value=$gimme->image->article_index }}{{ else }}{{ assign var="lastimg" value=1 }}{{ /if }}
{{ /list_article_images }}

{{* if article has more different pictures, slideshow will be shown with first image as part of it, otherwise just the figure tag is used without ul and li *}}
{{ if $lastimg  gt 1 }}
                        <ul id="article-single-carousel" class="jcarousel-skin-article-single">
                            <li>
{{ /if }} 

{{ if $gimme->article->has_image(1) || $gimme->article->has_image(7)  }}
                                <figure>
{{ include file="_tpl/img/img_555x370.tpl" }}
                                      <p>
{{ if $gimme->article->image->description != "" }}
{{ $gimme->article->image->description }} 
{{ else }}&nbsp;
{{ /if }}
{{ include file="_tpl/image-photographer.tpl" image=$gimme->article->image }}
</p>
                                </figure>
{{ /if }}

{{ if $lastimg  gt 1 }}                                
                            </li>
{{ /if }}

{{ if $lastimg gt 1 }}
{{ list_article_images }}
{{ if ($gimme->article->image->article_index gt 11) & ($gimme->article->image->article_index lt 100)}}                            
                            <li>
                                <figure>
                                        <img src="{{ url options="image width 555 height 370 crop center" }}" width="555" height="370" rel="resizable" alt="{{ $gimme->article->image->description }}">
                                        <p>
{{ if $gimme->article->image->description != "" }}
{{ $gimme->article->image->description }} 
{{ else }}&nbsp;
{{ /if }}
{{ include file="_tpl/image-photographer.tpl" image=$gimme->article->image }}
</p>
                                </figure>
                            </li>
{{ /if }}                            
{{ /list_article_images }}                            
{{ /if }}
{{ if $lastimg gt 1 }}</ul>{{ /if }}

<div class="article-body">
<p>{{ $gimme->article->DataContent|replace:'h2>':'h4>'|replace:'b>':'h4>' }}</p>
{{ if $gimme->section->number == 90 }}
<a href="http://www.swissinfo.ch/eng/index.html" target="_blank"><img alt="Swissinfo" src="{{ uri static_file="_css/tw2011/img/swissinfo.png" }}" /></a>
{{ /if }}
</div>
                        <div class="content-werbung left" style="margin: 0 127px; float: none">
                            <header>
                                <p>Werbung</p>
                            </header>
                            <span class="werbung">

<!-- BEGIN ADITIONTAG -->
<script type="text/javascript" src="http://imagesrv.adition.com/js/adition.js"></script>
<div id="adition_tag_460218"></div>
<!-- END ADITIONTAG -->  

                            </span>
                        </div>

                    </article>                  
                    
{{ include file="_tpl/article_social_box.tpl" }}
              
{{ render file="_tpl/article_comments_listing.tpl" }}

{{* RELATED ARTICLES *}}
{{ list_related_articles }}
{{ if $gimme->current_list->at_beginning }}                    
                    <article>
                        <header>
                            <p>Verwandte Artikel</p>
                        </header>
                      <ul class="details">
{{ /if }}
                                <li>{{ $gimme->article->publish_date|camp_date_format:"%e.%m.%Y" }}: <a href="{{ url options="article" }}">{{ $gimme->article->name }}</a></li>
{{ if $gimme->current_list->at_end }}
                      </ul>  
                    </article>{{ /if }}
{{ /list_related_articles }}                    
                    
{{* LINKS TO FRONT AND SECTION PAGE *}} 
                     <article>
                        <header>                   
                            <p>Mehr entdecken auf TagesWoche.ch</p>
                        </header>
                        <ul class="details">
                            {{ local }}
                            {{ set_current_issue }}
                            <li><a href="{{ url options="issue" }}">Zur Startseite</a></li>
                            <li><a href="{{ url options="section" }}">Zur Übersicht {{ $gimme->section->name }}</a></li>
                            {{ /local }}
                        </ul>
                    </article>                      
  
{{* MOST POPULAR ARTICLES *}}
{{ include file="_tpl/article_most_popular.tpl" }}
          
                </section>
                
                <aside>
                
{{* RELATED ARTICLES *}}
{{ list_related_articles }}
{{ if $gimme->current_list->at_beginning }}                    
                    <article>
                        <header>
                            <p>Verwandte Artikel</p>
                        </header>
                      <ul class="simple-list">
{{ /if }}
                                <li><a href="{{ url options="article" }}">{{ if !($gimme->article->short_name == "") }}{{ $gimme->article->short_name }}{{ else }}{{ $gimme->article->name }}{{ /if }}</a> <time>({{ $gimme->article->publish_date|camp_date_format:"%e.%m.%Y" }})</time></li>
{{ if $gimme->current_list->at_end }}
                      </ul>  
                    </article>{{ /if }}
{{ /list_related_articles }}

{{* MAP - display only if set *}}
{{ if $gimme->article->has_map }}
                    <article>
                        <p class="small-box-title">Ort des Geschehens:</p>

                        <figure>
    {{ map show_locations_list="true" show_reset_link=false width="100%" height="250" auto_zoom=false }}
                        </figure>
                    </article>
{{ /if }}
                    
{{* IF ARTICLE IS PART OF A DOSSIER, SHOW IT *}}
{{ list_related_articles role="child" }} 
    {{ if $gimme->article->type_name == "dossier" }} 
                    <article>
                        <header>
                            <p>Dossier</p>
                        </header>
                        <figure>
                            <a href="{{ url options="article" }}"><big>{{ $gimme->article->name|strip }} {{ $gimme->article->subtitle }}</big></a>
                            <a href="{{ url options="article" }}">{{ include file="_tpl/img/img_300x200.tpl" }}</a>
                        </figure>
                    </article>
    {{ /if }} 
{{ /list_related_articles }}

                    <article>
                        <header>
                            <p>Aktuelle Top-Themen</p>
                        </header>
                        <ul class="simple-list">
{{ list_playlist_articles length="3" id="6" }}                        
                            <li><a href="{{ url options="article" }}">{{ $gimme->article->name }}</a></li>
{{ /list_playlist_articles }}
                        </ul>
                    
                    <article>
                        <header>
                            <p>Werbung</p>
                        </header>
                        <span class="werbung">
<!-- BEGIN ADITIONTAG -->
<script type="text/javascript" src="http://imagesrv.adition.com/js/adition.js"></script>
<div id="adition_tag_460217"></div>
<!-- END ADITIONTAG -->
                        </span>
                    </article>
                
                </aside>
                
            </div><!-- / Front article side -->

            <div id="article-rear" class="article-content clearfix">
            
                <a href="#" id="flip-to-front" class="flip-button rear-side-button"><span>Vorderseite</span></a>
                
                <section>
                
                    <article>
                        <h2>{{ $gimme->article->name|strip_tags }}</h2>
                        <h3>{{ $gimme->article->NewsProduct }} </h3>
                        <p> Autorenkürzel: {{ $gimme->article->AuthorNames }}</p>
                    </article>
                
                    <article>
                        <ul class="author-option-list">
                                <!--<li class="pdf"><a href="http://{{* $gimme->publication->site *}}/{{* article_pdf template="_article/article_pdf.tpl" prefix="TW" *}}">Artikel als PDF herunterladen</a></li>//-->
                                <li class="print"><a title="Artikel drucken" href="#" onclick="window.print();return false" class="print">Drucken</a></li>
                        </ul>
                    </article>
                    
{{ list_related_articles }}
{{ if $gimme->current_list->at_beginning }}                        
                    <article>
                        <header>
                            <p>Verwandte Artikel</p>
                        </header>
                        <ul class="details">          
{{ /if }}                                      
                                <li><time>{{ $gimme->article->publish_date|camp_date_format:"%e.%m.%Y" }}:</time> <a href="{{ url options="article" }}">{{ $gimme->article->name }}</a></li>
{{ if $gimme->current_list->at_end }}                                
                        </ul>
                    </article>                        
{{ /if }}
{{ /list_related_articles }}                        
                    
                    <article>
                        <header>
                            <p>Schwerpunkte des Tages</p>
                        </header>
                        <ul class="simple-list">
{{ list_playlist_articles length="3" id="6" }}                        
                            <li><a href="{{ url options="article" }}">{{ $gimme->article->name }}</a></li>
{{ /list_playlist_articles }}
                        </ul>
                    </article>
                
                </section>
                
                <aside>
                
                        <article>
                        <p class="tag-list">Erstmals ver&ouml;ffentlicht: <br />
                        <span>{{ $gimme->article->publish_date|camp_date_format:"%e.%c.%Y - %H:%i" }}</span></p>
                        <p class="tag-list">Letzte &Auml;nderungen: <br />
                        <span>{{ $gimme->article->last_update|camp_date_format:"%e.%c.%Y - %H:%i" }}</span></p>

                        {{ if $gimme->article->history != "" }}
                        <p class="tag-list">Artikelgeschichte:<br />
                        <span>{{ $gimme->article->history }}</span>
                        </p>
                        {{ /if }}
                        
                        {{ if $gimme->article->sources != "" }}
                        <p class="tag-list">Quellen:<br />
                        <span>{{ $gimme->article->sources }}</span>
                        </p>
                        {{ /if }}
                        
{{ list_article_attachments }}
{{ if $gimme->current_list->at_beginning }}
                        <dl class="simple-def-list">
                                <dt>Dokumente: </dt>
{{ /if }}
                            <dd><a href="{{ url options="articleattachment" }}">
                                {{ $gimme->attachment->description }}
                                ({{ $gimme->attachment->extension|upper }}, {{ $gimme->attachment->size_kb }}kb)
                                </a></dd>
{{ if $gimme->current_list->at_end }}
                        </dl>
{{ /if }}

{{ /list_article_attachments }}
                       
                        {{ if $gimme->article->topics_count > 0 }}
                        <p class="tag-list">Themen:
                        {{ list_article_topics }}
                        <a href="{{ uri options="template section_topic.tpl" }}">{{ $gimme->topic->name }}</a>{{ if !$gimme->current_list->at_end }}, {{ /if }}
                        {{ /list_article_topics }}
                        {{ /if }}
                        
                        {{ if $gimme->user->logged_in }}
                        {{ if $gimme->article->topics_count > 0 }}
                        <br />{{ include file="_tpl/follow_topics.tpl" view=$view user=$gimme->user }}
                        {{ /if }}
                        {{ /if }}

                    </article>
                
                </aside>
                
            </div><!-- / Rear article side -->
       
        </div>

{{* FOOTER *}}
{{ include file="_tpl/footer.tpl" }}

    </div><!-- / Wrapper -->   

{{* JAVASCRIPT FOOTER *}}
{{ include file="_tpl/_footer_javascript.tpl" }}

</body>
</html>
