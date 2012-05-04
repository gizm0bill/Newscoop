<article id="ticker-sidebar-{{ $id }}">
    <header>
        <p>Omniticker{{ if $gimme->section->number }} {{ $gimme->section->name }}{{ /if }}</p>
    </header>

    <footer>
        {{ $url = $view->url(['controller' => 'omniticker', 'action' => null], 'default') }}
        {{ if $gimme->section->number }}
            {{ $url = sprintf('%s?section=%s', $url, $gimme->section->url_name) }}
        {{ /if }}
        <a href="{{ $url }}" class="grey-button full-button">Alle News ansehen</a>
    </footer>
</article>
