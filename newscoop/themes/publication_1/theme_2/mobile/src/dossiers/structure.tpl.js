{{ set_issue number="1" }}

{
  title:      'Dossiers',
  text:       '<b>Dossiers</b>',
  card:       false,
  url:        '{{ url options="section" }}',
  type:       'section',
  leaf:       false,
  items: [
    
    {{ list_articles length="10" ignore_issue="true" ignore_section="true" constraints="type is dossier active is on" order="bysection desc" }}
      {{ assign var="title" value=$gimme->article->name }}
      {{ if strlen($gimme->article->short_name) }}
        {{ assign var="short" value=$gimme->article->short_name }}
      {{ else }}
        {{ assign var="short" value=$gimme->article->name|truncate:12 }}
      {{ /if }}
      {
        number:     '{{ $gimme->article->number }}',
        name:       '{{ $gimme->article->name|jsencode }}',
        title:      '{{ $gimme->article->name|jsencode }}',
        short:      '{{ if strlen($gimme->article->short_name) }}{{ $gimme->article->short_name|jsencode }}{{ else }}{{ $gimme->article->name|truncate:12|jsencode }}{{ /if }}',
        text:       '{{ include file="mobile/src/dossiers/listitem.tpl" }}',
        card:       false,
        url:        '{{ url options="section" }}',
        type:       'section',
        leaf:       false,
        cls:        'x-list-item-leaf',
        items: [
          {{ list_related_articles }}
            {
              number:         {{ $gimme->article->number }},
              name:           '{{ $gimme->article->name|jsencode }}',
              title:          '{{ $title|jsencode }}',
              short:          '{{ $short|jsencode }}',
              text:           '{{ include file="mobile/src/dossiers/listitem.tpl" }}',
              card:           cardPanel.articlePanel,
              url:            '{{ capture assign="url" }}{{ url options='article' }}{{ /capture }}{{ $url|jsencode }}',
              type:           'article',
              leaf:           true,
            },
          {{ /list_related_articles }}
        ]
      },
    {{ /list_articles }}     
  ]
},

{{ set_current_issue }}
