<!-- _tpl/community_activitystream.tpl -->
<article>
    <header>
        <p>TagesWoche Community</p>
    </header>

    <div class="loader" style="height:{{ if ($is_community) }}234px{{ else }}309px{{ /if }}">
    <ul id="sequence-list" class="jcarousel-skin-quotes">
        <li><ul class="item-list side-icons-list sequence-list">
        {{ list_community_feeds length=24 }}
        {{ $created=$gimme->community_feed->created }}
        {{ $user=$gimme->community_feed->user }}

        {{ if $gimme->current_list->index > 1 && $gimme->current_list->index % 8 == 1 }}
        </ul></li>
        <li><ul class="item-list side-icons-list sequence-list">
        {{ /if }}

        {{ if $gimme->community_feed->type == 'user-register' && $user->uname }}
        <li class="omnibox">{{ include file="_tpl/relative_date.tpl" date=$created short=1 }} <a{{ if $user->is_active }} href="{{ $view->url(['username' => $user->uname], 'user') }}"{{ /if }}>{{ include file="_tpl/user-name.tpl" user=$user }}</a> ist gerade Mitglied geworden</li>
        {{ elseif $gimme->community_feed->type == 'comment-recommended' && $gimme->community_feed->comment->article }}
        <li class="commentar">{{ include file="_tpl/relative_date.tpl" date=$created short=1 }} Neuer Kommentar zu: <a href="{{ $gimme->community_feed->comment->article->url }}{{ $gimme->community_feed->comment->article->seo_url_end }}{{ if $gimme->community_feed->comment->article->type_name == "deb_moderator" }}?stage=1{{ /if }}">{{ $gimme->community_feed->comment->article->title }}</a></li>
        {{ elseif $gimme->community_feed->type == 'blog-published' && $gimme->community_feed->article }}
        <li class="blogpost">{{ include file="_tpl/relative_date.tpl" date=$created short=1 }} Neuer Blogpost: <a href="{{ $gimme->community_feed->article->url}}{{ $gimme->community_feed->article->seo_url_end }}">{{ $gimme->community_feed->article->title }}</a></li>
        {{ elseif $user->defined }}
        <li class="upload">{{ include file="_tpl/relative_date.tpl" date=$created short=1 }} <a{{ if $user->is_active }} href="{{ $view->url(['username' => $user->uname], 'user') }}"{{ /if }}>{{ include file="_tpl/user-name.tpl" user=$user }}</a> hat gerade ein Photo hochgeladen</li>
        {{ /if }}

        {{ /list_community_feeds }}
        </ul></li>
    </ul>
    <div class="loading" style="height:{{ if ($is_community) }}234px{{ else }}309px{{ /if }}"></div></div>

    <footer>
        {{ if !isset($is_community) }}
        <a href="{{ $view->url(['controller' => 'user', 'action' => 'index'], 'default') }}">Zur Community</a>
        {{ else }}
        <a href="{{ $view->url(['controller' => 'register', 'action' => 'index'], 'default') }}">Registrieren</a>
        {{ /if }}
    </footer>
</article>
<!-- _tpl/community_activitystream.tpl -->
