{{ include file="_tpl/_html-head.tpl" }}
<body>

{{* ELECTIONS 2011 SPEZIAL *}}
{{ assign var="elections" value=121534 }}
{{ if $gimme->article->number == $elections }}
{{ include file="_tpl/spezial/fb-javascript.tpl" }}
{{ /if }}

        <div id="wrapper">
        {{ dynamic }}
        {{ omnibox }}
        {{ /dynamic }}

        <div class="content-box top-content-fix clearfix article-page">
    
            <div class="top-werbung">
{{ if $gimme->section->number == 10 }}
<!-- BEGIN ADITIONTAG -->
<script type="text/javascript" src="http://imagesrv.adition.com/js/adition.js"></script>
<div id="adition_tag_460326"></div>
<!-- END ADITIONTAG -->
{{ /if }}  
{{ if $gimme->section->number == 20 }}
<!-- BEGIN ADITIONTAG -->
<script type="text/javascript" src="http://imagesrv.adition.com/js/adition.js"></script>
<div id="adition_tag_460327"></div>
<!-- END ADITIONTAG -->
{{ /if }}     
{{ if $gimme->section->number == 30 }}
<!-- BEGIN ADITIONTAG -->
<script type="text/javascript" src="http://imagesrv.adition.com/js/adition.js"></script>
<div id="adition_tag_460328"></div>
<!-- END ADITIONTAG -->
{{ /if }}  
{{ if $gimme->section->number == 40 }}
<!-- BEGIN ADITIONTAG -->
<script type="text/javascript" src="http://imagesrv.adition.com/js/adition.js"></script>
<div id="adition_tag_460329"></div>
<!-- END ADITIONTAG -->
{{ /if }}    
{{ if $gimme->section->number == 50 }}
<!-- BEGIN ADITIONTAG -->
<script type="text/javascript" src="http://imagesrv.adition.com/js/adition.js"></script>
<div id="adition_tag_460330"></div>
<!-- END ADITIONTAG -->
{{ /if }}   
            </div><!-- /.top-werbung -->
    
{{ include file="_tpl/navigation_top.tpl" }}

<div id="main-nav" class="clearfix">

{{ include file="_tpl/navigation.tpl" }}

{{ include file="_tpl/search_box.tpl" }}
</div>  
                   
            <div class="wide-title">
                <header>
                    
                    <p>{{ if !($gimme->article-dateline == "") }}{{ $gimme->article->dateline }}{{ else }}{{ $gimme->article->keywords }}{{ /if }}&nbsp;</p>
                    {{ if $gimme->article->comments_enabled }}
                    <small><a href="{{ url options="article" }}#comments">{{ $gimme->article->comment_count }} Kommentar(e)</a></small>
                    {{ /if }}
                    {{ include file="_tpl/article_info_box.tpl" }}
                </header>
            </div>                
                <div id="article-front" class="article-content clearfix">
                {{* FLIP BUTTON *}}
                <a href="#" id="flip-to-rear" class="flip-button"><span>Rückseite</span></a>
                <section>
                
                    <article class="article-text">
                        <h2>{{ $gimme->article->name|replace:'  ':'<br />' }}</h2>
                        <p><small>{{ $gimme->article->publish_date|camp_date_format:"%e.%c.%Y, %H:%i" }} Uhr
                        {{ if $gimme->article->updated }} (aktualisiert: {{ $gimme->article->updated }}){{ /if }}</small></p>
                        <p>
{{ include file="_tpl/admin_frontpageedit.tpl" }}
                          {{ if $gimme->article->lede }}
                          <strong>{{ $gimme->article->lede|strip_tags }}</strong>
                          {{ else }}
                          <strong>{{ $gimme->article->DataLead|strip_tags }}</strong>
                          {{ /if }}
                          {{ list_article_authors }}{{ if $gimme->current_list->at_beginning }}Von {{ /if }}{{ if $gimme->current_list->at_end }}{{ if $gimme->current_list->index > 1 }} und {{ /if }}{{ else }}{{ if $gimme->current_list->index > 1 }}, {{ /if }}{{ /if }}{{ $gimme->author->name }}{{ if $gimme->current_list->at_end }} {{ /if }}{{ /list_article_authors }}
                        </p> 

{{ include file="_tpl/article_figure.tpl" }}

