{{extends file="layout_search.tpl"}}

{{block aside}}
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

<script>
$(function() {
    window.router = new SearchRouter();
    searchFormView = new SearchFormView({collection: documents, el: $('#search-form') });
    typeFilterView = new TypeFilterView({collection: documents, el: $('#type-filter') });
    dateFilterView = new DateFilterView({collection: documents, el: $('#date-filter') });
    Backbone.history.start({pushState: true, root: {{ json_encode(sprintf('%s/', $view->url(['controller' => 'search']), '/')) }} });
});
</script>
{{/block}}

{{block section}}
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
{{/block}}
