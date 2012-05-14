{{extends file="layout_search.tpl"}}

{{block aside}}
{{* <h3>Themen wählen</h3>*}}
{{ dynamic }}
<ul id="topic-filter" class="user-topics">
    <li class="main"><a href="#">Alle Themen</a></li>
    {{ $topics = array() }}
    {{ if $gimme->user->logged_in }}
    {{ foreach $gimme->user->topics as $id => $topic }}{{ $topics[$id] = $topic }}
    <li id="topic-{{ $id }}"><a href="#{{ $topic|escape }}">{{ $topic|escape }}</a><br />
    {{ /foreach }}
    <li style="margin-top:1em"><a href="#theme-abonnieren-content" class="theme-abonnieren-trigger follow-topics-link">Themen bearbeiten</a></li>
    {{ /if }}
</ul>

{{ include file="_tpl/follow-topics.tpl" topics=$topics my=true }}
{{ /dynamic }}

</div><div class="filter-aside">

<h3>Hilfe</h3>
<ul>
    <li><em>Auf dieser Seite sehen Sie alle aktuellen Artikel zu den Themen, die Sie abonniert haben. Um weitere Themen zu abonnieren, klicken Sie auf die entsprechende Funktion bei einem Artikel.</em></li>
</ul>

<script>
$(function() {
    window.router = new SearchRouter();
    topicFilterView = new TopicFilterView({collection: documents, el: $('#topic-filter'), url: {{ json_encode($view->url(['controller' => 'dashboard', 'action' => 'update-topics'], 'default')) }} });
    topicSelectView = new TopicSelectView({collection: documents, el: $('#topics-box')});
    Backbone.history.start({pushState: true, silent: window.location.hash.length == 0, root: {{ json_encode(sprintf('%s/', $view->url(['controller' => 'my-topics']), '/')) }} });
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

{{block section}}
<div class="desktop-hide">
<select id="topics-box" name="topic">
    <option value="">Alle Themen</option>
    {{ dynamic }}
    {{ if $gimme->user->logged_in }}
    {{ foreach $gimme->user->topics as $topic }}
    <option value="{{ $topic|escape }}">{{ $topic|escape }}</option>
    {{ /foreach }}
    {{ /if }}
    {{ /dynamic }}
</select>
</div>
{{/block}}

{{block datefilter_wrap}}{{/block}}
{{block datefilter_script}}{{/block}}
{{block no_results}}
{{ dynamic }}{{ if !empty($noTopics) }}
<p>Sie haben noch keine Themen abonniert. Um ein Thema zu abonnieren, klicken Sie auf die entsprechende Funktion bei einem Artikel.</p>
{{ else }}
<p>Wir haben keine Resultate zu diesem Themen gefunden.</p>
{{ /if }}{{ /dynamic }}
{{/block}}
