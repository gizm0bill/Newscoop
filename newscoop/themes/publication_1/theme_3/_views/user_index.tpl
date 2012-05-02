{{extends file="layout.tpl"}}

{{block content_classes}}reverse-columns filter-content filter-community{{/block}}

{{block content}}
<ul class="top-filter clearfix">
    <li class="filter">Filter</li>
    <li class="title">
        <form method="get" action="{{ $view->url(['controller' => 'user', 'action' => 'search'], 'default', true) }}">
        <label>TagesWoche Community</label>
        <fieldset>
            <input type="text" name="q" placeholder="Name oder Benutzername suchen" />
            <button>Go</button>
        </fieldset>
        </form>
        <a href="#" class="info">Info
            <span>
                Sie können folgende Operatoren verwenden:<br />
                "exacte wortkombination"<br />
                -nichtdieserbegriff<br />
                author:dani winter<br />
                topic:fc basel<br />
            </span>
        </a>
    </li>
    <li class="type">Mitglied seit</li>
    <li class="time">Beiträge</li>
</ul>

<aside><div class="filter-aside">
    <h3>Mitglieder</h3>
    <ul>
        <li><a href="{{ $view->url(['controller' => 'user', 'action' => 'index'], 'default', true) }}"{{ if $current == 'index' }} class="active"{{ /if }}>Alle</a></li>
        <li><a href="{{ $view->url(['controller' => 'user', 'action' => 'active'], 'default', true) }}"{{ if $current == 'active' }} class="active"{{ /if }}>Aktivste</a></li>
        <li><a href="{{ $view->url(['controller' => 'user', 'action' => 'editors'], 'default', true) }}"{{ if $current == 'editors' }} class="active"{{ /if }}>Redaktion</a></li>
    </ul>

    <ul>
        <li><a href="#">Alphabetisch</a></li>
        <li>
            <ul class="alphabet-list">
                {{ if !isset($currentCharacter) }}
                    {{ $currentCharacter=null }}
                {{ /if }}
                {{ foreach range('a', 'z') as $character }}
                <li{{ if $currentCharacter == $character }} class="active"{{ /if }}><a href="{{ $view->url(['controller' => 'user', 'action' => 'filter', 'f' => $character], 'default', true) }}">{{ $character|upper }}</a></li>
                {{ /foreach }}
            </ul>
        </li>
    </ul>
</div></aside>

<section>
    <ul class="filter-list">
        {{ foreach $users as $user }}
        <li>
            <a href="{{ $view->url(['username' => $user->uname], 'user') }}"><img src="{{ include file="_tpl/user-image.tpl" user=$user width=65 height=65 }}" /></a>
            <h3><a href="{{ $view->url(['username' => $user->uname], 'user') }}">{{ include file="_tpl/user-name.tpl" user=$user }}</a>{{ if $user->is_editor }} <small><a href="#">TagesWoche Redaktion</a></small>{{ elseif $user['is_verified'] }} <small><a href="#">Verifiziertes Profil</a></small>{{ /if }}</h3>
            <p>{{ if !empty($user['bio']) }}{{ if $user->isAdmin() || $user->isBlogger() }}{{ $user['bio']|bbcode }}{{ else }}{{ $user['bio']|escape }}{{ /if }}{{ else }}...{{ /if }}</p>
            <span class="info"><em>{{ $user->created }}</em> <em>{{ $user->posts_count }}</em></span>
        </li>
        {{ /foreach }}
    </ul>

    {{include file='paginator_control.tpl'}}
</section>
{{/block}}

