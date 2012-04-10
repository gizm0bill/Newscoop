Ext.ns('cardPanel');

cardPanel = new Ext.Panel({
  cls: 'card card1',
  html: 'Card Panel'
});

cardPanel.articlePanel = new Ext.Panel({
  defaults: {scroll: 'vertial'},
  layout: 'card',
  type: 'article',
  {{ if isset($smarty.request.mask) }}onCardSwitch: function(){Ext.getBody().unmask()},{{ /if }}
});

{{ set_publication identifier="1" }}

cardPanel.webcodePanel = new Ext.Panel({
  defaults: {scroll: 'vertial'},
  id: 'webcode',
  type: 'static',
  items: [{
    html: '<form name="webcode" id="webcode-form" onSubmit="location.href=\'http://\' + document.getElementById(\'webcode-value\').value; return false">' + 
          '  <input type="text" name="webcode" value="{{ $gimme->publication->site }}/+" id="webcode-value">' + 
          '  <input type="submit" value="&gt;&gt;&gt">' + 
          '</form>'+
          '<p><b>Webcode: Der direkte Link von der Zeitung ins Netz</h1><p>Unter jedem Artikel in der Zeitung steht ein Webcode. ' + 
          'Geben Sie diesen hier ein, um den Artikel direkt online aufzurufen, zu kommentieren oder jemandem weiterzuleiten.</b></p>',
  }],
});

{{ set_default_publication }}
{{ set_default_issue }}
{{ set_default_section }}
{{ set_default_article }}

if (!Ext.is.Phone) {
  {{ include file="mobile/src/aboPanel.js" }}
};

{{ if $gimme->article->defined }}
  {{ include file="mobile/src/data/article.tpl.js" }}
{{ /if }}