{{ set_publication name="tageswoche" }}
{{ set_language name="German" }}
{{ set_current_issue }}


app.Structure = [
  {{ list_sections constraints="number smaller 51" order="byNumber asc" }}
    {
        title:  '{{ $gimme->section->name|addslashes }}',
        text:   '{{ $gimme->section->name|addslashes }}',
        cls:    'launchscreen',
        card:   Ext.is.Phone ? false : cardPanel.article,
        type:   'section',
        
        items: [
          {{ list_articles length="20" }}        
            {
                title:  '{{ $gimme->article->name|addslashes }}',
                text:   '<img src="img/img01.jpg" />{{ $gimme->article->name|addslashes }}',
                card:   cardPanel.article,
                source: "{{ url options="template src/data/article.tpl" }}",
                type:   'article',
                leaf:   true
            },
          {{ /list_articles }}
        ]
    },
    
    {{ list_articles length="2" }}
      {
        title:      '{{ $gimme->article->name|addslashes }}',
        text:       '<img src="img/img01.jpg" />{{ $gimme->article->name|addslashes }}',
        card:       cardPanel.article,
        source:     "{{ url options="template src/data/article.tpl" }}",
        type:       'article',
        leaf:       true
      },
    {{ /list_articles }}
    
  {{ /list_sections }}
];

Ext.regModel('Demo', {
    fields: [
        {name: 'title',       type: 'text'},
        {name: 'text',        type: 'string'},
        {name: 'source',      type: 'string'},
        {name: 'preventHide', type: 'boolean'},
        {name: 'cardSwitchAnimation'},
        {name: 'card'},
        {name: 'type',   type: 'string'},
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
