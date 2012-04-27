<div id="hintergrund"></div>
{{ include file="_tpl/_html-head.tpl" }}

<body>
<div id="fb-root"></div>
<script>
  window.fbAsyncInit = function() {
    FB.init({
      appId      : '204329636307540',
      xfbml      : true  // parse XFBML
    });
  };

  // Load the SDK Asynchronously
  (function(d){
     var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
     if (d.getElementById(id)) {return;}
     js = d.createElement('script'); js.id = id; js.async = true;
     js.src = "//connect.facebook.net/en_US/all.js";
     ref.parentNode.insertBefore(js, ref);
   }(document));
</script>

	<div id="wrapper">
        
{{ include file="_tpl/header-omnibox.tpl" }}
        
{{ include file="_tpl/header.tpl" }}
        
        <div id="article-front">
        
            <div class="content-box article-single clearfix">
                
                <section>
                
                    <article>
                        <header>
                            <p>{{ if $gimme->article->type_name == "blog" }}<a href="{{ url options="section" }}">{{ $gimme->section->name }}</a>{{ elseif $gimme->article->type_name == "news" }}{{ if !($gimme->article->dateline == "")}}{{ $gimme->article->dateline }}{{ else }}{{ $gimme->section->name }}{{ /if }}{{ elseif $gimme->article->type_name == "newswire" }}{{ if !($gimme->article->dateline == "")}}{{ $gimme->article->dateline }}{{ else }}{{ $gimme->article->Newslinetext }}{{ /if }}{{ /if }}&nbsp;</p>
                        </header>
                        <h2>{{ $gimme->article->name|replace:'  ':'<br />' }}</h2>
                        <span class="time">{{ $gimme->article->publish_date|camp_date_format:"%e.%c.%Y, %H:%i" }} Uhr {{ if $gimme->article->updated }} (aktualisiert: {{ $gimme->article->updated }}){{ /if }}</span>
                        <h3>{{ if $gimme->article->lede }}{{ $gimme->article->lede|strip_tags }}{{ else }}{{ $gimme->article->DataLead|strip_tags }}{{ /if }} {{ list_article_authors }}{{ if $gimme->current_list->at_beginning }}Von {{ /if }}{{ if $gimme->current_list->at_end }}{{ if $gimme->current_list->index > 1 }} und {{ /if }}{{ else }}{{ if $gimme->current_list->index > 1 }}, {{ /if }}{{ /if }}{{ $gimme->author->name }}{{ if $gimme->current_list->at_end }} {{ /if }}{{ /list_article_authors }}</h3>
                        {{ include file="_tpl/article-figure.tpl" }}

								{{ if $gimme->article->body }}{{ include file="_tpl/admin_frontpageedit.tpl" }}{{ $gimme->article->body }}{{ else }}{{ include file="_tpl/admin_frontpageedit.tpl" }}{{ $gimme->article->DataContent|replace:'h2>':'h4>' }}{{ /if }}

                    </article>
                    
                    {{ include file="_tpl/social-bookmarks.tpl" }}
                
                </section><!-- / Main Section -->
                
                <aside>
                
                    <a href="#" class="grey-button article-switch article-view-rear"><span>Hintergrund zum Artikel</span></a>

{{* ARTICLE TOPICS *}}
{{ list_article_topics }}                
{{ if $gimme->current_list->at_beginning }}
                    <article>                                            
                        <header>
                            <p>Mehr zum Thema</p>
                        </header>
                        <p>
{{ /if }}
                        <a href="{{ url options="template _section/section-topic.tpl" }}">{{ $gimme->topic->name }}</a>{{ if !$gimme->current_list->at_end }}, {{ /if }}
                        {{ if $gimme->current_list->at_end }}
                        {{* include file="_tpl/follow_topics.tpl" view=$view user=$gimme->user *}}
                        </p>
                    </article>                        
{{ /if }}   
{{ /list_article_topics }}                    

