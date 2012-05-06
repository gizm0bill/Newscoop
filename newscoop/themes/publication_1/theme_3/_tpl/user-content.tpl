                            <div class="tabs article-related-tabs">
                            
                            	<ul>
                                	<li><a href="#author-1">Artikel</a></li>
                                	<li class="mobile-hide"><a href="#author-2">Blogbeiträge</a></li>
                                	<li><a href="#author-3">Kommentare</a></li>
                                </ul>
                                
                                <div id="author-1">
                                    
                                    {{ list_articles length="3" ignore_publication="true" ignore_issue="true" ignore_section="true" constraints="author is $escapedName type is news" order="bypublishdate desc"}}
                                    	{{ if $gimme->current_list->at_beginning }}
                                    	<ul class="user-post-list">
                                    	{{ /if }}
                                    	<li>
                                        <span class="time">{{ $gimme->article->publish_date|camp_date_format:"%d.%m.%Y um %H:%i" }}</span>
                                        <h5><a href="{{ $gimme->article->url }}{{ $gimme->article->seo_url_end }}" title="{{ $gimme->article->title }}">{{ $gimme->article->title }}</a></h5>
                                        <p>{{ $gimme->article->teaser|strip_tags:false }}</p>
                                        {{ if $gimme->current_list->at_end }}
                                        </li>
                                    	</ul>
                                    	{{ /if }}
                                    {{ /list_articles }}
                                
                                </div>
                                
                                <div class="mobile-hide" id="author-2">
                                	
                                    {{ list_articles length="3" ignore_publication="true" ignore_issue="true" ignore_section="true" constraints="author is $escapedName type is blog" order="bypublishdate desc"}}
                                    {{ if $gimme->current_list->at_beginning }}
                                    <ul class="user-post-list">
                                    	{{ /if }}
                                    	<li>
                                        <span class="time">{{ $gimme->article->publish_date|camp_date_format:"%d.%m.%Y um %H:%i" }}</span>
                                        <h5><a href="{{ $gimme->article->url }}{{ $gimme->article->seo_url_end }}" title="{{ $gimme->article->title }}">{{ $gimme->article->title }}</a></h5>
                                        <p>{{ $gimme->article->teaser|strip_tags:false }}</p>
                                        </li>
                                       {{ if $gimme->current_list->at_end }}
                                    	</ul>
                                    	{{ /if }}
                                    {{ /list_articles }}
                                
                                </div>
                                
                                <div id="author-3">
                                    {{ if $gimme->author->user->defined }}
                                    {{ list_user_comments user=$gimme->author->user->identifier length="3" order="bydate desc" }}
                                    {{ if $gimme->current_list->at_beginning }}
                                    <ul class="user-post-list">
                                    	{{ /if }}
                                    	<li>
                                        {{ $date=date_create($gimme->user_comment->submit_date) }}
                                        <span class="time">{{ $date->format('d.m.Y \u\m H:i') }}</span>
                                        <h5>{{ $gimme->user_comment->subject|escape }}</h5>
                                        <span class="mother-article-link">Zum Artikel: <a href="{{ $gimme->user_comment->article->url }}#comment_{{ $gimme->user_comment->identifier }}">{{ $gimme->user_comment->article->name }}</a></span><br/>
                                        <p>{{ $gimme->user_comment->content|strip_tags:false|escape|truncate:255:"...":true }}</p>
                                        </li>
													{{ if $gimme->current_list->at_end }}                                        
                                    	</ul>
                                    	{{ /if }}
                                    {{ /list_user_comments }}
                                    {{ /if }}
                                </div>
                                
                                {{ if $gimme->author->user->defined }}
                                <h4><a href="{{ $view->url(['username' => $gimme->author->user->uname], 'user') }}">Weitere Texte im Autorenprofil</a></h4>
                                {{ /if }}
                            
                            </div>
