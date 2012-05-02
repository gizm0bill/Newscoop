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
    <li class="title"><h2>{{ if !empty($topic) }}Thema {{ $topic|escape }}{{ else }}Themen{{ /if }}</h2></li>
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

{{block head_links}}<link rel="alternate" type="application/rss-xml" href="{{ sprintf('%s%s?format=xml', $view->serverUrl(), $view->url(['topic' => $topic], 'topic')) }}" title="Tageswoche | Thema {{ $topic|escape }} [RSS]">{{/block}}
{{block title append}} | Thema {{ $topic|escape }}{{/block}}
