
{{ if $gimme->article->comments_enabled || $gimme->article->comments_locked  }}  

                <section>
                
                    <div class="omni-corner-box comments-box tabs">
                    
                        <ul class="comments-nav">
                            <li><a href="#ausgewahlte-kommentare">Ausgewählte Kommentare {{ if $gimme->article->recommended_comment_count }}({{ $gimme->article->recommended_comment_count }}){{ /if }}</a></li>
                            <li><a href="#alle-kommentare">Alle Kommentare ({{ $gimme->article->comment_count }})</a></li>
                        </ul>
                        
                        <div id="ausgewahlte-kommentare" class="comment-list">
                        
                            {{ $recommendedEmpty=1 }}
									 {{ list_article_comments length="10" order="bydate asc" recommended="true"  }}
									 {{ if $gimme->current_list->at_beginning }}
									 <ol>
									 {{ /if }}
                                <li>
                                    {{ if $gimme->comment->user->identifier && $gimme->comment->user->is_author }}<span class="editorial">TagesWoche Redaktion</span>{{ /if }}
                                    {{ $user=$gimme->comment->user }}
                                    {{ if $user->identifier }}
                                    <a{{ if $user->is_active }} href="{{ $view->url(['username' => $user->uname], 'user') }}"{{ /if }}><img src="{{ include file="_tpl/user-image.tpl" user=$user width=35 height=35 }}" width="35" height="35" /></a>{{ else }}<img src="{{ url static_file='pictures/avatar-small.png' }}" alt="" />{{ /if }}
                                    <h4>{{ $gimme->comment->subject }}</h4>
                                    <small>von {{ if $user->identifier }}<a{{ if $user->is_active }} href="{{ $view->url(['username' => $user->uname], 'user') }}"{{ /if }}>{{ include file="_tpl/user-name.tpl" user=$user }}</a>{{ else }}<a>{{ $gimme->comment->nickname }}</a>{{ /if }} um {{ $gimme->comment->submit_date|camp_date_format:"%e.%m.%Y um %H:%iUhr" }}</small>
                                    <p>{{ $gimme->comment->content|create_links|nl2br }}<br />
                                    <small style="margin-top: 10px"><a href="{{ if $artno }}{{ url options="article" }}{{ /if }}#comment_{{ $gimme->comment->identifier }}">Direktlink zum Kommentar</a></small></p>
                                </li>
									 {{ $recommendedEmpty=0 }}
									 {{ if $gimme->current_list->at_end }}
									 </ol>
									 <div class="nav-prev-next clearfix">               
                            <ul class="paging content-paging">
                    				{{ if $gimme->current_list->has_previous_elements }}
                        		<li><a class="grey-button prev" href="{{ if $gimme->section->number == "81" }}{{ unset_article }}{{ /if }}{{ url options="previous_items" }}">«</a></li>{{ /if }}
                        		<li class="caption"></li>
                        		{{ if $gimme->current_list->has_next_elements }}
                        		<li><a class="grey-button next" href="{{ if $gimme->section->number == "81" }}{{ unset_article }}{{ /if }}{{ url options="next_items" }}">»</a></li>{{ /if }}
                    			 </ul>
                    			 </div>
{{ /if }}
								    {{ /list_article_comments }}
								    
{{ if $recommendedEmpty }}
<p>Bisher wurden keine Kommentare zu diesem Artikel von der Redaktion hervorgehoben.</p>
{{ /if }}                         
                        </div>

                        <div id="alle-kommentare" class="comment-list">
                        
									 {{ list_article_comments length="10" order="bydate asc"  }}
									 {{ if $gimme->current_list->at_beginning }}
									 <ol>
									 {{ /if }}
                                <li id="comment_{{ $gimme->comment->identifier }}">
                                    {{ if $gimme->comment->user->identifier && $gimme->comment->user->is_author }}<span class="editorial">TagesWoche Redaktion</span>{{ /if }}
                                    {{ $user=$gimme->comment->user }}
                                    {{ if $user->identifier }}
                                    <a{{ if $user->is_active }} href="{{ $view->url(['username' => $user->uname], 'user') }}"{{ /if }}><img src="{{ include file="_tpl/user-image.tpl" user=$user width=35 height=35 }}" width="35" height="35" /></a>{{ else }}<img src="{{ url static_file='pictures/avatar-small.png' }}" alt="" />{{ /if }}
                                    <h4>{{ $gimme->comment->subject }}</h4>
                                    <small>von {{ if $user->identifier }}<a{{ if $user->is_active }} href="{{ $view->url(['username' => $user->uname], 'user') }}"{{ /if }}>{{ include file="_tpl/user-name.tpl" user=$user }}</a>{{ else }}<a>{{ $gimme->comment->nickname }}</a>{{ /if }} um {{ $gimme->comment->submit_date|camp_date_format:"%e.%m.%Y um %H:%iUhr" }}</small>
                                    <p>{{ $gimme->comment->content|create_links|nl2br }}<br />
                                    <small style="margin-top: 10px"><a href="{{ if $artno }}{{ url options="article" }}{{ /if }}#comment_{{ $gimme->comment->identifier }}">Direktlink zum Kommentar</a></small></p>
                                </li>
                            {{ if $gimme->current_list->at_end }}
									 </ol>
									 <div class="nav-prev-next clearfix">
                            <ul class="paging content-paging">
                    				{{ if $gimme->current_list->has_previous_elements }}
                        		<li><a class="grey-button prev" href="{{ if $gimme->section->number == "81" }}{{ unset_article }}{{ /if }}{{ url options="previous_items" }}">«</a></li>{{ /if }}
                        		<li class="caption"></li>
                        		{{ if $gimme->current_list->has_next_elements }}
                        		<li><a class="grey-button next" href="{{ if $gimme->section->number == "81" }}{{ unset_article }}{{ /if }}{{ url options="next_items" }}">»</a></li>{{ /if }}
                    			 </ul>
                    			 </div>									 
									 {{ /if }}
								    {{ /list_article_comments }}
                        
                        </div>
                        
                        <a href="#" onClick="omnibox.show()" class="button">Kommentieren</a>
                    
                    </div>
                
                </section>
                
{{ else }}
    <section>
                    <div class="comments-box">   
                        <p>Für diesen Artikel wurde die Kommentarfunktion deaktiviert, Sie können aber eine <a href="#" onClick="omnibox.show()">Mitteilung</a> an die Redaktion senden.</p>       
                    </div>
    </section>
{{ /if }}

<script>
    function fixCommentLink() {
        if (document.location.hash.indexOf("comment_") != -1) {
            document.location.hash = document.location.hash;
        }
    }
</script>                
