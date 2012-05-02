{{extends file="layout.tpl"}}

{{block content}}
<p>No topic specified. Try one of those:</p>
<ul>
    <li>Topic <a href="{{ $view->url(['topic' => 'Basel'], 'topic') }}">Basel</a></li>
    <li>Topic <a href="{{ $view->url(['topic' => 'Politik'], 'topic') }}">Politik</a></li>
</ul>
{{/block}}
