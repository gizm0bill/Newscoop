<article id="ticker-sidebar">
    <header>
        <p>Aktuelle Nachrichten</p>
    </header>

    <footer>
        <a href="#" class="embed">Embed</a>
        {{ if $gimme->section->number }}
        <a href="{{ $view->url(['controller' => 'ticker', 'action' => null], 'default') }}?section={{ $gimme->section->url_name }}" class="more">Alle Nachrichten »</a>
        {{ else }}
        <a href="{{ $view->url(['controller' => 'ticker', 'action' => null], 'default') }}" class="more">Alle Nachrichten »</a>
        {{ /if }}
    </footer>
</article>

<script type="text/template" id="ticker-article-template">
    <h3><a href="<%= doc.get('link') %>"><%= doc.escape('title') %></a></h3>
    <p><%= doc.escape('lead').length > 50 ? doc.escape('lead').substr(0, 49) + '...' : doc.escape('lead') %> <em>Von&nbsp;<%= doc.get('author').join(', ') %>, <%= doc.relDate('published') %></em></p>
</script>

<script type="text/template" id="ticker-twitter-template">
    <p><%= doc.getTweet() %> <em>Von&nbsp;<%= doc.escape('tweet_user_screen_name') %>, <%= doc.relDate('published') %></em></p>
</script>

<script src="{{ $view->baseUrl('js/underscore.js') }}"></script>
<script src="{{ $view->baseUrl('js/backbone.js') }}"></script>
<script src="{{ $view->baseUrl('js/models/search.js') }}"></script>
<script src="{{ $view->baseUrl('js/apps/ticker.js') }}"></script>
<script>
$(function() {
    var docs = new DocumentCollection();
    var view = new TickerListView({collection: docs, el: $('#ticker-sidebar')});
    docs.reset(docs.parse({{ ticker section=$gimme->section }}));
});
</script>
