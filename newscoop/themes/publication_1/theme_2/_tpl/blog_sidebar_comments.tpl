<!-- _tpl/blog_sidebar_comments.tpl -->
<article>
    <header>
        <p>Neueste Kommentare</p>
    </header>

    <ul id="sequence-list">
        <li><ul class="item-list side-icons-list sequence-list">
        {{ assign var="cursec" value=$gimme->section->number }}
        {{ list_article_comments length="5" ignore_article="true" section=$cursec order="byDate desc" }}

        {{ $user=$gimme->comment->user }}
        {{ if $user->identifier }}
        <li class="commentar">{{ assign var="created" value=$gimme->comment->submit_date }}{{ include file="_tpl/relative_date.tpl" date=$created short=1 }} <a{{ if $user->is_active }} href="{{ $view->url(['username' => $user->uname], 'user') }}"{{ /if }}>{{ include file="_tpl/user-name.tpl" user=$user }}</a> zu <a href="{{ url options="article" }}">{{ $gimme->article->name }}</a></li>
        {{ else }}
        <li class="commentar">{{ assign var="created" value=$gimme->comment->submit_date }}{{ include file="_tpl/relative_date.tpl" date=$created short=1 }} <a>{{ $gimme->comment->nickname }}</a> zu <a href="{{ url options="article" }}">{{ $gimme->article->name }}</a></li>
        {{ /if }}
        {{ /list_article_comments }}
        </ul></li>
    </ul>

</article>
<!-- _tpl/blog_sidebar_comments.tpl -->
