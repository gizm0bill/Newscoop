<article id="ticker-sidebar-{{ $id }}">
    <header>
        <p>Aktuelle Nachrichten</p>
    </header>

    <footer>
        {{ $url = $view->url(['controller' => 'omniticker', 'action' => null], 'default') }}
        {{ if $gimme->section->number }}
            {{ $url = sprintf('%s?section=%s', $url, $gimme->section->url_name) }}
        {{ /if }}
        <a href="{{ $url }}" class="grey-button full-button">Alle Nachrichten des Tages</a>
    </footer>
</article>
