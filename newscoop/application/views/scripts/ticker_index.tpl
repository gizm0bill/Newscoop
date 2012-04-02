{{extends file="layout_search.tpl"}}

{{block aside}}
<h3>Quelle</h3>
<ul>
    <li><input type="checkbox"  /> <label>Alles</label></li>
    <li><input type="checkbox"  /> <label class="omni">Tageswoche</label></li>
    <li><input type="checkbox"  /> <label class="twitter">Twitter</label></li>
    <li><input type="checkbox"  /> <label class="article">Agentur</label></li>
    <li><input type="checkbox"  /> <label class="link">Link</label></li>
</ul>

<h3>Rubriken</h3>
<ul>
    <li><input type="checkbox"  /> <label>Basel</label></li>
    <li><input type="checkbox"  /> <label>Schweiz</label></li>
    <li><input type="checkbox"  /> <label>International</label></li>
    <li><input type="checkbox"  /> <label>Sport</label></li>
    <li><input type="checkbox"  /> <label>Kultur</label></li>
    <li><input type="checkbox"  /> <label>Leben</label></li>
    <li><input type="checkbox"  /> <label>Dossiers</label></li>
    <li><input type="checkbox"  /> <label>Blogs</label></li>
</ul>

<h3>Datum</h3>
<ul>
    <li><input type="checkbox"  /> <label>Heute</label></li>
    <li><input type="checkbox"  /> <label>Gestern</label></li>
    <li><input type="checkbox"  /> <label>Letzte 7 Tage</label></li>
    <li><label>Von</label> <input type="text" value="TT.MM.JJ" /></li>
    <li><label>Bis</label> <input type="text" value="TT.MM.JJ" /></li>
    <li><input type="submit" value="Suchen" /></li>
</ul>

<h3>Autoren</h3>
<ul>
    <li>
        <select>
            <option>Alle</option>
            <option>1</option>
            <option>2</option>
        </select>
    </li>
</ul>

<h3>Themen</h3>
<ul>
    <li>
        <select>
            <option>Alle</option>
            <option>1</option>
            <option>2</option>
        </select>
    </li>
</ul>

<script>
$(function() {
    window.router = new SearchRouter();
    searchFormView = new SearchFormView({collection: documents, el: $('#search-form') });
    typeFilterView = new TypeFilterView({collection: documents, el: $('#type-filter') });
    dateFilterView = new DateFilterView({collection: documents, el: $('#date-filter') });
    Backbone.history.start({pushState: true, root: {{ json_encode(sprintf('%s/', $view->url(['controller' => 'ticker']), '/')) }} });
});
</script>
{{/block}}

{{block section}}
<ul class="top-filter">
    <li>News</li>
    <li>Quelle</li>
    <li>veröffentlicht</li>
</ul>
{{/block}}
