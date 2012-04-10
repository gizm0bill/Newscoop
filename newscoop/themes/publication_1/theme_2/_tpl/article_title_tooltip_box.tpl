{{ if $gimme->article->recommended_comment_count gt 0 }}
{{ list_article_comments recommended="true" length="1" order="bydate desc" }}
  <span class="title-box">
    <div>
      <p>
        <a href="{{ url options="article" }}#comments">{{ $gimme->comment->subject }}</a><br />
        {{ $gimme->comment->content|strip_tags|truncate:100 }}
      </p>
      <small>
        {{ $user=$gimme->comment->user }}
        {{ if $user->identifier }}
        <img src="{{ include file="_tpl/user-image.tpl" user=$user width=35 height=35 }}" width="35" height="35" alt="" />
        von <a href="{{ $view->url(['username' => $user->uname], 'user') }}">{{ include file="_tpl/user-name.tpl" user=$user }}</a><br />
        {{ else }}

        {{ /if }}
        <i>{{ include file="_tpl/relative_date.tpl" date=$gimme->comment->submit_date short=1 }}</i>
      </small>
    </div>
  </span><!-- / Title Tooltip Box -->
{{ /list_article_comments }}  
{{ /if }}
