{{extends file="layout_search.tpl"}}

{{block aside}}
<ul id="type-filter">
    <li class="main"><a href="#">Alle</a></li>
    <li><a href="#article">Artikel</a></li>
    <li><a href="#dossier">Dossiers</a></li>
    <li><a href="#blog">Blogbeiträge</a></li>
    <li><a href="#comment">Kommentare</a></li>
    <li><a href="#link">Links</a></li>
    <li><a href="#event">Veranstaltungen</a></li>
    <li><a href="#user">Community</a></li>
</ul>

<script>
$(function() {
    window.router = new SearchRouter();
    searchFormView = new SearchFormView({collection: documents, el: $('#search-form') });
    typeFilterView = new TypeFilterView({collection: documents, el: $('#type-filter') });
    sortView = new SortView({collection: documents, el: $('#sort-latest') });
    Backbone.history.start({pushState: true, silent: true, root: {{ json_encode(sprintf('%s/', $view->url(['controller' => 'search']), '/')) }} });
});
</script>
{{/block}}

{{block top}}
<ul class="top-filter clearfix">
    <li class="filter">Suche eingrenzen</li>
    <li class="title">
        <form id="search-form">
        <label for="search-query">Suchresultate für</label>
        <fieldset>
            <input id="search-query" type="text" value="" />
            <button>Go</button>
        </fieldset>
        <a href="#" class="info">Info <span>Sie können folgende Operatoren verwenden:<br />suchbegriff1 OR suchbegriff2<br />"exakte Wortkombination"<br />-nichtdieserbegriff<br />author:dani winter<br />topic:fc basel<br /></span></a>
        </form>
    </li>
    <li class="type">Typ</li>
    <li id="sort-latest" class="time">veröffentlicht <a class="sort" href="#">&nbsp;</a></li>
</ul>
{{/block}}
