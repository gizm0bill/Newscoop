{{ strip }}
{{ if $gimme->article->comments_enabled && $gimme->article->content_accessible }}
    <header>
            <p>Kommentare</p>
    </header>
<div class="comment-list" id="comments_wrap">
{{ list_article_comments order="bydate desc"}}

{{ if $gimme->current_list->at_beginning }}
  <ul class="commentlist">
{{ /if }}
  
   <li class="comment">
      <small><span>
{{ $user=$gimme->comment->user }}
        <img src="{{ if $user->image() }}
        {{ $user->image(35, 35) }}
        {{ else }}
        {{ url static_file="_css/tw2011/img/user_blank_35x35.png" }}
        {{ /if }}" width="35" height="35" />&nbsp;
{{ $gimme->comment->nickname|jsencode }} &nbsp;
      </span>
  </small>
  <span>{{ $gimme->comment->subject|jsencode }}</span>
  <div>{{ $gimme->comment->content|jsencode }}
    <time>{{ $gimme->comment->submit_date|camp_date_format:"%e.%m.%Y um %H:%i" }}</time>
  </div>
</li>
 
{{ if $gimme->current_list->at_end }}                 
  </ul>    
{{ /if }}
{{ /list_article_comments }}
</div> <!-- comments_wrap -->
{{ /if }}
{{ /strip }}