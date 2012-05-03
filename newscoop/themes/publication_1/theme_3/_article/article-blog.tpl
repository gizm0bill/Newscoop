{{ include file="_tpl/_html-head.tpl" }}

<body>

{{ include file="_tpl/_netmetrix-stats.tpl" }}

	<div id="wrapper">
        
{{ include file="_tpl/header-omnibox.tpl" }}
        
{{ include file="_tpl/header.tpl" }}

{{ if $gimme->section->number >= "200" }}

			<div class="content-box article-single full-size clearfix">
				<section>
				{{* list_articles length="1" constraints="type is bloginfo" }} 
                  <h2><a href="{{ url options="section" }}">{{ $gimme->article->name }}</a></h2>
            {{ /list_articles *}}
                <article>
                    <header>
                            <p><a href="{{ url options="section" }}">{{ $gimme->section->name }}</a></p>
                    </header>
                    <h2>{{ $gimme->article->name|replace:'  ':'<br />' }}</h2>
                        <span class="time">{{ $gimme->article->publish_date|camp_date_format:"%e.%c.%Y, %H:%i" }} Uhr {{ if $gimme->article->updated }} (aktualisiert: {{ $gimme->article->updated }}){{ /if }}</span>                
                    {{ include file="_tpl/admin_frontpageedit.tpl" }}{{ $gimme->article->body }}
                    {{ list_article_images }}
                    <figure style="margin-bottom: 15px">
                      <img src="{{ uri options="image width 980" }}" rel="resizable" alt="">
                      <p>{{ $gimme->article->image->description }} {{ if $gimme->article->image->photographer != "" }}({{ $gimme->article->image->photographer }}){{ /if }}</p>
                    </figure>
                    {{ /list_article_images }}
                </article>       
 
				</section>
			</div>
			
			<div class="content-box article-single clearfix">            
            <section>
            {{ include file="_tpl/social-bookmarks.tpl" }} 
			   </section>
			</div>
{{ else }}
        
        <div class="content-box article-single clearfix">
            
            <section>

{{ list_articles length="1" constraints="type is bloginfo" }}            
                <article class="featured">
                	  <a href="{{ url options="section" }}">
                    <figure>
                        {{ include file="_tpl/renditions/img_640x280.tpl" }}
                        <big>{{ $gimme->article->name }}</big>
                    </figure>
                    </a>
                </article>
{{ /list_articles }}
                
                <article>
                <header>
                	<p></p>
                </header>
                    <h2>{{ $gimme->article->name }}</h2>
                    <span class="time">{{ $gimme->article->publish_date|camp_date_format:"%e.%m.%Y, %H:%i" }}Uhr</span>                
                    {{ include file="_tpl/article-figure.tpl" }}
                    {{ include file="_tpl/admin_frontpageedit.tpl" }}{{ $gimme->article->body }}
                </article>
            
					 {{ include file="_tpl/social-bookmarks.tpl" }}             
            
            </section><!-- / Main Section -->
            
            <aside>
            
{{ include file="_tpl/sidebar-partnerbuttons.tpl" }}
                
                <article>
                    <header>
                        <p>Aktuell in diesem Blog</p>
                    </header>
                    {{ list_articles length="5" constraints="type is blog" }}
                    <p>{{ if !($gimme->article->number == $gimme->default_article->number) }}<a href="{{ url options="article" }}" style="color: #333"><strong>{{ $gimme->article->name }}</strong></a>{{ else }}<strong>{{ $gimme->article->name }}</strong>{{ /if }} <span class="time">{{ assign var="onedayback" value=$smarty.now-86400 }}
                                {{ assign var="oneback" value=$onedayback|date_format:"%Y-%m-%d" }}
                                {{ if $gimme->article->publish_date lt $oneback }}
{{ $gimme->article->publish_date|camp_date_format:"%e.%m.%Y" }}
                                {{ else }}
{{ $diff=date_diff(date_create('now'), date_create($gimme->article->publish_date)) }}
Vor
{{ if $diff->y }} {{ $diff->y }} {{ if $diff->y > 1 }}Jahre{{ else }}Jahr{{ /if }}{{ /if }}
{{ if $diff->m }} {{ $diff->m }} {{ if $diff->m > 1 }}Monate{{ else }}Monat{{ /if }}{{ /if }}
{{ if $diff->d }} {{ $diff->d }} {{ if $diff->d > 1 }}Tagen{{ else }}Tag{{ /if }}{{ /if }}
{{ if $diff->h && (!$diff->d || empty($short)) }} {{ $diff->h }} Std.{{ /if }}
{{ if !$diff->d && $diff->i && (empty($short) || !$diff->h) }} {{ $diff->i }} Min.{{ /if }}
{{ if !$diff->d && !$diff->h && !$diff->i && $diff->s }} {{ $diff->s }} Sek.{{ /if }}
                                {{ /if }}</span></p>
                    {{ /list_articles }}
                </article>
                
