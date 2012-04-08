try { 
  cardPanel.articlePanel.add([{
      id: 'articlebody_{{ $gimme->article->number }}',
      number: {{ $gimme->article->number }}, 
      type: 'articlebody',
       title: '{{ $gimme->section->name|jsencode }}',
      html: '{{ include file="mobile/src/data/article_body.tpl.js" }}',
      iconCls: 'bookmarks',
      cls: 'card card1',
    },
    new Ext.TabPanel({
      id: 'articlemeta_{{ $gimme->article->number }}',
      number: {{ $gimme->article->number }},
      type: 'articlemeta',
      defaults: {scroll: 'vertial'},
      tabBar: {
        dock: 'bottom',
        ui: 'light',
        layout: {
          pack: 'center'
        },
      },
      
{{ include file="mobile/src/data/article_info.tpl.js" assign="items_html" }}
      items: [{
        id: 'articleinfo_{{ $gimme->article->number }}',
        title: 'Info',
        html: '{{ trim($items_html) }}',
        iconCls: 'info',
        cls: 'card card2',
      },
      {
        id: 'articlecomments_{{ $gimme->article->number }}',
        title: 'Kommentare',
        html: '{{ include file="mobile/src/data/article_comments.tpl.js" }}',
        cls: 'card card3',
        iconCls: 'user',
        badgeText: '{{ $gimme->article->comment_count }}',
      },
    ]}),
    
    {{ if $gimme->article->type_name == 'blog' && $gimme->section->number == 200 }}
      {{* bildblog slideshow *}}
      {{ include file="mobile/src/blogs/carousel.tpl.js" }}
    {{ /if }}
    
    {{ if $gimme->article->type_name == "news" || $gimme->article->type_name == "blog" }}
      {{* news/blog article slideshow *}}
      {{ include file="mobile/src/data/carousel.tpl.js" }}
    {{ /if }}
  ]);
  
  //cardPanel.articlePanel.doLayout();
  //cardPanel.articlePanel.setActiveItem('articlebody_{{ $gimme->article->number }}');

} catch(e) {
  console.log('Warning: catched error while loading article context.');
  console.debug(e);
};

{{ if $smarty.request.callback }}{{ $smarty.request.callback }}(this);{{ /if }}
