<article class="community omni-corner-box">
    <header>
        <p>TagesWoche Community</p>
    </header>

    <ul class="item-list">
        {{ list_community_feeds length=6 }}
            {{ $created=$gimme->community_feed->created }}
            {{ $user=$gimme->community_feed->user }}
        {{ if $gimme->community_feed->type == 'user-register' && $user->uname }}
        <li class="omni"><a{{ if $user->is_active }} href="{{ $view->url(['username' => $user->uname], 'user') }}"{{ /if }}>{{ include file="_tpl/user-name.tpl" user=$user }} ist gerade Mitglied geworden</a></li>
        {{ elseif $gimme->community_feed->type == 'comment-recommended' && $gimme->community_feed->comment->article }}
        <li class="comment"><a href="{{ $gimme->community_feed->comment->article->url }}{{ $gimme->community_feed->comment->article->seo_url_end }}{{ if $gimme->community_feed->comment->article->type_name == "deb_moderator" }}?stage=1{{ /if }}">Neuer Kommentar zu {{ $gimme->community_feed->comment->article->title }}</a></li>
        {{ elseif $gimme->community_feed->type == 'blog-published' && $gimme->community_feed->article }}
        <li class="omni"><a href="{{ $gimme->community_feed->article->url}}{{ $gimme->community_feed->article->seo_url_end }}">Neuer Blogeintrag {{ $gimme->community_feed->article->title }}</a></li>
        {{ elseif $user->defined }}
        <li class="omni">{{ include file="_tpl/relative_date.tpl" date=$created short=1 }} <a{{ if $user->is_active }} href="{{ $view->url(['username' => $user->uname], 'user') }}"{{ /if }}>{{ include file="_tpl/user-name.tpl" user=$user }}</a> hat gerade ein Photo hochgeladen</li>
        {{ /if }}
        {{ /list_community_feeds }}
    </ul>
    <footer>
        <a href="{{ $view->url(['controller' => 'user', 'action' => 'index'], 'default') }}" class="more">Zur Community &raquo;</a>
    </footer>
    {{ $count=floor($gimme->getUserCount() / 1000) }}
    <p>Die TagesWoche Community hat über {{ $count }}'000 Mitglieder!</p>
    {{ if !$gimme->user->logged_in }}<a href="{{ $view->url(['controller' => 'register', 'action' => 'index'], 'default') }}" class="button">Jetzt mitmachen!</a>{{ /if }}
</article>
