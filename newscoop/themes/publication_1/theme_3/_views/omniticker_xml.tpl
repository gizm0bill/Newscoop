{{extends file="layout_xml.tpl"}}

{{block title}}Tageswoche | Omniticker{{/block}}
{{block description}}Alle News der TagesWoche{{/block}}
{{block rss_link}}{{ sprintf('%s%s?format=xml', $view->serverUrl(), $view->url(['controller' => 'omniticker', 'action' => 'index'], 'default')) }}{{/block}}
{{block atom_link}}{{ sprintf('%s%s?format=xml', $view->serverUrl(), $view->url(['controller' => 'omniticker', 'action' => 'index'], 'default')) }}{{/block}}
