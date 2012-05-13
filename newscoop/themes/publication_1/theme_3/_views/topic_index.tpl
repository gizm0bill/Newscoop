{{extends file="layout_search.tpl"}}

{{block aside}}
<script>
$(function() {
    window.router = new SearchRouter();
    Backbone.history.start({pushState: true, silent: window.location.hash.length == 0, root: {{ json_encode(sprintf('%s/', $view->url(['controller' => 'topic']), '/')) }} });
    $('head link:last').after('<link rel="alternate" type="application/rss-xml" href="{{ sprintf('%s%s?format=xml', $view->serverUrl(), $view->url(['topic' => $topic->name], 'topic')) }}" title="Tageswoche | Thema {{ $topic->name|escape }} [RSS]">');
});
</script>
{{/block}}

{{block top}}
<ul class="top-filter clearfix">
    <li class="filter">&nbsp;</li>
    <li class="title"><h2>Thema {{ $topic->name|escape }}</h2></li>
    <li class="type">Typ</li>
    <li class="time">Veröffentlicht</li>
</ul>
{{/block}}

{{block section}}
<ul class="filter-list">
    <li><a href="#theme-abonnieren-content" class="theme-subscribe theme-abonnieren-trigger follow-topics-link">Dieses Thema abonnieren</a></li>
</ul>
{{ include file="_tpl/follow-topics.tpl" topics=[$topic->id => $topic->name] }}
{{/block}}

{{block datefilter_wrap}}{{/block}}
{{block datefilter_script}}{{/block}}
