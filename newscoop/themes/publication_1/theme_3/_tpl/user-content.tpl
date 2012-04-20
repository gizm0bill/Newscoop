                            <div class="tabs article-related-tabs">
                            
                            	<ul>
                                	<li><a href="#author-1">Artikel</a></li>
                                	<li><a href="#author-2">Blogbeiträge</a></li>
                                	<li><a href="#author-3">Kommentare</a></li>
                                </ul>
                                
                                <div id="author-1">
                                    
                                    {{ list_articles length="3" ignore_publication="true" ignore_issue="true" ignore_section="true" constraints="author is $escapedName type is news" order="bypublishdate desc"}}
                                        <span class="time">{{ $gimme->article->publish_date|camp_date_format:"%d.%m.%Y um %H:%i" }}</span>
                                        <h5><a href="{{ $gimme->article->url }}{{ $gimme->article->seo_url_end }}" title="{{ $gimme->article->title }}">{{ $gimme->article->title }}</a></h5>
                                        <p>{{ $gimme->article->teaser }}</p>
                                    {{ /list_articles }}
                                
                                </div>
                                
                                <div id="author-2">
                                	
                                    {{ list_articles length="3" ignore_publication="true" ignore_issue="true" ignore_section="true" constraints="author is $escapedName type is blog" order="bypublishdate desc"}}
                                        <span class="time">{{ $gimme->article->publish_date|camp_date_format:"%d.%m.%Y um %H:%i" }}</span>
                                        <h5><a href="{{ $gimme->article->url }}{{ $gimme->article->seo_url_end }}" title="{{ $gimme->article->title }}">{{ $gimme->article->title }}</a></h5>
                                        <p>{{ $gimme->article->teaser }}</p>
                                    {{ /list_articles }}
                                
                                </div>
                                
                                <div id="author-3">
                                	
                                    {{ list_user_comments user=$gimme->author->user->identifier length="3" order="bydate desc" }}
                                        {{ $date=date_create($gimme->user_comment->submit_date) }}
                                        <span class="time">{{ $date->format('d.m.Y \u\m H:i') }}</span>
                                        <h5>{{ $gimme->user_comment->subject|escape }}</h5>Zum Artikel: <a href="{{ $gimme->user_comment->article->url }}#comment_{{ $gimme->user_comment->identifier }}">{{ $gimme->user_comment->article->name }}</a><br>
                                        <p>{{ $gimme->user_comment->content|escape|truncate:255:"...":true }}</p>
                                    {{ /list_user_comments }}
                                
                                </div>
                            
                            </div>