<div class="article-body">
{{ if $gimme->article->body }}
<p>{{ $gimme->article->body }}</p>
{{ else }}
<p>{{ $gimme->article->DataContent|replace:'h2>':'h4>' }}</p>
{{ /if }}

                        <div class="content-werbung left" style="margin: 0 127px; float: none">
                            <header>
                                <p>Werbung</p>
                            </header>
                            <span class="werbung">
{{ if $gimme->section->number == 10 }}
<!-- BEGIN ADITIONTAG -->
<script type="text/javascript" src="http://imagesrv.adition.com/js/adition.js"></script>
<div id="adition_tag_460338"></div>
<!-- END ADITIONTAG -->
{{ /if }}  
{{ if $gimme->section->number == 20 }}
<!-- BEGIN ADITIONTAG -->
<script type="text/javascript" src="http://imagesrv.adition.com/js/adition.js"></script>
<div id="adition_tag_460339"></div>
<!-- END ADITIONTAG -->
{{ /if }}
{{ if $gimme->section->number == 30 }}
<!-- BEGIN ADITIONTAG -->
<script type="text/javascript" src="http://imagesrv.adition.com/js/adition.js"></script>
<div id="adition_tag_460340"></div>
<!-- END ADITIONTAG -->
{{ /if }}
{{ if $gimme->section->number == 40 }}
<!-- BEGIN ADITIONTAG -->
<script type="text/javascript" src="http://imagesrv.adition.com/js/adition.js"></script>
<div id="adition_tag_460341"></div>
<!-- END ADITIONTAG -->
{{ /if }}
{{ if $gimme->section->number == 50 }}
<!-- BEGIN ADITIONTAG -->
<script type="text/javascript" src="http://imagesrv.adition.com/js/adition.js"></script>
<div id="adition_tag_460342"></div>
<!-- END ADITIONTAG -->
{{ /if }}
                            </span>
                        </div>
</div>


                    </article>
                    
{{ include file="_tpl/article_social_box.tpl" }}

<a name="comments"></a>
{{ render file="_tpl/article_comments_listing.tpl" }}

{{* PAY WHAT YOU LIKE *}}

<script src="{{ $view->baseUrl('js/jquery/fancybox/jquery.fancybox-1.3.4.pack.js') }}"></script>

<div class="paywhatyoulike">{{ pay_what_you_like }}</div>




{{* RELATED ARTICLES *}}
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
                
                    <article>
                        {{ list_article_topics }}
                        {{ if $gimme->current_list->at_beginning }}
                        <p class="tag-list">Mehr zum Thema:
                        {{ /if }}

                        <a href="{{ url options="template section_topic.tpl" }}">{{ $gimme->topic->name }}</a>{{ if !$gimme->current_list->at_end }}, {{ /if }}
                        
                        {{ if $gimme->current_list->at_end }}
                        </p>
                        {{ include file="_tpl/follow_topics.tpl" view=$view user=$gimme->user }}
                        {{ /if }}
                        {{ /list_article_topics }}

                        {{ if $gimme->prev_list_empty }}
                        <p class="tag-list">Keine Themen verknüpft</p>
                        {{ /if }}
                     
                    </article>

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

{{* WIDGETS FOR ARTICLE THAT COVERS ELECTIONS SPEZIAL, DECEMBER 2011 *}}
{{ if $gimme->article->number == $elections }}
{{ include file="_tpl/spezial/fb-tw-widgets.tpl" }}
{{ /if }}

{{* MAP - display only if set *}}
{{ if $gimme->article->has_map }}
                    <article>
                        <p class="small-box-title">Ort des Geschehens</p>

                        <figure>
    {{ map show_locations_list="false" show_reset_link=false auto_focus=false width="100%" height="250" }}
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
                    
{{* AKTUELLE TOP-THEMEN *}}
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
{{ if $gimme->section->number == 10 }}
<!-- BEGIN ADITIONTAG -->
<script type="text/javascript" src="http://imagesrv.adition.com/js/adition.js"></script>
<div id="adition_tag_460332"></div>
<!-- END ADITIONTAG -->
{{ /if }}  
{{ if $gimme->section->number == 20 }}
<!-- BEGIN ADITIONTAG -->
<script type="text/javascript" src="http://imagesrv.adition.com/js/adition.js"></script>
<div id="adition_tag_460333"></div>
<!-- END ADITIONTAG -->
{{ /if }}     
{{ if $gimme->section->number == 30 }}
<!-- BEGIN ADITIONTAG -->
<script type="text/javascript" src="http://imagesrv.adition.com/js/adition.js"></script>
<div id="adition_tag_460334"></div>
<!-- END ADITIONTAG -->
{{ /if }}  
{{ if $gimme->section->number == 40 }}
<!-- BEGIN ADITIONTAG -->
<script type="text/javascript" src="http://imagesrv.adition.com/js/adition.js"></script>
<div id="adition_tag_460335"></div>
<!-- END ADITIONTAG -->
{{ /if }}    
{{ if $gimme->section->number == 50 }}
<!-- BEGIN ADITIONTAG -->
<script type="text/javascript" src="http://imagesrv.adition.com/js/adition.js"></script>
<div id="adition_tag_460336"></div>
<!-- END ADITIONTAG -->
{{ /if }}   
                        </span>
                    </article>
                
                </aside>
                
            </div><!-- / Front article side -->
      
            <div id="article-rear" class="article-content clearfix">
            
                <a href="#" id="flip-to-front" class="flip-button rear-side-button"><span>Vorderseite</span></a>
                
                <section>
                
                    <article>

                        <h2>{{ $gimme->article->name }}</h2>
                    </article>
                    
