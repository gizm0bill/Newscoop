{{extends file="layout.tpl"}}

{{block content}}
<div id="app">
    <input type="text" id="search-field" placeholder="" />

    <h1>Search results for '<span id="search-query"></span>'</h1>
    <p>Total count: <span id="search-count"></span>.</p>

    <div id="type-filter">
        <a href="#">Alle</a>
        <a href="#news">News</a>
        <a href="#blogs">Blogs</a>
        <a href="#user">Users</a>
    </div>

    <div id="date-filter">
        <a href="#">Alle</a>
        <a href="#24h">24 hours</a>
        <a href="#7d">7 days</a>
        <a href="#1y">1 year</a>
    </div>

    <ul id="results"></ul>
</div>

<script type="text/template" id="doc">
    <% if (doc.get('type') === 'user') { %>
    <h3><%= doc.escape('user') %></h3>
    <p><%= doc.escape('bio') %></p> <% } else if (doc.get('type') === 'comment') { %>
    <h3><%= doc.get('subject') %></h3>
    <p><%= doc.get('message') %></p>
    <% } else { %>
    <h3><%= doc.get('headline') %></h3>
    <p><%= doc.get('lead') %></p>
    <% } %>
</script>

<script type="text/javascript" src="{{ $view->baseUrl('js/jquery/jquery-1.6.4.min.js') }}"></script>
<script type="text/javascript" src="{{ $view->baseUrl('js/underscore.js') }}"></script>
<script type="text/javascript" src="{{ $view->baseUrl('js/backbone.js') }}"></script>
<script type="text/javascript" src="{{ $view->baseUrl('js/models.js') }}"></script>
<script type="text/javascript" src="{{ $view->baseUrl('js/views.js') }}"></script>
<script type="text/javascript" src="{{ $view->baseUrl('js/urls.js') }}"></script>
<script type="text/javascript">
$(function() {
    var documents = new DocumentCollection();
    var router = new SearchRouter();
    var appView = new ResultView({collection: documents, router: router});
    Backbone.history.start({pushState: true, root: {{ json_encode($view->baseUrl('/')) }}});
    documents.parseReset({{ json_encode($result) }});
});
</script>
{{/block}}
