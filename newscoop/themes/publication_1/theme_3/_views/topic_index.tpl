{{extends file="layout_search.tpl"}}

{{block aside}}
<script>
$(function() {
    window.router = new SearchRouter();
    Backbone.history.start({pushState: true, silent: true, root: {{ json_encode(sprintf('%s/', $view->url(['controller' => 'topic']), '/')) }} });
});
</script>
{{/block}}

{{block top}}
<ul class="top-filter clearfix">
    <li class="filter">&nbsp;</li>
    <li class="title"><h2>{{ if !empty($topic) }}Theme {{ $topic|escape }}{{ else }}Themen{{ /if }}</h2></li>
    <li class="type">Typ</li>
    <li class="time">Veröffentlicht</li>
</ul>
{{/block}}

{{block datefilter_wrap}}{{/block}}
{{block datefilter_script}}{{/block}}
{{block no_results}}
<script type="text/template" id="empty-search-list-template">
<p>No articles for given topic message.</p>
</script>
{{/block}}
