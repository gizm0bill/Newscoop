{{extends file="layout_search.tpl"}}

{{block aside}}
<script>
$(function() {
    window.router = new SearchRouter();
    Backbone.history.start({pushState: true, silent: window.location.hash.length == 0, root: {{ json_encode(sprintf('%s/', $view->url(['controller' => 'topic']), '/')) }} });
    $('head link:last').after('<link rel="alternate" type="application/rss-xml" href="{{ sprintf('%s%s?format=xml', $view->serverUrl(), $view->url(['topic' => $topic], 'topic')) }}" title="Tageswoche | Thema {{ $topic|escape }} [RSS]">');
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

{{block section}}
{{ if $gimme->user->logged_in }}{{ $userTopics=$gimme->user->topics }}
{{ if !in_array($topic, $userTopics) }}
<ul class="filter-list">
    <li><a href="#" id="follow-topic" class="theme-subscribe theme-abonnieren-trigger">Dieses Thema abonnieren</a></li>
</ul>
<script>
$(function() {
    $('#follow-topic').click(function(e) {
        e.preventDefault();
        var list = $(this).closest('.filter-list');
        $.post("{{ $view->url(['controller' => 'dashboard', 'action' => 'add-topic-by-name'], 'default') }}", {'topic': {{ json_encode($topic) }}, 'format': 'json'}, function(data, textStatus, jqXHR) {
            list.detach();
        });
    });
});
</script>
{{ /if }}{{ /if }}
{{/block}}

{{block datefilter_wrap}}{{/block}}
{{block datefilter_script}}{{/block}}
