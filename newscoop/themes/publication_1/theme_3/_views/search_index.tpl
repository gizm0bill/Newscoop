{{extends file="layout_search.tpl"}}

{{block aside}}
<h3>Suche eingrenzen</h3>
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
<ul class="top-filter">
    <li class="filter">Filter</li>
    <li class="title">
        <form id="search-form">
        <label>Sucheresultate für</label>
        <fieldset>
            <input type="text" value="" />
            <button>Go</button>
        </fieldset>
        <small style="font-weight: normal;padding-left:3px" id="did-you-mean">Did you mean: <a href="#"></a>?</small>
        </form>
    </li>
    <li class="type">Typ</li>
    <li id="sort-latest" class="time">veröffentlicht</li>
</ul>
{{/block}}