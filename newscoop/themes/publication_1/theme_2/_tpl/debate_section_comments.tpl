{{ list_articles length="1" constraints="type is deb_moderator" }}   
                        <div class="comments-box comments-box-aside">
                            <header>
                                <p>KOMMENTARE</p>
                            </header>
                            <ul class="tab-nav">
                                <li><a href="#tab-1">Beste ({{ $gimme->article->recommended_comment_count }})</a></li>
                                <li><a href="#tab-2">Alle ({{ $gimme->article->comment_count }})</a></li>
                            </ul>         
                        <div class="comments-box-aside">

                            <div class="comment-list" id="tab-1">
                                <ul>
                                {{ if $smarty.get.recpage }}{{ assign var="recpage" value=$smarty.get.recpage }}{{ else }}{{ assign var="recpage" value="1" }}{{ /if }}
{{ list_article_comments columns="5" order="bydate desc" recommended="true" }}   
{{ if $gimme->current_list->row == $recpage }}     
                                    <li>{{ if $gimme->comment->user->identifier && $gimme->comment->user->is_author }}<small class="redaktion">TagesWoche Redaktion</small>{{ /if }}
                                        {{ $user=$gimme->comment->user }}
                                        {{ if $user->identifier }}
                                        <small><a class="green-underline"{{ if $user->is_active }} href="{{ $view->url(['username' => $user->uname], 'user') }}"{{ /if }}><img src="{{ include file="_tpl/user-image.tpl" user=$user width=35 height=35 }}" width="35" height="35" /> {{ include file="_tpl/user-name.tpl" user=$user }}</a></small>
                                        {{ else }}
                                        <small><a class="green-underline" href="#"><img src="{{ url static_file='pictures/avatar-small.png' }}" alt="" /> {{ $gimme->comment->nickname }}</a></small>
                                        {{ /if }}
                                        <span>{{ $gimme->comment->subject }}</span>
                                        <p>{{ $gimme->comment->content|nl2br }} <time>{{ $gimme->comment->submit_date|camp_date_format:"%e.%m.%Y um %H:%iUhr" }}, <a href="#debate_comment_{{ $gimme->comment->identifier }}">Direktlink zum Kommentar</a></time></p>
                                    </li>    
{{ /if }}              
{{ /list_article_comments }}                                    
{{ if $gimme->prev_list_empty }}
<p style="padding: 15px 0">Bisher wurden keine Kommentare zu diesem Artikel von der Redaktion hervorgehoben.</p>
{{ /if }}
                                </ul>
{{* pagination. here we repeat the same article list, check which page is active and create links to other pages *}}

