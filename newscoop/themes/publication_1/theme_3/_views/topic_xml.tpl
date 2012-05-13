{{extends file="layout_xml.tpl"}}

{{block title}}Tageswoche | Thema {{ $topic->name|escape }}{{/block}}
{{block description}}Alle Artikel der TagesWoche zum Thema {{ $topic->name|escape }}{{/block}}
{{block rss_link}}{{ sprintf('%s%s?format=xml', $view->serverUrl(), $view->url(['topic' => $topic->name], 'topic')) }}{{/block}}
{{block atom_link}}{{ sprintf('%s%s?format=xml', $view->serverUrl(), $view->url(['topic' => $topic->name], 'topic')) }}{{/block}}
