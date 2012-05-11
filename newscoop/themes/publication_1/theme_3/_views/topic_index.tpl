{{extends file="layout_search.tpl"}}

{{block aside}}
<script>
$(function() {
    window.router = new SearchRouter();
    Backbone.history.start({pushState: true, silent: window.location.hash.length == 0, root: {{ json_encode(sprintf('%s/', $view->url(['controller' => 'topic']), '/')) }} });
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

{{block head_links}}<link rel="alternate" type="application/rss-xml" href="{{ sprintf('%s%s?format=xml', $view->serverUrl(), $view->url(['topic' => $topic], 'topic')) }}" title="Tageswoche | Thema {{ $topic|escape }} [RSS]">{{/block}}
{{block title append}} | Thema {{ $topic|escape }}{{/block}}