{{ list_article_comments columns="5" order="bydate desc" recommended="true" }}                
{{ if $gimme->article->recommended_comment_count gt 5 }}
    {{ if $gimme->current_list->at_beginning }}
                <p class="pagination">
    {{ /if }}
    {{ if $gimme->current_list->column == 1 }}
        {{ if $gimme->current_list->row == $recpage }}
                    <span>{{ $gimme->current_list->row }}</span>
        {{ else }}
            <a href="{{ uri }}&recpage={{ $gimme->current_list->row }}#tab-1">{{ $gimme->current_list->row }}</a>
        {{ /if }}                    
    {{ /if }}
    {{ if $gimme->current_list->row == $recpage }}
    {{ if $gimme->current_list->column == 5 || $gimme->current_list->at_end }}
                    <span class="nav right">
                        {{ assign var="prevrecpage" value=$recpage-1 }}
                        {{ assign var="nextrecpage" value=$recpage+1 }}
                        {{ if $prevrecpage gt 0 }}<a href="{{ uri }}&recpage={{ $prevrecpage }}#tab-1" class="prev">Previous</a>{{ /if }}
                        {{ if ($nextrecpage lt $gimme->current_list->count/5+1)||($nextrecpage==2) }}<a href="{{ uri }}&recpage={{ $nextrecpage }}#tab-1" class="next">Next</a>{{ /if }}
                    </span>             
    {{ /if }}
    {{ /if }}
    {{ if $gimme->current_list->at_end }}     
                </p>
    {{ /if }}
{{ /if }}
{{ /list_article_comments }}                                
                            </div><!-- /#tab-1 -->
                        </div><!-- /.comment-box-aside -->
                        <div class="comments-box-aside">    

                            <div class="comment-list" id="tab-2">
                                <ul>
                                {{ if $smarty.get.page }}{{ assign var="page" value=$smarty.get.page }}{{ else }}{{ assign var="page" value="1" }}{{ /if }}
{{ list_article_comments columns="5" order="bydate desc"}} 
{{ if $gimme->current_list->row == $page }}                               
                                    <li id="debate_comment_{{ $gimme->comment->identifier }}">
                                        {{ if $gimme->comment->user->identifier && $gimme->comment->user->is_author }}<small class="redaktion">TagesWoche Redaktion</small>{{ /if }}
                                        {{ $user=$gimme->comment->user }}
                                        {{ if $user->identifier }}
                                        <small><a class="green-underline"{{ if $user->is_active }} href="{{ $view->url(['username' => $user->uname], 'user') }}"{{ /if }}><img src="{{ include file="_tpl/user-image.tpl" user=$user width=35 height=35 }}" width="35" height="35" /> {{ include file="_tpl/user-name.tpl" user=$user }}</a></small>
                                        {{ else }}
                                        <small><a class="green-underline" href="#"><img src="{{ url static_file='pictures/avatar-small.png' }}" alt="" /> {{ $gimme->comment->nickname }}</a></small>
                                        {{ /if }}
                                        <span>{{ $gimme->comment->subject }}</span>
                                        <p>{{ $gimme->comment->content|nl2br }} <time>{{ $gimme->comment->submit_date|camp_date_format:"%e.%m.%Y um %H:%iUhr" }}, <a href="#debate_comment_{{ $gimme->comment->identifier }}">Direktlink zum Kommentar</a></time></p>
                                    </li>
{{ /if }}                                    
{{ /list_article_comments }} 
{{ if $gimme->prev_list_empty }}
<p style="padding: 15px 0">Bisher wurden keine Kommentare zu diesem Artikel</p>
{{ /if }}                                   

                                </ul>                            
{{* pagination. here we repeat the same article list, check which page is active and create links to other pages *}}

{{ list_article_comments columns="5" order="bydate desc"}}                
{{ if $gimme->article->comment_count gt 5 }}
    {{ if $gimme->current_list->at_beginning }}
                <p class="pagination">
    {{ /if }}
    {{ if $gimme->current_list->column == 1 }}
        {{ if $gimme->current_list->row == $page }}
                    <span>{{ $gimme->current_list->row }}</span>
        {{ else }}
            <a href="{{ uri }}&page={{ $gimme->current_list->row }}#tab-2">{{ $gimme->current_list->row }}</a>
        {{ /if }}                    
    {{ /if }}
    {{ if $gimme->current_list->row == $page }}
    {{ if $gimme->current_list->column == 5 || $gimme->current_list->at_end }}
                    <span class="nav right">
                        {{ assign var="prevpage" value=$page-1 }}
                        {{ assign var="nextpage" value=$page+1 }}
                        {{ if $prevpage gt 0 }}<a href="{{ uri }}&page={{ $prevpage }}#tab-2" class="prev">Previous</a>{{ /if }}
                        {{ if ($nextpage lt $gimme->current_list->count/5+1)||($nextpage==2) }}<a href="{{ uri }}&page={{ $nextpage }}#tab-2" class="next">Next</a>{{ /if }}
                    </span>             
    {{ /if }}
    {{ /if }}
    {{ if $gimme->current_list->at_end }}     
                </p>
    {{ /if }}
{{ /if }}
{{ /list_article_comments }}

{{ if $gimme->article->comments_enabled }}
<a href="javascript:omnibox.showHide()"><img style="float: left; margin: 5px 5px 0 0" alt="Omnibox" src="{{ uri static_file="_css/tw2011/img/triangle-small.png" }}"/></a>
<p><a href="javascript:omnibox.showHide()">Eigenen Kommentar schreiben </a></p>
{{ else }}
{{ if !$gimme->article->comments_enabled }}<h6>Für diesen Artikel wurde die Kommentarfunktion deaktiviert, Sie können aber eine <a href="javascript:omnibox.showHide()">Mitteilung</a> an die Redaktion senden.</h6>{{ /if }}                                             
{{ /if }}
                            </div>                          
                        </div>
                    </div>
{{ /list_articles }}  

<script>
    function fixCommentLink() {
        if (document.location.hash.indexOf("debate_comment_") != -1) {
            document.location.hash = document.location.hash;
        }
    }
</script>