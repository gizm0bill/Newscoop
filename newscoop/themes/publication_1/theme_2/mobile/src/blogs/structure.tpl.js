{{ set_publication identifier="5" }}
{
  title:      'Blogs',
  text:       '<b>Blogs</b>',
  card:       false,
  url:        '{{ url options="section" }}',
  type:       'section',
  leaf:       false,
  items: [
    
    {{ list_articles ignore_issue="true" ignore_section="true" order="byName asc" constraints="type is bloginfo active is on" }}
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
        text:       '{{ include file="mobile/src/blogs/listitem.tpl" }}',
        card:       false,
        url:        '{{ url options="section" }}',
        type:       'section',
        leaf:       false,
        cls:        'x-list-item-leaf',
        items: [
          {{ list_articles constraints="type is blog" }}
            {
              number:         {{ $gimme->article->number }},
              name:           '{{ $gimme->article->name|jsencode }}',
              title:          '{{ $title|jsencode }}',
              short:          '{{ $short|jsencode }}',
              text:           '{{ include file="mobile/src/blogs/listitem.tpl" }}',
              card:           cardPanel.articlePanel,
              url:            '{{ capture assign="url" }}{{ url options='article' }}{{ /capture }}{{ $url|jsencode }}',
              type:           'article',
              leaf:           true,
            },
          {{ /list_articles }}
        ]
      },
    {{ /list_articles }}     
  ]
}, 
{{ set_publication identifier="1" }}