{{ list_article_authors }}                
                <article class="regular-box">                
                	<header>
                    	<p>Autor: {{ include file="_tpl/author-name.tpl" author=$gimme->author }}</p>
                    </header>
                    {{ if $gimme->author->user->defined }}
                    <img src="{{ include file="_tpl/user-image.tpl" user=$gimme->author->user width=120 height=130 }}" width="120" height="130" alt="Portrait {{ $gimme->author->user->uname }}" />
                    {{ if !empty($gimme->author->user['bio']) }}
                    <p>{{ $gimme->author->user['bio']|bbcode }}</p>
                    {{ else }}
                    <p>...</p>
                    {{ /if }}
                    {{ else }}
                    <img src="{{ $gimme->author->picture->imageurl }}" alt="Portrait {{ $gimme->author->name }}" width="120" />
                    <p>{{ $gimme->author->biography->text|bbcode }}</p>
                    {{ /if }}
                </article>
{{ /list_article_authors }}
            
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
{{ if $gimme->map->is_enabled }}                 
                    <article>
                        <figure>
                        	{{ map show_locations_list="false" show_reset_link=false auto_focus=false width="100%" height="180" }}
                        	{{ list_map_locations }}{{ if $gimme->current_list->at_beginning }}<p>{{ /if }}{{ $gimme->location->name }}{{ if $gimme->current_list->at_end }}</p>{{ else }}, {{ /if }}{{ /list_map_locations }}
                        </figure>
                    </article>
{{ /if }}
{{ /if }}
                
{{ include file="_tpl/sidebar-honorieren.tpl" }}
            
            </aside><!-- / Sidebar -->
            
        </div>
        
{{ /if }}        
        
        <div class="content-box clearfix">    
            
{{ include file="_tpl/article-comments.tpl" }} 
            
            <aside>
            
{{*** WERBUNG ***}}
{{ include file="_werbung/article-blog-sidebar.tpl" }} 
            
            </aside>
        
        </div>
        
        <div class="content-box full-width clearfix">
            
            <article>
            	<header class="link-back">
                	<p><a href="{{ url options="issue" }}">Blogs</a></p>
                </header>
                <ul class="post-list">
{{ list_articles length="6" ignore_publication="true" ignore_issue="true" ignore_section="true" order="bypublishdate desc" constraints="type is blog" }}                

{{ $bloginfo=$gimme->article->get_bloginfo() }}

                	<li>
                    	<h4><a href="{{ url options="article" }}">{{ $gimme->article->name }}</a></h4>
                        <p>« {{$gimme->article->body|regex_replace:'#<div class="cs_img".*</div>#U':''|strip_tags|trim|truncate:100:" [...]"}} » <a href="{{ url options="article" }}">Lesen</a> | <a href="{{ url options="section" }}">zum Blog</a></p>
                        <span class="meta">{{ if $bloginfo }}{{ if $gimme->article->get_bloginfo()->image(1)->imageurl }}<img src="{{ $gimme->article->get_bloginfo()->image(1)->imageurl }}" alt="{{ $gimme->section->name }}" width="60" />{{ /if }}{{ /if }} {{ include file="_tpl/relative-date.tpl" date=$gimme->article->publish_date }} auf {{ $gimme->section->name }}</span>
                    </li>

{{ /list_articles }}
                </ul>
                <footer>
                	<a href="{{ url options="issue" }}" class="more">Zur den Blogs»</a>
                </footer>
            </article>
        	
        </div>
        
    </div><!-- / Wrapper -->
    
    <div id="footer">
    
{{ include file="_tpl/footer-calendar.tpl" }}
    
{{ include file="_tpl/footer.tpl" }}

    </div><!-- / Footer -->

{{ include file="_tpl/_html-foot.tpl" }}
