<script type="text/template" id="ticker-article-template">
    <span title="Artikel" class="icon">Artikel</span>
    <h3><a href="<%= doc.get('link') %>"><%= doc.has('title_short') ? doc.escape('title_short') : doc.escape('title') %></a></h3>
    <p><%= doc.has('lead_short') ? doc.escape('lead_short') : doc.escape('lead') %> <small>Von&nbsp;<%= doc.get('author').join(', ') %>, <%= doc.relDate('published') %></small></p>
</script>

<script type="text/template" id="ticker-omni-template">
    <span title="Artikel" class="icon">Artikel</span>
    <h3><a href="<%= doc.get('link') %>"><%= doc.has('title_short') ? doc.escape('title_short') : doc.escape('title') %></a></h3>
    <p><%= doc.has('lead_short') ? doc.escape('lead_short') : doc.escape('lead') %> <small>Von&nbsp;<%= doc.get('author').join(', ') %>, <%= doc.relDate('published') %></small></p>
</script>

<script type="text/template" id="ticker-tweet-template">
    <span title="Tweet" class="icon">Tweet</span>
    <p><%= doc.getTweet() %> <small>Von&nbsp;<%= doc.escape('tweet_user_screen_name') %>, <%= doc.relDate('published') %></small></p>
</script>

<script src="{{ url static_file="_js/libs/underbackbone.js" }}"></script>
<script src="{{ url static_file="_js/tickerapp.js" }}"></script>
<script>
$(function() {
    var docs = new DocumentCollection();
    {{ $ids = explode(',', $ids) }}
    {{ foreach $ids as $id }}
    var view = new TickerListView({collection: docs, el: $('#ticker-sidebar-{{ $id }}')});
    {{ /foreach }}
    docs.reset(docs.parse({{ ticker section=$gimme->section }}));
});
</script>
