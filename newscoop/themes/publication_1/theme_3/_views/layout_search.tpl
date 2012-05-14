{{extends file="layout.tpl"}}

{{block content_classes}}reverse-columns filter-content{{/block}}

{{block head}}
<script type="text/template" id="document-article-template">
<% if (doc.get('image')) { %><a href="<%= doc.get('link') %>" title="<%= doc.escape('title') %>"><img src="/images/cache/<%= doc.get('image') %>" alt="" width="90" /></a><% } %>
<h3><a href="<%= doc.get('link') %>" title="<%= doc.escape('title') %>"><%= doc.escape('title') %></a></h3>
<p><%= doc.escape('lead') %></p>
<span class="icon" title="Artikel">Artikel</span>
<span class="info"><%= doc.relDate('published') %><% if (doc.get('section_name')) { %><br /><%= doc.escape('section_name') %><% } %></span>
</script>

<script type="text/template" id="document-omni-template">
<% if (doc.get('image')) { %><a href="<%= doc.get('link') %>" title="<%= doc.escape('title') %>"><img src="/images/cache/<%= doc.get('image') %>" alt="" width="90" /></a><% } %>
<h3><a href="<%= doc.get('link') %>" title="<%= doc.escape('title') %>"><%= doc.escape('title') %></a></h3>
<p><%= doc.escape('lead') %></p>
<span class="icon" title="<%= doc.get('type') == 'news' ? 'Artikel' : 'Blogbeitrag' %>"><%= doc.get('type') == 'news' ? 'Artikel' : 'Blogbeitrag' %></span>
<span class="info"><%= doc.relDate('published') %><% if (doc.get('section_name')) { %><br /><%= doc.escape('section_name') %><% } %></span>
</script>

<script type="text/template" id="document-dossier-template">
<% if (doc.get('image')) { %><a href="<%= doc.get('link') %>" title="<%= doc.escape('title') %>"><img src="/images/cache/<%= doc.get('image') %>" alt="" width="90" /></a><% } %>
<h3><a href="<%= doc.get('link') %>" title="<%= doc.escape('title') %>"><%= doc.escape('title') %></a></h3>
<p><%= doc.escape('lead') %></p>
<span class="icon" title="Dossier">Dossier</span>
<span class="info"><%= doc.relDate('published') %></span>
</script>

<script type="text/template" id="document-twitter-template">
<p><b><%= doc.escape('tweet_user_screen_name') %></b> <%= doc.getTweet() %></p>
<span class="icon" title="Twitter">Twitter</span>
<span class="info"><%= doc.relDate('published') %></span>
</script>

<script type="text/template" id="document-user-template">
<% if (doc.get('image')) { %><a href="{{ $view->url(['username' => ''], 'user') }}/<%= doc.escape('user') %>" title="<%= doc.escape('user') %>"><img src="{{ $view->baseUrl('images/cache/') }}<%= doc.get('image') %>" alt="" /></a><% } %>
<h3><a href="{{ $view->url(['username' => ''], 'user') }}/<%= doc.escape('user') %>"><%= doc.escape('user') %></a></h3>
<p><%= doc.escape('bio') %></p>
<span class="icon" title="Benutzer">Benutzer</span>
<span class="info"><%= doc.relDate('published') %></span>
</script>

<script type="text/template" id="document-event-template">
<h3><a href="<%= doc.get('link') %>" title="<%= doc.getEventTitle() %>"><%= doc.getEventTitle() %></a></h3>
<p><%= doc.get('event_organizer') %> <%= doc.get('event_town') %>, <%= doc.getEventDate() %> <%= doc.getEventTime() %></p>
<span class="icon" title="Veranstaltung">Veranstaltung</span>
<span class="info"><%= doc.relDate('published') %></span>
</script>

<script type="text/template" id="document-comment-template">
<h3><a href="<%= doc.get('link') %>" title="<%= doc.escape('subject') %>"><%= doc.escape('subject') %></a></h3>
<p><%= doc.get('message').length > 200 ? doc.escape('message').substr(0, 199) + '...' : doc.escape('message') %> <a href="<%= doc.get('link') %>" title="Weiterlesen">Weiterlesen</a></p>
<span class="icon" title="Kommentar">Kommentar</span>
<span class="info"><%= doc.relDate('published') %></span>
</script>

<script type="text/template" id="document-link-template">
<p><%= doc.escape('link_description') %> <a href="<%= doc.get('link_url') %>" title="<%= doc.escape('link_description') %>" target="_blank"><%= doc.escape('title') %></a></p>
<span class="icon" title="Link">Link</span>
<span class="info"><%= doc.relDate('published') %></span>
</script>

<script type="text/template" id="empty-search-list-template">{{block no_results}}{{dynamic}}
<p>Wir haben keine Resultate zu diesem Suchbegriff gefunden.<br />Bitte versuchen Sie einen anderen oder grenzen Sie Ihre Suche weniger stark ein.</p>
{{/dynamic}}{{/block}}</script>

<script src="{{ url static_file="_js/libs/underbackbone.js" }}"></script>     
<script src="{{ url static_file="_js/searchapp-a7aa7.js" }}"></script>
<script>
$(function() {
    window.documents = new DocumentCollection();
    documentsView = new DocumentListView({collection: documents, el: $('#results'), emptyTemplate: $('#empty-search-list-template')});
    paginationView = new PaginationView({collection: documents, el: $('#search-pagination') });
    {{block datefilter_script}}dateFilterView = new DateFilterView({collection: documents, el: $('#date-filter') });{{/block}}
});
</script>
{{/block}}

{{block content}}
{{block top}}{{/block}}
<aside class="mobile-hide"><div class="filter-aside">
    {{block aside}}{{/block}}
    {{block datefilter_wrap}}
    <ul id="date-filter">
        <li class="main"><a href="#">Alle</a></li>
        {{block datefilter}}
        <li><a href="#24h">Letzte 24 Stunden</a></li>
        <li><a href="#7d">Letzte 7 Tage</a></li>
        <li><a href="#1y">Dieses Jahr</a></li>
        {{/block}}
        <li class="range"><label for="range_from">Von</label> <input type="text" id="range_from" class="from" placeholder="TT.MM.JJ" /></li>
        <li class="range"><label for="range_to">Bis</label> <input type="text" id="range_to" class="to" placeholder="TT.MM.JJ" /></li>
        <li><input type="submit" value="Suchen" /></li>
    </ul>
    {{/block}}
</div></aside>
<section class="clearfix">
    {{block section}}{{/block}}
    <ul id="results" class="filter-list"></ul>

    <ul id="search-pagination" class="paging content-paging">
        <li class="prev"><a href="#" class="grey-button">&laquo;</a></li>
        <li><span class="start">1</span>/<span class="end">12</span></li>
        <li class="next"><a href="#" class="grey-button">&raquo;</a></li>
    </ul>
</section>
<script>
$(function() {
    {{ dynamic }}
    documents.reset(documents.parse({{ json_encode($result) }}));
    {{ /dynamic }}
});
</script>
{{/block}}