{{* RELATED ARTICLES *}}
{{ list_related_articles }}
{{ if $gimme->current_list->at_beginning }}  
                    <article>
                        <header>
                            <p>Verwandte Artikel</p>
                        </header>
{{ /if }}                        
                        <p><strong>{{ if !($gimme->article->short_name == "") }}{{ $gimme->article->short_name }}{{ else }}{{ $gimme->article->name }}{{ /if }}</strong> <time>{{ $gimme->article->publish_date|camp_date_format:"%e.%m.%Y" }}{{ if $gimme->article->updated }} (aktualisiert: {{ $gimme->article->updated }}){{ /if }}</time> <a href="{{ url options="article" }}" class="more">Weiterlesen</a></p>
{{ if $gimme->current_list->at_end }}
                    </article>
{{ /if }}
{{ /list_related_articles }}

{{* MAP - display only if set *}}
{{ if $gimme->article->has_map }}                   
                    <article>
                        <figure>
                        	{{ map show_locations_list="false" show_reset_link=false auto_focus=false width="100%" height="180" }}
                        	{{ list_map_locations }}{{ if $gimme->current_list->at_beginning }}<p>{{ /if }}{{ $gimme->location->name }}{{ if $gimme->current_list->at_end }}</p>{{ else }}, {{ /if }}{{ /list_map_locations }}
                        </figure>
                    </article>
{{ /if }}                    

{{* IF ARTICLE IS PART OF A DOSSIER, SHOW IT *}}
{{ list_related_articles role="child" }}    
{{ if $gimme->article->type_name == "dossier" }}                
                    <article>
                        <figure>
                            <big>Dossier: <br />
                            <b>{{ $gimme->article->name|strip }} {{ $gimme->article->subtitle }}</b></big>
                            <a href="{{ url options="article" }}">{{ include file="_tpl/img/img_300x200.tpl" }}</a>
                        </figure>
                    </article>
{{ /if }} 
{{ /list_related_articles }}                     
                    
{{*** WERBUNG ***}}
{{ include file="_werbung/article-sidebar-1.tpl" }}                    
                    
                    <a href="#" class="grey-button article-switch article-view-rear bottom-align"><span>Hintergrund zum Artikel</span></a>
                
                </aside><!-- / Sidebar -->
                
            </div>
            
            <div class="content-box clearfix">
 
{{ include file="_tpl/article-comments.tpl" }}                  
                
                <aside>

{{*** WERBUNG ***}}                
{{ include file="_werbung/article-sidebar-2.tpl" }}  
                
                </aside>
            
            </div>
        
        </div>
        
        <div id="article-rear">
        
            <div class="content-box article-single clearfix">
                
                <section>
                
                    <article>
                        <header>
                            <p>Informationen zum Artikel</p>
                        </header>
                        <h2>{{ $gimme->article->name|replace:'  ':'<br />' }}</h2>
                        
                        <ul class="article-info">
								{{ list_article_topics }}
                        {{ if $gimme->current_list->at_beginning }}                        
                        	<li>
                            	<h5>Themen</h5>
                            	<p>
                        {{ /if }}
                            	<a href="{{ url options="template section_topic.tpl" }}">{{ $gimme->topic->name }}</a>{{ if !$gimme->current_list->at_end }}, {{ /if }}
                        {{ if $gimme->current_list->at_end }}
                            	</p>
                            </li>                            	
                        {{ /if }}
                        {{ /list_article_topics }}
                        
                        {{ if $gimme->prev_list_empty }}
                        <li><p>Keine Themen verknüpft</p></li>
                        {{ /if }}
        
                            <li>
                            	<h5>veröffentlicht</h5>
                            	<p>{{ $gimme->article->publish_date|camp_date_format:"%e.%c.%Y - %H:%i" }}</p>
                            </li>
                            <li>
                            	<h5>zuletzt geändert</h5>
                            	<p>{{ $gimme->article->last_update|camp_date_format:"%e.%c.%Y - %H:%i" }}</p>
                            </li>
                            {{ if $gimme->article->history != "" }}
                            <li>
                            	<h5>Artikelgeschichte</h5>
                            	<p>{{ $gimme->article->history }}</p>
                            </li>
                            {{ /if }}
                            
                            {{ list_article_attachments }}
									 {{ if $gimme->current_list->at_beginning }}
                            <li>
                            	<h5>Downloads</h5>
                            {{ /if }}
                            	<p><a href="{{ url options="articleattachment" }}">{{ $gimme->attachment->description }}</a> ({{ $gimme->attachment->extension|upper }}, {{ $gimme->attachment->size_kb }}kb)</p>
									 {{ if $gimme->current_list->at_end }}
                            </li>
                            {{ /if }}
                            {{ /list_article_attachments }}                            
                            
                            {{ if $gimme->article->sources != "" }}
                            <li>
                            	<h5>Quellen</h5>
                            	<p>{{ $gimme->article->sources }}</p>
                            </li>
                            {{ /if }}

