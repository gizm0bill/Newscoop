<article id="ticker-sidebar-{{ $id }}">
    {{ $url = $view->url(['controller' => 'omniticker', 'action' => null], 'default') }}
    {{ if $gimme->section->number }}
        {{ $url = sprintf('%s?section=%s', $url, $gimme->section->url_name) }}
    {{ /if }}
    <header>
        <p>Omniticker{{ if $gimme->section->number }} {{ $gimme->section->name }}{{ /if }}<a class="mobile-arrow desktop-hide right" href="{{ $url }}"><span>&gt;</span></a></p>
    </header>

    <footer>
        <a href="{{ $url }}" class="grey-button full-button">Alle News ansehen</a>
    </footer>
</article>
