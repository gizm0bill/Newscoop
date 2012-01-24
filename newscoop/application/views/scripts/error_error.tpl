{{extends file="layout.tpl"}}

{{block content}}
<h1>Hey, this is error!</h1>

<h2>Error: {{ $message }}</h2>

{{ foreach $errors as $error }}
{{ if !is_string($error) && is_a($error, 'Exception') }}
<code>{{ $error->getMessage()|truncate }}</code>
{{ /if }}
{{ /foreach }}

{{/block}}
