{{ include file="_tpl/_html-head.tpl" }}

<body>

{{ include file="_tpl/_netmetrix-stats.tpl" }}

	<div id="wrapper">
        
{{ include file="_werbung/front-blogs-header.tpl" }}        
        
{{ include file="_tpl/header-omnibox.tpl" }}
        
{{ include file="_tpl/header.tpl" }}
        
        <div class="content-box clearfix">
            
            <section>
            
            	<header class="mobile-header">
                	<p><a href="{{ url options="issue" }}">Blogs</a></p>
                </header>

{{ list_articles length="1" constraints="type is bloginfo" }}            
            	<article class="featured">
                    <figure>
                    		{{ include file="_tpl/renditions/img_640x280.tpl" }}
                        <big>{{ $gimme->article->name }}</big>
                    </figure>
                    <p>{{ strip }}{{ $gimme->article->infolong|strip_tags }}{{ /strip }}</p>
                </article>
                {{ assign var="seclike" value=0 }}
                {{ if $gimme->article->section_like }}
                {{ assign var="seclike" value=1 }}
                {{ /if }}                
{{ /list_articles }}

{{ if $gimme->section->number gte 200 }}
{{ list_articles length="7" constraints="type is blog" }}
								<article>
                        <header>
                            <p>{{ assign var="onedayback" value=$smarty.now-86400 }}
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
                                {{ /if }}</p>
                        </header>
								<h2>{{ include file="_tpl/admin_frontpageedit.tpl" }}<a href="{{ url options="article" }}">{{ $gimme->article->name|replace:'  ':'<br />' }}</a></h2>
                        {{ list_article_images length="1" }}
                        <a href="{{ url options="article" }}"><img alt="{{ $gimme->article->image->description }}" src="{{ url options="image width 640" }}" rel="resizable" /></a>
                        {{ /list_article_images }} 
                    </article>
{{ if $gimme->current_list->at_end }}                
                    <ul class="paging content-paging">
                    		{{ if $gimme->current_list->has_previous_elements }}
                        <li><a class="grey-button prev" href="{{ unset_article }}{{ url options="previous_items" }}">«</a></li>{{ /if }}
                        <li class="caption"></li>
                        {{ if $gimme->current_list->has_next_elements }}
                        <li><a class="grey-button next" href="{{ unset_article }}{{ url options="next_items" }}">»</a></li>{{ /if }}
                    </ul>
{{ /if }} 
{{ /list_articles }} 
                    
{{ elseif $seclike == 1 }}

{{ list_articles length="7" constraints="type is blog" }}						  
				<div class="mobile-list-view clearfix">             
                    <article>
                        <header>
                        {{ if $gimme->article->comment_count gt 0 }}<a class="comments" href="{{ url options="article" }}#comments">{{ $gimme->article->comment_count }}</a>{{ /if }}
                            <p>{{ assign var="onedayback" value=$smarty.now-86400 }}
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
                                {{ /if }}</p>
                        </header>
                                                      
                        <figure class="left">
                            <a href="{{ url options="article" }}">{{ include file="_tpl/renditions/img_300x200.tpl" }}</a>
                        </figure>                        
                        <h2><a href="{{ url options="article" }}">{{ $gimme->article->name|replace:'  ':'<br />' }}</a></h2>
                        <p>{{ include file="_tpl/admin_frontpageedit.tpl" }}{{ if !($gimme->article->lede|strip_tags:false|strip == "") }}{{ $gimme->article->lede|strip_tags }}{{ else }}{{ $gimme->article->body|strip_tags:false|strip|truncate:200 }}{{ /if }} {{ list_article_authors }}{{ if $gimme->current_list->at_beginning }}Von {{ /if }}{{ if $gimme->current_list->at_end }}{{ if $gimme->current_list->index > 1 }} und {{ /if }}{{ else }}{{ if $gimme->current_list->index > 1 }}, {{ /if }}{{ /if }}{{ include file="_tpl/author-name.tpl" author=$gimme->author }}{{ if $gimme->current_list->at_end }}. {{ /if }}{{ /list_article_authors }} <a href="{{ url options="article" }}">Weiterlesen</a>
                        {{ if $gimme->article->comment_count gt 0 }}<a href="{{ url options="article" }}#comments" class="comments mobile-hide">{{ $gimme->article->comment_count }} Kommentar{{ if $gimme->article->comment_count gt 1 }}e{{ /if }}</a>{{ /if }}  
                        </p>                       
                    </article>
                                        
{{ if $gimme->current_list->at_end }}                
                    <ul class="paging content-paging">
                    		{{ if $gimme->current_list->has_previous_elements }}
                        <li><a class="grey-button prev" href="{{ unset_article }}{{ url options="previous_items" }}">«</a></li>{{ /if }}
                        <li class="caption"></li>
                        {{ if $gimme->current_list->has_next_elements }}
                        <li><a class="grey-button next" href="{{ unset_article }}{{ url options="next_items" }}">»</a></li>{{ /if }}
                    </ul>
{{ /if }}  
					</div>                  
{{ /list_articles }} 

{{ else }}{{* if not seclike == 1 *}}
{{ list_articles length="7" constraints="type is blog" }}
						<article>
                    <h2>{{ $gimme->article->name }}</h2>
                    <span class="time">{{ $gimme->article->publish_date|camp_date_format:"%e.%m.%Y, %H:%i" }}Uhr</span>                
                    {{ include file="_tpl/article-figure.tpl" }}
                    {{ include file="_tpl/admin_frontpageedit.tpl" }}{{ $gimme->article->body }}
                    <p><a href="{{ url options="article" }}">Kommentieren & Teilen</a></p>
                  </article>
{{ if $gimme->current_list->at_end }}                
                    <ul class="paging content-paging">
                    		{{ if $gimme->current_list->has_previous_elements }}
                        <li><a class="grey-button prev" href="{{ unset_article }}{{ url options="previous_items" }}">«</a></li>{{ /if }}
                        <li class="caption"></li>
                        {{ if $gimme->current_list->has_next_elements }}
                        <li><a class="grey-button next" href="{{ unset_article }}{{ url options="next_items" }}">»</a></li>{{ /if }}
                    </ul>
{{ /if }}                   
{{ /list_articles }}
{{ /if }}               

            </section><!-- / Main Section -->
            
            <aside class="mobile-hide">
                
{{ include file="_tpl/sidebar-partnerbuttons.tpl" }}
                
{{ list_articles length="1" constraints="type is bloginfo" }} 
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
{{ /list_articles }}
                
{{ include file="_tpl/sidebar-blog-rss.tpl" }}                
                
{{ include file="_tpl/sidebar-community.tpl" }}

{{*** WERBUNG ***}}                    
{{ include file="_werbung/section-blog-sidebar.tpl" }}                
                
{{ include file="_tpl/sidebar-honorieren.tpl" }}
            
            </aside><!-- / Sidebar -->
            
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

{{ include file="_tpl/footer.tpl" }}

    </div><!-- / Footer -->

{{ include file="_tpl/_html-foot.tpl" }}
