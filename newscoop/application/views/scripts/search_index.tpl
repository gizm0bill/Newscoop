{{extends file="layout.tpl"}}

{{ if $result }}
{{block content}}

<div id="app"></div>

<h2>Results</h2>
<ul id="document-list"></ul>

<script type="text/template" id="search-result">
    <h1>Search results for '<%= result.escape('query') %>'</h1>
    <p>Total count: <%= result.escape('count') %>.</p>
    <input type="text" id="search-field" value="<%= result.escape('query') %>" />

    <ul id="facets">
        <% _.each(_.keys(result.get('facets_type')), function(facet) { %>
        <li><a href="#<%= facet %>"><%= facet %> (<%= result.get('facets_type')[facet] %>)</a></li>
        <% }) %>
    </ul>
</script>

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
<script type="text/javascript" src="{{ $view->baseUrl('js/search.js') }}"></script>
<script type="text/javascript">
$(function() {
    var result = new Result({{ json_encode($result) }});
    var router = new SearchRouter(result);
    Backbone.history.start({pushState: true, root: {{ json_encode($view->baseUrl('/')) }}});
});
</script>
{{/block}}

{{ else }}
{{ block content }}
<h1>Search - use form to begin search</h1>

{{ $form }}
{{ /block }}
