{{ set_publication identifier="1" }}
{{ set_current_issue }}

app.Structure = [
  {
    title:  false,
    text:   '<span class="webcode">Artikel aus der Zeitung aufrufen</span>',
    card:   cardPanel.webcodePanel,
    type:   'static',
    leaf:   true,
  },

{{ list_playlist_articles length="3" id="6" constraints="print is off" }}
  {
    number:         {{ $gimme->article->number }},
    name:           '{{ $gimme->article->name|jsencode }}',
    title:          '{{ $gimme->section->name|jsencode }}',
    text:           '{{ include file="mobile/src/data/article_listitem.tpl" index=$gimme->current_list->index }}',
    card:           cardPanel.articlePanel,
    url:            '{{ capture assign="url" }}{{ url options='article' }}{{ /capture }}{{ $url|jsencode }}',
    type:           'article',
    leaf:           true,
  },
{{ /list_playlist_articles }}

{{ include file="mobile/src/mobile_werbung.tpl.js" }}

{{ list_playlist_articles length="5" id="6" constraints="print is off" }}
  {{ if $gimme->current_list->index > 3 }}
    {
      number:         {{ $gimme->article->number }},
      name:           '{{ $gimme->article->name|jsencode }}',
      title:          '{{ $gimme->section->name|jsencode }}',
      text:           '{{ include file="mobile/src/data/article_listitem.tpl" }}',
      card:           cardPanel.articlePanel,
      url:            '{{ capture assign="url" }}{{ url options='article' }}{{ /capture }}{{ $url|jsencode }}',
      type:           'article',
      leaf:           true,
    },
  {{ /if }}
{{ /list_playlist_articles }}

  {
    title: 'Newsticker',
    name:  'Newsticker',
    text:  '<b>Newsticker</b>',
    card:  false,
    url:   '{{ url options="issue" }}newsticker/',
    type:  'section',
    leaf:  false,
  
    items: [
      {{ list_articles length="20" ignore_issue="true" ignore_section="true" order="bypublishdate desc" constraints="type is newswire section not 90" }}
        {
          number:         {{ $gimme->article->number }},
          name:           '{{ $gimme->article->name|jsencode }}',
          title:          'Newsticker',
          text:           '{{ include file="mobile/src/data/article_listitem.tpl" }}',
          card:           cardPanel.articlePanel,
          url:            '{{ capture assign="url" }}{{ url options='article' }}{{ /capture }}{{ $url|jsencode }}',
          type:           'article',
          leaf:           true,
        },
      {{ /list_articles }}
    ]
  },
    
{{ list_sections constraints="number smaller 51" }}
{{ assign var="section" value=$gimme->section->name }}
  {
    number:     '{{ $gimme->section->number }}',
    name:       '{{ $gimme->section->name|jsencode }}',
    title:      '{{ $gimme->section->name|jsencode }}',
    text:       '<b>{{ $gimme->section->name|jsencode }}</b>',
    card:       false,
    url:        '{{ url options="section" }}',
    type:       'section',
    leaf:       false,
  
    items: [
      {{ list_playlist_articles length="3" name=$gimme->section->name }}
        {
          number:         {{ $gimme->article->number }},
          name:           '{{ $gimme->article->name|jsencode }}',
          title:          '{{ $section|jsencode }}',
          text:           '{{ include file="mobile/src/data/article_listitem.tpl" }}',
          card:           cardPanel.articlePanel,
          url:            '{{ capture assign="url" }}{{ url options='article' }}{{ /capture }}{{ $url|jsencode }}',
          type:           'article',
          leaf:           true,
        },
      {{ /list_playlist_articles }}
      
      {{ include file="mobile/src/mobile_werbung.tpl.js" section=$section }}
      
      {{ list_playlist_articles length="12" name=$gimme->section->name }}
        {{ if $gimme->current_list->index > 3 }}
          {
            number:         {{ $gimme->article->number }},
            name:           '{{ $gimme->article->name|jsencode }}',
            title:          '{{ $section|jsencode }}',
            text:           '{{ include file="mobile/src/data/article_listitem.tpl" }}',
            card:           cardPanel.articlePanel,
            url:            '{{ capture assign="url" }}{{ url options='article' }}{{ /capture }}{{ $url|jsencode }}',
            type:           'article',
            leaf:           true,
          },
        {{ /if }}
      {{ /list_playlist_articles }}
    ]
  },
{{ /list_sections }}

{{ include file="mobile/src/dossiers/structure.tpl.js" }} 
{{ include file="mobile/src/blogs/structure.tpl.js" }}  

{{ list_articles ignore_issue="true" ignore_section="true" constraints="issue is 1 section is 10 type is static_page" }}
  {
    number:         {{ $gimme->article->number }},
    name:           '{{ $gimme->article->name|jsencode }}',
    title:          false,
    text:           '<h2>{{ $gimme->article->name|jsencode }}</h2>',
    card:           cardPanel.articlePanel,
    url:            '{{ capture assign="url" }}{{ url options='article' }}{{ /capture }}{{ $url|jsencode }}',
    type:           'article',
    leaf:           true,
  },
{{ /list_articles }}

];

if (!Ext.is.Phone) {
  app.Structure.push({{ include file="mobile/src/aboStructure.js" }});
}

Ext.regModel('Demo', {
  fields: [
  {name: 'title',           type: 'string'}, /* title for navigation items. maybee truncated */
  {name: 'short',           type: 'string'}, /* short name for navigation bar */
  {name: 'name',            type: 'string'}, /* full title for tracking */
  {name: 'number',          type: 'int'},
  {name: 'text',            type: 'string'},
  {name: 'url',             type: 'string'},
  {name: 'type',            type: 'string'},
  {name: 'card'},
  {name: 'link',            type: 'string'}, /* target link for ads */
  {name: 'cls',             type: 'string'},
  ]
});

app.StructureStore = new Ext.data.TreeStore({
  model: 'Demo',
  root: {
    items: app.Structure
  },
  proxy: {
    type: 'ajax',
    reader: {
      type: 'tree',
      root: 'items'
    }
  }
});

