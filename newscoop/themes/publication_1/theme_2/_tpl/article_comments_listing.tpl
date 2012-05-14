{{ if $gimme->article->comments_enabled }}                    
    <article>
                    <div class="comments-box">
                        
                        <h5>KOMMENTARE</h5>
                        
                        <ul class="tab-nav">
                            <li><a href="#tab-1">Redaktionell ausgewählte {{ if $gimme->article->recommended_comment_count }}({{ $gimme->article->recommended_comment_count }}){{ /if }}</a></li>
                            <li><a href="#tab-2">Alle Kommentare ({{ $gimme->article->comment_count }})</a></li>
                        </ul>
                        
                        <div class="comment-list" id="tab-1">

                                <ul>{{ $recommendedEmpty=1 }}
{{ list_article_comments order="bydate desc" recommended="true"  }}
                                 <li>{{ if $gimme->comment->user->identifier && $gimme->comment->user->is_author }}<small class="redaktion">TagesWoche Redaktion</small>{{ /if }}
                                  <small>
                                    {{ $user=$gimme->comment->user }}
                                    {{ if $user->identifier }}
                                    <a{{ if $user->is_active }} href="{{ $view->url(['username' => $user->uname], 'user') }}"{{ /if }}><img src="{{ include file="_tpl/user-image.tpl" user=$user width=35 height=35 }}" width="35" height="35" /> {{ include file="_tpl/user-name.tpl" user=$user }}</a>
                                    {{ else }}
                                    <a><img src="{{ url static_file='pictures/avatar-small.png' }}" alt="" /> {{ $gimme->comment->nickname }}</a>
                                    {{ /if }}
                                  </small>
                                  <span>{{ $gimme->comment->subject }}</span>
                                  <p>{{ $gimme->comment->content|create_links|nl2br }}
                                  <time>{{ $gimme->comment->submit_date|camp_date_format:"%e.%m.%Y um %H:%iUhr" }}, <a href="#comment_{{ $gimme->comment->identifier }}">Direktlink zum Kommentar</a></time></p>
                                </li>
                                {{ $recommendedEmpty=0 }}
{{ /list_article_comments }}
                            </ul>
{{ if $recommendedEmpty }}
<p>Bisher wurden keine Kommentare zu diesem Artikel von der Redaktion hervorgehoben.{{* <a href="#tab-2">Alle Kommentare</a>*}}</p>
{{ /if }}                            
                        <a href="javascript:omnibox.showHide()"><img style="float: left; margin: 5px 5px 0 0" alt="Omnibox" src="{{ uri static_file="_css/tw2011/img/triangle-small.png" }}"/></a>
                        <p><a href="javascript:omnibox.showHide()">Kommentar schreiben oder Mitteilung an die Redaktion schicken</a></p>
                        </div>
                        
                        <div class="comment-list" id="tab-2">
                                <ul>
{{ if $smarty.get.page }}{{ assign var="page" value=$smarty.get.page }}{{ else }}{{ assign var="page" value="1" }}{{ /if }}                                                      
{{ list_article_comments columns="15" order="bydate desc" }}
{{ if $gimme->current_list->row == $page }}
                                <li id="comment_{{ $gimme->comment->identifier }}">{{ if $gimme->comment->user->identifier && $gimme->comment->user->is_author }}<small class="redaktion">TagesWoche Redaktion</small>{{ /if }}
                                  <small>
                                    {{ $user=$gimme->comment->user }}
                                    {{ if $user->identifier }}
                                    <a{{ if $user->is_active }} href="{{ $view->url(['username' => $user->uname], 'user') }}"{{ /if }}><img src="{{ include file="_tpl/user-image.tpl" user=$user width=35 height=35 }}" width="35" height="35" /> {{ include file="_tpl/user-name.tpl" user=$user }}</a>
                                    {{ else }}
                                    <a><img src="{{ url static_file='pictures/avatar-small.png' }}" alt="" /> {{ $gimme->comment->nickname }}</a>
                                    {{ /if }}
                                  </small>
                                  <span>{{ $gimme->comment->subject }}</span>
                                  <p>{{ $gimme->comment->content|create_links|nl2br }}
                                  <time>{{ $gimme->comment->submit_date|camp_date_format:"%e.%m.%Y um %H:%iUhr" }}, <a href="#comment_{{ $gimme->comment->identifier }}">Direktlink zum Kommentar</a></time></p>
                                </li>
{{ /if }}                                
{{ /list_article_comments }}
                            </ul>

{{* pagination. here we repeat the same article list, check which page is active and create links to other pages *}}

{{ list_article_comments columns="15" order="bydate desc" }}             
{{ if $gimme->article->comment_count gt 15 }}
    {{ if $gimme->current_list->at_beginning }}
                <p class="pagination">
    {{ /if }}
    {{ if $gimme->current_list->column == 1 }}
        {{ if $gimme->current_list->row == $page }}
                    <span>{{ $gimme->current_list->row }}</span>
        {{ else }}
                    <a href="?page={{ $gimme->current_list->row }}#tab-2">{{ $gimme->current_list->row }}</a>
        {{ /if }}                    
    {{ /if }}
    {{ if $gimme->current_list->row == $page }}
    {{ if $gimme->current_list->column == 15 || $gimme->current_list->at_end }}
                    <span class="nav right">
                        {{ assign var="prevpage" value=$page-1 }}
                        {{ assign var="nextpage" value=$page+1 }}
                        {{ if $prevpage gt 0 }}<a href="?page={{ $prevpage }}#tab-2" class="prev">Previous</a>{{ /if }}
                        {{ if ($nextpage lt $gimme->current_list->count/15+1)||($nextpage==2) }}<a href="?page={{ $nextpage }}#tab-2" class="next">Next</a>{{ /if }}
                    </span>              
    {{ /if }}
    {{ /if }}
    {{ if $gimme->current_list->at_end }}     
                </p>
    {{ /if }}
{{ /if }}
{{ /list_article_comments }}
                        <a href="javascript:omnibox.showHide()"><img style="float: left; margin: 5px 5px 0 0" alt="Omnibox" src="{{ uri static_file="_css/tw2011/img/triangle-small.png" }}"/></a>
                        <p><a href="javascript:omnibox.showHide()">Kommentar schreiben oder Mitteilung an die Redaktion schicken</a></p>
                           
                        </div>
                        
                    </div>
    </article>

{{ else }}
    <article>
                    <div class="comments-box">   
                        <p>Für diesen Artikel wurde die Kommentarfunktion deaktiviert, Sie können aber eine <a href="javascript:omnibox.showHide()">Mitteilung</a> an die Redaktion senden.</p>       
                    </div>
    </article>
{{ /if }}

<script>
    function fixCommentLink() {
        if (document.location.hash.indexOf("comment_") != -1) {
            document.location.hash = document.location.hash;
        }
    }
</script>