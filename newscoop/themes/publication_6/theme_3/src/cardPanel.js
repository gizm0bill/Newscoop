cardPanel = new Ext.Panel({
  cls: 'card card1',
  html: 'Card Panel'
});

cardPanel.article = new Ext.TabPanel({
  tabBar: {
    dock: 'bottom',
    ui: 'light',
    layout: {
      pack: 'center'
    }
  }
});