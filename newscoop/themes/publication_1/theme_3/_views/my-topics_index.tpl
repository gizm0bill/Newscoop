{{extends file="layout_search.tpl"}}

{{block aside}}
<h3>Themen wählen</h3>
<ul id="topic-filter">
    <li class="main"><a href="#">Alle Themen</a></li>
    {{ dynamic }}
    {{ if $gimme->user->logged_in }}
    {{ foreach $gimme->user->topics as $topic }}
    <li><a href="#{{ $topic }}">{{ $topic }}</a><br />
    <em id="topic-{{ $topic@key }}">entfernen</em></li>
    {{ /foreach }}
    {{ /if }}
    {{ /dynamic }}
</ul>

</div><div class="filter-aside">

<h3>Hilfe</h3>
<ul>
    <li><em>Wie man neue Themen abonniert, steht eventuell hier in einer Hilfebox.</em></li>
</ul>

<script>
$(function() {
    window.router = new SearchRouter();
    topicFilterView = new TopicFilterView({collection: documents, el: $('#topic-filter'), url: {{ json_encode($view->url(['controller' => 'dashboard', 'action' => 'update-topics'], 'default')) }} });
    Backbone.history.start({pushState: true, silent: true, root: {{ json_encode(sprintf('%s/', $view->url(['controller' => 'my-topics']), '/')) }} });
});
</script>
{{/block}}

{{block top}}
<ul class="top-filter clearfix">
    <li class="filter">Filter</li>
    <li class="title"><h2>Meine Themen</h2></li>
    <li class="type">Typ</li>
    <li class="time">Veröffentlicht</li>
</ul>
{{/block}}

{{block datefilter_wrap}}{{/block}}
{{block datefilter_script}}{{/block}}
{{block no_results}}
<script type="text/template" id="empty-search-list-template">
{{ dynamic }}{{ if !empty($noTopics) }}<p>You have no topics. What can I do?</p>{{ else }}<p>No articles for given topics message.</p>{{ /if }}{{ /dynamic }}
</script>
{{/block}}
