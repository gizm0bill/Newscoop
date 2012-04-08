cardPanel.article.remove('articleTitle');
cardPanel.article.remove('articleInfo');
cardPanel.article.remove('articleComments');
cardPanel.article.remove('articleFeedback');

cardPanel.article.add([{
    title: 'Artikel',
    html: '{{ $gimme->article->DataContent|strip|addslashes }}',
    iconCls: 'bookmarks',
    cls: 'card card1',
    id: 'articleTitle'
  },
  {
    title: 'Info',
    html: 'EINS Autoren etc',
    iconCls: 'info',
    cls: 'card card2',
    id: 'articleInfo'
  },
  {
    title: 'Kommentare',
    html: 'EINS Kommentare',
//         badgeText: 'Text can go here too, but it will be cut off if it is too long.',
    cls: 'card card3',
    iconCls: 'user',
    badgeText: '4',
    id: 'articleComments'
  },
  {
    title: 'Feedback',
    html: 'EINS Schreiben',
    cls: 'card card4',
    iconCls: 'compose',
    id: 'articleFeedback'
  }
]);

cardPanel.article.doLayout();
{{ $smarty.get.callback }}(this);