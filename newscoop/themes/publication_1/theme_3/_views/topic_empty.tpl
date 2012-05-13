{{extends file="layout.tpl"}}

{{block content}}
<h2>Beliebteste Themen auf tageswoche.ch:</h2>
<ul>
    <li>Topic <a href="{{ $view->url(['topic' => 'Basel'], 'topic') }}">Basel</a></li>
    <li>Topic <a href="{{ $view->url(['topic' => 'Politik'], 'topic') }}">Politik</a></li>
</ul>
{{/block}}
