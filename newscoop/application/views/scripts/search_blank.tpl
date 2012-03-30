{{extends file="layout.tpl"}}

{{block content}}
<h1>To start search, put your query and hit search button</h1>

<form method="GET" action="{{ $view->url() }}">
    <input type="text" name="q" placeholder="your query..." />
    <input type="submit" value="Search" />
</form>
{{/block}}
