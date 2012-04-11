{{extends file="layout_search.tpl"}}

{{block aside}}
<h3>Quelle</h3>
<ul id="source-filter">
    <li><input type="checkbox" id="source_all" /> <label for="source_all">Alles</label></li>
    <li><input type="checkbox" id="source_1" value="tageswoche" /> <label for="source_1" class="omni">Tageswoche</label></li>
    <li><input type="checkbox" id="source_2" value="twitter"  /> <label for="source_2" class="twitter">Twitter</label></li>
    <li><input type="checkbox" id="source_3" value="agentur" /> <label for="source_3" class="article">Agentur</label></li>
    <li><input type="checkbox" id="source_4" value="link" /> <label for="source_4" class="link">Link</label></li>
</ul>

<h3>Rubriken</h3>
<ul id="section-filter">
    <li><input type="checkbox" id="section_1" value="basel" /> <label for="section_1">Basel</label></li>
    <li><input type="checkbox" id="section_2" value="schweiz" /> <label for="section_2">Schweiz</label></li>
    <li><input type="checkbox" id="section_3" value="international" /> <label for="section_3">International</label></li>
    <li><input type="checkbox" id="section_4" value="sport" /> <label for="section_4">Sport</label></li>
    <li><input type="checkbox" id="section_5" value="kultur" /> <label for="section_5">Kultur</label></li>
    <li><input type="checkbox" id="section_6" value="leben"  /> <label for="section_6">Leben</label></li>
    <li><input type="checkbox" id="section_7" value="dossier" /> <label for="section_7">Dossiers</label></li>
    <li><input type="checkbox" id="section_8" value="blog" /> <label for="section_8">Blogs</label></li>
</ul>

<h3>Datum</h3>
<ul id="date-filter">
    <li><input type="checkbox"  /> <label>Heute</label></li>
    <li><input type="checkbox"  /> <label>Gestern</label></li>
    <li><input type="checkbox"  /> <label>Letzte 7 Tage</label></li>
    <li><label>Von</label> <input type="text" value="TT.MM.JJ" /></li>
    <li><label>Bis</label> <input type="text" value="TT.MM.JJ" /></li>
    <li><input type="submit" value="Suchen" /></li>
</ul>

<script>
$(function() {
    window.router = new SearchRouter();
    sourceFilterView = new SourceFilterView({collection: documents, el: $('#source-filter') });
    dateFilterView = new DateFilterView({collection: documents, el: $('#date-filter') });
    sectionFilterView = new SectionFilterView({collection: documents, el: $('#section-filter') });
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
