{{extends file="layout_xml.tpl"}}

{{block title}}Tageswoche | Thema {{ $topic }}{{/block}}
{{block description}}Alle Artikel der TagesWoche zum Thema {{ $topic|escape }}{{/block}}
{{block rss_link}}{{ sprintf('%s%s?format=xml', $view->serverUrl(), $view->url(['topic' => $topic], 'topic')) }}{{/block}}
{{block atom_link}}{{ sprintf('%s%s?format=xml', $view->serverUrl(), $view->url(['topic' => $topic], 'topic')) }}{{/block}}
