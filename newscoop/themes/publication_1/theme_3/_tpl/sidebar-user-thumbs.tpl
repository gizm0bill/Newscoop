<ul class="user-thumbs">
    {{ list_users length=16 order="byrandom" }}
    <li><a href="{{ $view->url(['username' => $gimme->list_user->uname], 'user') }}" title="{{ include file="_tpl/user-name.tpl" user=$gimme->list_user }}"><img src="{{ include file="_tpl/user-image.tpl" user=$gimme->list_user width=32 height=32 }}" alt="" width="32" height="32" /></a></li>
    {{ /list_users }}
</ul>

<p>Die TagesWoche-Community hat bereits {{ number_format($gimme->getUserCount(), 0, '.', '\'') }} Mitglieder.</p>
{{ if !$gimme->user->logged_in }}<a href="{{ $view->url(['controller' => 'register', 'action' => 'index'], 'default') }}" class="button">Jetzt mitmachen!</a>{{ /if }}
