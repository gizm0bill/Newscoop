{{extends file="layout.tpl"}}

{{block content}}
<h2>no topic set. try one of those:</h2>
<ul>
    <li>Topic <a href="{{ $view->url(['topic' => 'Basel'], 'topic') }}">Basel</a></li>
    <li>Topic <a href="{{ $view->url(['topic' => 'Politik'], 'topic') }}">Politik</a></li>
</ul>
{{/block}}