{{* ARTICLE HISTORY *}}
                        <article>
                        <header>
                            <p>Artikelgeschichte:</p>
                        </header>
                        <div style="margin: 15px 0">
                        <small>Erstmals ver&ouml;ffentlicht:</small> <span>{{ $gimme->article->publish_date|camp_date_format:"%e.%c.%Y - %H:%i" }}</span><small style="margin-left: 33px">Letzte &Auml;nderungen:</small> <span>{{ $gimme->article->last_update|camp_date_format:"%e.%c.%Y - %H:%i" }}</span>
                        </div>
                    
                        {{ if $gimme->article->history != "" }}
                        <span>{{ $gimme->article->history }}</span>
                        </p>
                        {{ /if }}
                        </article>

                        {{ if $gimme->article->sources != "" }}
                        <article>
                        <header>
                            <p>Quellen:</p>
                        </header>
                        <p class="tag-list"><span>{{ $gimme->article->sources }}</span></p>
                        </article>
                        {{ /if }}

{{* ARTICLE ATTACHMENTS *}}                        
{{ list_article_attachments }}
{{ if $gimme->current_list->at_beginning }}
                        <article>
                        <header>
                            <p>Dokumente:</p>
                        </header>
                        <dl class="simple-def-list">
                                <dt></dt>
{{ /if }}
                            <dd><a href="{{ url options="articleattachment" }}">
                                {{ $gimme->attachment->description }}
                                ({{ $gimme->attachment->extension|upper }}, {{ $gimme->attachment->size_kb }}kb)
                                </a></dd>
{{ if $gimme->current_list->at_end }}
                        </dl>
                  </article>
{{ /if }}

{{ /list_article_attachments }}

{{* TOPICS *}} 
     
                    <article>
                        {{ list_article_topics }}
                        {{ if $gimme->current_list->at_beginning }}
                        <header>
                            <p>Themen</p>
                        </header>
                        <p>
                        {{ /if }}

                        <a href="{{ url options="template section_topic.tpl" }}">{{ $gimme->topic->name }}</a>{{ if !$gimme->current_list->at_end }}, {{ /if }}
                        
                        {{ if $gimme->current_list->at_end }}
                        </p>
                        {{ include file="_tpl/follow_topics.tpl" view=$view user=$gimme->user }}
                        {{ /if }}
                        {{ /list_article_topics }}

                        {{ if $gimme->prev_list_empty }}
                        <p class="tag-list">Keine Themen verknüpft</p>
                        {{ /if }}
                     
                    </article>

{{* RELATED ARTICLES *}}                
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

{{*                    
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
*}}
                
                </section>
                
                <aside>

{{* ARTICLE AUTHORS *}}
{{ list_article_authors }} 
{{ if $gimme->current_list->at_beginning }}
                    <article>
                        <header>
                                <p>Autoren</p>
                        </header>
                        <ul class="people-list">
{{ /if }}                                            
                          <li>
                            {{ if $gimme->author->user->defined }}
                            <h3><a href="{{ $view->url(['username' => $gimme->author->user->uname], 'user') }}">{{ $gimme->author->name }}</a> ({{ $gimme->author->type }})</h3>
                            {{ else }}
                            <h3><a href="#">{{ $gimme->author->name }}</a> ({{ $gimme->author->type }})</h3>
                            {{ /if }}
                            <figure>
                                    {{ if $gimme->author->picture->imageurl }}<img src="{{ $gimme->author->picture->imageurl }}" alt="Portrait {{ $gimme->author->name }}" width=60/>{{ /if }}
                            </figure>
                            <p>{{ $gimme->author->biography->text|bbcode }} {{ if $gimme->author->user->defined }}<a href="{{ $view->url(['username' => $gimme->author->user->uname], 'user') }}">Alle&nbsp;Artikel&nbsp;und&nbsp;mehr&nbsp;zur&nbsp;Person</a>{{ /if }}</p>
                          </li>
{{ if $gimme->current_list->at_end }}
                        </ul>
                    </article>
{{ /if }}                    
{{ /list_article_authors }}
                
{{* PAY WHAT YOU LIKE *}}
<div style="display: block; margin-bottom: 25px">
<!--img style="float: left; margin-right: 10px" alt="pwyl" src="{{ uri static_file="_css/tw2011/img/thumb_tw-pwyl.png" }}" />
<p><a href="">tageswoche.ch honorieren</a></p-->
<div class="paywhatyoulike">{{ pay_what_you_like }}</div>
</div>     

                    <article>
                        <ul class="author-option-list">
                                <!--<li class="pdf"><a href="http://{{* $gimme->publication->site *}}/{{* article_pdf template="_article/article_pdf.tpl" prefix="TW" *}}">Artikel als PDF herunterladen</a></li>//-->
                                <li class="print"><a title="Artikel drucken" href="#" onclick="window.print();return false" class="print">Drucken</a></li> 
                        </ul>
                    </article>


                        <p class="tag-list">Webcode: <span>{{ $gimme->article->webcode }}</span></p>
                
                </aside>
                
            </div><!-- / Rear article side -->      
        </div>

        <!--<div><a href="{{* url options="template _article/article_smd.tpl" *}}">SMD</a></div>//-->

{{* FOOTER *}}
{{ include file="_tpl/footer.tpl" }}

    </div><!-- / Wrapper -->   

{{* JAVASCRIPT FOOTER *}}
{{ include file="_tpl/_footer_javascript.tpl" }}

</body>
</html>
