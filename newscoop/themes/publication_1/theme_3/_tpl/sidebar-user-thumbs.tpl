<ul class="user-thumbs">
    {{ list_users length=16 order="byrandom" }}
    <li><a href="{{ $view->url(['username' => $gimme->list_user->uname], 'user') }}" title="{{ include file="_tpl/user-name.tpl" user=$gimme->list_user }}"><img src="{{ include file="_tpl/user-image.tpl" user=$gimme->list_user width=32 height=32 }}" alt="" width="32" height="32" /></a></li>
    {{ /list_users }}
</ul>

{{ $count=floor($gimme->getUserCount() / 1000) }}
<p>Die TagesWoche Community hat über {{ $count }}'000 Mitglieder!</p>
{{ if !$gimme->user->logged_in }}<a href="{{ $view->url(['controller' => 'register', 'action' => 'index'], 'default') }}" class="button">Jetzt mitmachen!</a>{{ /if }}
