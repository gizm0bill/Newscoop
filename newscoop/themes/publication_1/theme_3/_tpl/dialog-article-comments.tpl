               <div class="omni-corner-box comments-box tabs">
                    
                        <ul class="comments-nav">
                            <li><a href="#ausgewählte-kommentare">Ausgewählte Kommentare</a></li>
                            <li><a href="#alle-kommentare">Alle Kommentare</a></li>
                        </ul>
                        
                        <div id="ausgewählte-kommentare" class="comment-list">
                        
                            <ol>                            
                            
                            {{ $recommendedEmpty=1 }}
									 {{ list_article_comments length="10" ignore_article="true" order="bydate desc" recommended="true" }}
                                <li>
                                		{{ if $gimme->comment->user->identifier && $gimme->comment->user->is_author }}<small class="redaktion">TagesWoche Redaktion</small>{{ /if }}
                                    {{ $user=$gimme->comment->user }}
                                    {{ if $user->identifier }}
                                    <a{{ if $user->is_active }} href="{{ $view->url(['username' => $user->uname], 'user') }}"{{ /if }}><img src="{{ include file="_tpl/user-image.tpl" user=$user width=35 height=35 }}" width="35" height="35" /></a>{{ else }}<img src="{{ url static_file='pictures/avatar-small.png' }}" alt="" />{{ /if }}
                                    <h4>{{ $gimme->comment->subject }}</h4>
                                    <small>von {{ if $user->identifier }}<a{{ if $user->is_active }} href="{{ $view->url(['username' => $user->uname], 'user') }}"{{ /if }}>{{ include file="_tpl/user-name.tpl" user=$user }}</a>{{ else }}<a>{{ $gimme->comment->nickname }}</a>{{ /if }} um {{ $gimme->comment->submit_date|camp_date_format:"%e.%m.%Y um %H:%iUhr" }}</small>
                                    <p>{{ $gimme->comment->content|create_links|nl2br|truncate:400 }}<br />
                                    <small style="margin-top: 10px"><a href="{{ url options="article" }}#comment_{{ $gimme->comment->identifier }}">Direktlink zum Kommentar</a></small></p>
                                </li>
									 {{ $recommendedEmpty=0 }}
								    {{ /list_article_comments }}
								    
                            </ol>
{{ if $recommendedEmpty }}
<p>Bisher wurden keine Kommentare zu diesem Artikel von der Redaktion hervorgehoben.</p>
{{ /if }}                         
                        </div>
                        
                        <div id="alle-kommentare" class="comment-list">
                        
                            <ol>
									 {{ list_article_comments length="10" ignore_article="true" order="bydate desc"  }}
                                <li id="comment_{{ $gimme->comment->identifier }}">
                                		{{ if $gimme->comment->user->identifier && $gimme->comment->user->is_author }}<small class="redaktion">TagesWoche Redaktion</small>{{ /if }}
                                    {{ $user=$gimme->comment->user }}
                                    {{ if $user->identifier }}
                                    <a{{ if $user->is_active }} href="{{ $view->url(['username' => $user->uname], 'user') }}"{{ /if }}><img src="{{ include file="_tpl/user-image.tpl" user=$user width=35 height=35 }}" width="35" height="35" /></a>{{ else }}<img src="{{ url static_file='pictures/avatar-small.png' }}" alt="" />{{ /if }}
                                    <h4>{{ $gimme->comment->subject }}</h4>
                                    <small>von {{ if $user->identifier }}<a{{ if $user->is_active }} href="{{ $view->url(['username' => $user->uname], 'user') }}"{{ /if }}>{{ include file="_tpl/user-name.tpl" user=$user }}</a>{{ else }}<a>{{ $gimme->comment->nickname }}</a>{{ /if }} um {{ $gimme->comment->submit_date|camp_date_format:"%e.%m.%Y um %H:%iUhr" }}</small>
                                    <p>{{ $gimme->comment->content|create_links|nl2br|truncate:400 }}<br />
                                    <small style="margin-top: 10px"><a href="{{ url options="article" }}#comment_{{ $gimme->comment->identifier }}">Direktlink zum Kommentar</a></small></p>
                                </li>
								    {{ /list_article_comments }}
								    </ol>
                        
                        </div>
                    
                    </div>

<script>
    function fixCommentLink() {
        if (document.location.hash.indexOf("comment_") != -1) {
            document.location.hash = document.location.hash;
        }
    }
</script>                