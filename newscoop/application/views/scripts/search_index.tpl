{{extends file="layout_search.tpl"}}

{{block content}}
<aside>
    <h3>Suche eingrenzen</h3>
    <ul id="type-filter">
        <li class="main"><a href="#">Alle</a></li>
        <li><a href="#article">Artikel</a></li>
        <li><a href="#dossier">Dossiers</a></li>
        <li><a href="#blog">Blogbeitrage</a></li>
        <li><a href="#comment">Kommentare</a></li>
        <li><a href="#link">Links</a></li>
        <li><a href="#event">Veranstaltungen</a></li>
        <li><a href="#user">Nutzer</a></li>
    </ul>

    <ul id="date-filter">
        <li class="main"><a href="#">Alle</a></li>
        <li><a href="#24h">Letzte 24 Stunden</a></li>
        <li><a href="#7d">Letzte 7 Tage</a></li>
        <li><a href="#1y">Das Jahr</a></li>
        <li><label>Von</label> <input type="text" class="from" placeholder="TT.MM.JJ" /></li>
        <li><label>Bis</label> <input type="text" class="to" placeholder="TT.MM.JJ" /></li>
        <li><input type="submit" value="Suchen" /></li>
    </ul>
</aside>

<section>
    <ul class="top-filter">
        <li>
            <label>Sucheresultate für</label>
            <fieldset id="search-form">
                <input type="text" value="" />
                <button>Go</button>
            </fieldset>
        </li>
        <li>Typ</li>
        <li>veröffentlicht</li>
    </ul>

    <ul id="results" class="filter-list">
    </ul>

    <ul id="search-pagination" class="paging content-paging">
        <li class="prev"><a href="#" class="grey-button">&laquo;</a></li>
        <li><span class="start">1</span>/<span class="end">12</span></li>
        <li class="next"><a href="#" class="grey-button">&raquo;</a></li>
    </ul>
</section>
    
<script type="text/template" id="document-news-template">
<img src="<%= doc.get('image') %>" alt="" width="90" />
<h3><a href="#"><%= doc.escape('title') %></a></h3>
<p><%= doc.escape('lead') %></p>
<span class="time"><%= doc.relDate('published') %></span>
</script>

<script type="text/template" id="document-twitter-template">
<p><b><%= doc.escape('tweet_user_screen_name') %></b> <%= doc.escape('tweet') %></p>
<span class="time"><%= doc.relDate('published') %></span>
</script>

<script type="text/template" id="document-user-template">
<h3><a href="#"><%= doc.escape('user') %></a></h3>
<p><%= doc.escape('bio') %></p>
</script>

<script src="{{ $view->baseUrl('js/jquery/jquery-1.6.4.min.js') }}"></script>
<script src="{{ $view->baseUrl('js/underscore.js') }}"></script>
<script src="{{ $view->baseUrl('js/backbone.js') }}"></script>
<script src="{{ $view->baseUrl('js/apps/search.js') }}"></script>
<script>
$(function() {
    window.documents = new DocumentCollection();
    window.router = new SearchRouter();

    documentsView = new DocumentListView({collection: documents, el: $('#results')});
    searchFormView = new SearchFormView({collection: documents, el: $('#search-form') });
    typeFilterView = new TypeFilterView({collection: documents, el: $('#type-filter') });
    dateFilterView = new DateFilterView({collection: documents, el: $('#date-filter') });
    paginationView = new PaginationView({collection: documents, el: $('#search-pagination') });

    Backbone.history.start({pushState: true, root: {{ json_encode(sprintf('%s/', $view->url(['controller' => 'search']), '/')) }} });
    documents.reset(documents.parse({{ json_encode($result) }}));
});
</script>
{{/block}}
