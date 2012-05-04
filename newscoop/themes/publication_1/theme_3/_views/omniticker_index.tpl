{{extends file="layout_search.tpl"}}

{{block aside}}
<h3>Quelle</h3>
<ul id="source-filter">
    <li class="main"><a href="#">Alle</a></li>
    <li><a href="#tageswoche" class="omni">Tageswoche</a></li>
    <li><a href="#twitter" class="twitter">Twitter</a></li>
    <li><a href="#agentur" class="article">Agentur</a></li>
    <li><a href="#link" class="link">Link</a></li>
</ul>

<h3>Rubriken</h3>
<ul id="section-filter">
    <li class="main"><a href="#">Alle</a></li>
    <li><a href="#basel">Basel</a></li>
    <li><a href="#schweiz">Schweiz</a></li>
    <li><a href="#international">International</a></li>
    <li><a href="#sport">Sport</a></li>
    <li><a href="#kultur">Kultur</a></li>
    <li><a href="#leben">Leben</a></li>
    <li><a href="#blog">Blogs</a></li>
</ul>

<script>
$(function() {
    window.router = new SearchRouter();
    sourceFilterView = new SourceFilterView({collection: documents, el: $('#source-filter') });
    sectionFilterView = new SectionFilterView({collection: documents, el: $('#section-filter') });
    Backbone.history.start({pushState: true, silent: window.location.hash.length == 0, root: {{ json_encode(sprintf('%s/', $view->url(['controller' => 'omniticker']), '/')) }} });
});
</script>
{{/block}}

{{block top}}
<ul class="top-filter clearfix">
    <li class="filter">Filter</li>
    <li class="title">Omniticker</li>
    <li class="type">Quelle</li>
    <li class="time">Veröffentlicht</li>
</ul>
{{/block}}

{{block datefilter}}
<li><a href="#1d">Heute</a></li>
<li><a href="#2d">Gestern</a></li>
<li><a href="#7d">Letzte 7 Tage</a></li>
{{/block}}

{{block title append}} | Omniticker{{/block}}
