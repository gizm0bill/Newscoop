               <div class="omni-corner-box comments-box tabs">
                    
                        <ul class="comments-nav">
                            <li><a href="#ausgewahlte-kommentare">Ausgewählte Kommentare</a></li>
                            <li><a href="#alle-kommentare">Alle Kommentare</a></li>
                        </ul>
                        
                        <div id="ausgewahlte-kommentare" class="comment-list">
                        
                            {{ $recommendedEmpty=1 }}
									 {{ list_article_comments length="10" ignore_article="true" order="bydate desc" recommended="true" }}
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
                                    <p>{{ $gimme->comment->content|create_links|nl2br|truncate:400 }}<br />
                                    <small style="margin-top: 10px"><a href="{{ url options="article" }}#comment_{{ $gimme->comment->identifier }}">Direktlink zum Kommentar</a></small></p>
                                </li>
									 {{ $recommendedEmpty=0 }}
									 {{ if $gimme->current_list->at_end }}
									 </ol>
									 <div class="nav-prev-next clearfix">               
                            <ul class="paging content-paging">
                    				{{ if $gimme->current_list->has_previous_elements }}
                        		<li><a class="grey-button prev" href="{{ unset_article }}{{ url options="previous_items" }}">«</a></li>{{ /if }}
                        		<li class="caption"></li>
                        		{{ if $gimme->current_list->has_next_elements }}
                        		<li><a class="grey-button next" href="{{ unset_article }}{{ url options="next_items" }}">»</a></li>{{ /if }}
                    			 </ul>
                    			 </div>
{{ /if }}									 
								    {{ /list_article_comments }}
								    
{{ if $recommendedEmpty }}
<p>Bisher wurden keine Kommentare zu diesem Artikel von der Redaktion hervorgehoben.</p>
{{ /if }}                         
                        </div>
                        
                        <div id="alle-kommentare" class="comment-list">
                        
									 {{ list_article_comments length="10" ignore_article="true" order="bydate desc"  }}
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
                                    <p>{{ $gimme->comment->content|create_links|nl2br|truncate:400 }}<br />
                                    <small style="margin-top: 10px"><a href="{{ url options="article" }}#comment_{{ $gimme->comment->identifier }}">Direktlink zum Kommentar</a></small></p>
                                </li>
									 {{ if $gimme->current_list->at_end }}
									 </ol>
									 <div class="nav-prev-next clearfix">               
                            <ul class="paging content-paging">
                    				{{ if $gimme->current_list->has_previous_elements }}
                        		<li><a class="grey-button prev" href="{{ unset_article }}{{ url options="previous_items" }}">«</a></li>{{ /if }}
                        		<li class="caption"></li>
                        		{{ if $gimme->current_list->has_next_elements }}
                        		<li><a class="grey-button next" href="{{ unset_article }}{{ url options="next_items" }}">»</a></li>{{ /if }}
                    			 </ul>
                    			 </div>
									 {{ /if }}		                                
								    {{ /list_article_comments }}
                        
                        </div>
                    
                    </div>

<script>
    function fixCommentLink() {
        if (document.location.hash.indexOf("comment_") != -1) {
            document.location.hash = document.location.hash;
        }
    }
</script>                