{{* MAP - display only if set *}}
{{ if $gimme->article->has_map }}                            
                            <li>
                            	<h5>Lokalisierung</h5>
                                {{ map show_locations_list="false" show_reset_link=false auto_focus=false width="511" height="180" }}
                            </li>
{{ /if }}
                            
                        </ul>

{{* ARTICLE AUTHORS *}}
{{ list_article_authors }} 
    {{ $escapedName=str_replace(" ", "\ ", $gimme->author->name) }}
    {{ $numArticles=0  }}
    
    {{ list_articles ignore_publication="true" ignore_issue="true" ignore_section="true" constraints="author is $escapedName"}}
        {{ $numArticles = $numArticles+1 }}
    {{ /list_articles }}
    
    <div class="author-box">
        <h4><span>{{ $gimme->author->type }}:</span> {{ $gimme->author->name }}</h4>
        <ul class="article-info">
            <li class="image">
                {{ if $gimme->author->picture->imageurl }}<img src="{{ $gimme->author->picture->imageurl }}" alt="Portrait {{ $gimme->author->name }}" width=121 />{{ /if }}
                <p>{{ $gimme->author->biography->text }}</p>
            </li>
            <li>
                <h5>Beiträge</h5>
                <p>{{ $numArticles }}</p>
            </li>
            {{ if $gimme->author->user->defined && (!empty($gimme->author->user['facebook']) || !empty($gimme->author->user['twitter'])) }}
            {{ /if }}
        </ul>
    </div>
                                
    {{ include file="_tpl/user-content.tpl" }}
                        
{{ /list_article_authors }}
                                                
                    </article>
                
                </section><!-- / Main Section -->
                
                <aside>
                
                    <a href="#" class="grey-button article-switch article-view-front"><span>Zurück zum Artikel</span></a>

{{* RELATED ARTICLES *}}
{{ list_related_articles }}
{{ if $gimme->current_list->at_beginning }}                     
                    <article>
                        <header>
                            <p>Verwandte Artikel</p>
                        </header>
{{ /if }}                        
                        <p><strong>{{ if !($gimme->article->short_name == "") }}{{ $gimme->article->short_name }}{{ else }}{{ $gimme->article->name }}{{ /if }}</strong> {{ $gimme->article->dateline }} <a href="{{ url options="article" }}" class="more">Weiterlesen</a> <span class="time">{{ $gimme->article->publish_date|camp_date_format:"%e.%m.%Y" }}</span></p>
{{ if $gimme->current_list->at_end }}                        
                    </article>
{{ /if }}      
{{ /list_related_articles }}              
                    
                    <article>
                        <header>
                            <p>Tageswoche honorieren</p>
                        </header>
                        <p>Alle Artikel auf tageswoche.ch sind feri verfügbar. Wenn Ihnen unsere Arbeit etwas wert ist, können Sie uns freiwillig unterstützen. Sie entscheiden wieviel Sie bezahlen. Danke, dass Sie uns helfen, tageswoche.ch in Zukunft besser zu machen.</p>
                    </article>
                    
                    <a href="#" class="grey-button reward-button"><span>Jetzt honorieren!</span></a>
                    {{* pay_what_you_like *}}

{{*** WERBUNG ***}}                    
{{ include file="_werbung/article-sidebar-3-backpage.tpl" }}
                
                    <a href="#" class="grey-button article-switch article-view-front bottom-align"><span>Zurück zum Artikel</span></a>
                
                </aside><!-- / Sidebar -->
                
            </div>
            
        </div>

{{ include file="_tpl/article-bottom-top-news.tpl" }}        
        
    </div><!-- / Wrapper -->
    
     <div id="footer">
    
{{ include file="_tpl/footer-calendar.tpl" }}

{{ include file="_tpl/footer.tpl" }}

    </div><!-- / Footer -->

{{ include file="_tpl/_html-foot.tpl" }}
