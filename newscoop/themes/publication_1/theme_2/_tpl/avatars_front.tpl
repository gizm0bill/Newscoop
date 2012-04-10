<!-- _tpl/avatars_front.tpl --> 
<div class="content-box">
        <article>
        <header>
            <p><b>Die TagesWoche Community: Aktuell {{ $gimme->getUserCount() }} Mitglieder</b>{{ if !$gimme->user->logged_in }}&nbsp;<a href="{{ $view->url(['controller' => 'register', 'action' => 'index'], 'default') }}">Machen Sie auch mit!</a>{{ /if }}</p>
        </header>
        <ul class="avatar-list">
            {{ list_users length=140 order="byrandom" }}
            <li><a href="{{ $view->url(['username' => $gimme->list_user->uname], 'user') }}" title="{{ include file="_tpl/user-name.tpl" user=$gimme->list_user }}"><img src="{{ include file="_tpl/user-image.tpl" user=$gimme->list_user width=35 height=35 }}" alt="" width="35" height="35" /></a></li>
            {{ /list_users }}
        </ul>
    </article>
</div>
<!-- / _tpl/avatars_front.tpl -->
