Ext.ns('app', 'cardPanel', 'Ext.ux');

{{ set_publication identifier="1" }}
{{ set_current_issue }}

{{ if isset($smarty.request.tablet) }}Ext.is.Phone = false;{{ /if }}
{{ if isset($smarty.request.phone) }}Ext.is.Phone = true;{{ /if }}

Ext.ux.UniversalUI = Ext.extend(Ext.Panel, {
  fullscreen: true,
  layout: 'card',
  items: [{
    cls: 'launchscreen',
    html: '<div class="logobig"><span>TagesWoche</span></div>'
  }],
  backText: 'back',
  reloadText: 'reload',
  maskText: 'Loading&hellip;',
  useTitleAsBackText: true,
  navigationItem: {},
  loadedItems: [],
  homeurl: '/',

  initComponent : function() {
    this.navigationButton = new Ext.Button({
      hidden: Ext.is.Phone || Ext.Viewport.orientation == 'landscape',
      text: 'Navigation',
      handler: this.onNavButtonTap,
      scope: this
    });

    this.backButton = new Ext.Button({
      text: this.backText,
      ui: 'back',
      handler: this.onUiBack,
      hidden: true,
      scope: this
    });

    this.reloadButton = new Ext.Button({
      {{* could use standard buttons, but coloring is wrong
      iconMask: true,
      iconCls: 'refresh',
      *}}
      text: this.reloadText,
      baseCls: '',
      handler: this.onUiReload,
      hidden: false,
      scope: this
    });
    
    this.articleFlipButton = new Ext.Button({
      text: this.articleFlipText,
      baseCls: '',
      handler: this.onArticleFlip,
      hidden: true,
      scope: this,
    });
    //this.articleFlipButton.addListener('beforeTap', this.onArticleFlip);
    {{ if isset($smarty.request.mask) }}this.articleFlipButton.addListener('beforeTap', function() {Ext.getBody().mask()});{{ /if }}
    
    this.noMobileHomeButton = new Ext.Button({
      {{* could use standard buttons, but coloring is wrong
      iconMask: true,
      iconCls: 'action',
      *}}
      text: this.noMobileText,
      baseCls: '',
      handler: this.onNoMobileHome,
      hidden: false,
      scope: this
    });
    
    this.noMobileArticleButton = new Ext.Button({
      {{* could use standard buttons, but coloring is wrong
      iconMask: true,
      iconCls: 'action',
      *}}
      text: this.noMobileText,
      baseCls: '',
      handler: this.onNoMobileArticle,
      hidden: true,
      scope: this
    });

    var btns = [this.navigationButton];

    if (Ext.is.Phone) {
      btns.unshift(this.backButton);
    }

    /*
     * This is the navigation bar on top.
     * On phone this is stadalone, 
     * on pad is is part of navigation panel.
     */
    this.navigationBar = new Ext.Toolbar({
      id: 'navigationbar',
      ui: 'dark',
      dock: 'top',
      title: this.title,
      items: Ext.is.Phone ? 
        btns.concat({xtype: 'spacer'}, this.articleFlipButton, this.reloadButton) : 
        btns.concat(this.noMobileArticleButton, {xtype: 'spacer'}, this.articleFlipButton),
    });

    /* 
     * This is the navigation panel.
     * On pad in landscape mode this is standalone navi on the left panel,
     * on pad in portrait mode it can be opened/closed.
     */
    this.navigationPanel = new Ext.NestedList({
      id: 'navigationpanel',
      store: app.StructureStore,
      useToolbar: Ext.is.Phone ? false : true,
      updateTitleText: true,
      backText: this.backText,
      dock: 'left',
      hidden: !Ext.is.Phone && Ext.Viewport.orientation == 'portrait',
      toolbar: Ext.is.Phone ? 
        this.navigationBar : 
        {
          title: this.title,
          xtype: 'toolbar',
          dock: 'top',
          items: [
            this.noMobileHomeButton,         
            {xtype: 'spacer'},
            this.reloadButton,
          ]
        },
      listeners: {
        itemtap: this.onNavPanelItemTap, 
        cardswitch: this.onNavPanelCardSwitch, 
        beforecardswitch: this.beforeNavPanelCardSwitch,
        scope: this
      },
      getItemTextTpl: function(node) {
        return '<tpl if="cls"><span class="{cls}">{text}</tpl><tpl if="!cls"><span<tpl if="leaf == true"> class="x-list-item-leaf"</tpl>>{text}</span></tpl>';
      },
      getTitleTextTpl: function(node) {
        return '<tpl if="short">{short}</tpl><tpl if="!short">{title}</tpl>';
      },
    });
    
    this.navigationPanel.on('back', this.onNavBack, this);

    if (!Ext.is.Phone) {
      this.navigationPanel.setWidth(300);
    }

    this.dockedItems = this.dockedItems || [];
    this.dockedItems.unshift(this.navigationBar);

    if (!Ext.is.Phone && Ext.Viewport.orientation == 'landscape') {
      this.dockedItems.unshift(this.navigationPanel);
    }
    else if (Ext.is.Phone) {
      this.items = this.items || [];
      this.items.unshift(this.navigationPanel);
    }

    this.addEvents('navigate');
       
    this.popup = new Ext.Panel({
      floating: true,
      centered: true,
      modal: true,
      width: 300,
      height: 400,
      styleHtmlContent: true,
      dockedItems: [{
          xtype: 'toolbar',
          title: 'Hinweis',
          items: [{
              xtype: 'spacer'
          },{
              text: 'Close',
              handler: function(){
                  this.popup.hide();
              },
              scope: this
          }]
      }]
    });

    Ext.ux.UniversalUI.superclass.initComponent.call(this);
  },
  
  toggleUiButtons: function() {
    var navPnl    = this.navigationPanel;
    
    if (Ext.is.Phone) {
      if (this.getActiveItem() === navPnl) {
        // on section structure
        this.articleFlipButton.hide() 
        
        var currList    = navPnl.getActiveItem(),
            currIdx     = navPnl.items.indexOf(currList),
            recordNode  = currList.recordNode;
        
        if (currIdx <= 0) {
          this.navigationBar.setTitle(this.title);
          this.backButton.hide();
          this.reloadButton.show();
        } else {
          this.reloadButton.hide();
          this.backButton.show();
        }
      } else {
        if (this.navigationItem) { 
          if (this.navigationItem.type == 'static') {
            // static panel
            this.reloadButton.hide();
            this.backButton.show();
          } else if (this.navigationItem.type == 'article') {
          // article panel
            this.articleFlipButton.show()
            this.reloadButton.hide();
            this.backButton.show();
          }
        }
      }      
    } else {
      // here we just handle buttons on article toolbar      
      if (this.navigationItem) {
        if (this.navigationItem.type == 'section') {
          // section is switched on left, no action for buttons
        } else if (this.navigationItem.type == 'article') {
          // article is shown, display article toolbar buttons
          this.articleFlipButton.show();
          this.noMobileArticleButton.show();
        } else if (this.navigationItem.type == 'static') {
          // static panel, hide article toolbar buttons
          this.articleFlipButton.hide();
          this.noMobileArticleButton.hide();
        }
      }
    }
  },

  onUiBack: function() {
    var navPnl = this.navigationPanel;

    // if we already in the nested list
    if (this.getActiveItem() === navPnl) {
      navPnl.onBackTap();
      // we were on a demo, slide back into
      // navigation
    } else {
      this.setActiveItem(navPnl, {
        type: 'slide',
        reverse: true
      });
    }
    
    this.fireEvent('navigate', this, {});
    this.toggleUiButtons();
  },

  onUiReload: function() {
    document.location.href = this.homeUrl;
    window.location.reload();
  },
  
  onArticleFlip: function() {   
    var active = this.getActiveItem(); 
    var card = active.getActiveItem();
        
    if (card.type == 'articlebody') {
      active.setActiveItem('articlemeta_' + card.number, 'flip');
    } else {
      active.setActiveItem('articlebody_' + card.number, 'flip');
    }
  },
  
  onArticleImage: function(number) {   
    var active = this.getActiveItem(); 
    var card = active.getActiveItem();
        
    if (card.type == 'articlebody') {
      if (Ext.is.Phone) {
        this.removeDocked(this.navigationBar, false);
      }
      active.setActiveItem('articleimages_' + card.number, 'pop');
      card = active.getActiveItem();
      card.setActiveItem(number);
    } else {
       if (Ext.is.Phone) {
        this.addDocked(this.navigationBar);
      }
      active.setActiveItem('articlebody_' + card.number, 'pop');
    }
  },
  
  onArticleSlideshow: function(slideshowNumber) {   
    var active = this.getActiveItem(); 
    var card = active.getActiveItem();
        
    if (card.type == 'articlebody') {
      if (Ext.is.Phone) {
        this.removeDocked(this.navigationBar, false);
      }
      active.setActiveItem('articleslideshow_' + card.number + '_' + slideshowNumber, 'pop');
      card = active.getActiveItem();
    } else {
       if (Ext.is.Phone) {
        this.addDocked(this.navigationBar);
      }
      active.setActiveItem('articlebody_' + card.number, 'pop');
    }
  },
  
  onNoMobileHome: function() {
    // set cookie to stay on non-mobile version
    createCookie('app_mode', 'off', 365, '/', '{{ $gimme->publication->site|strchr:'.' }}');
    if (document.location.href == this.homeUrl) {
      window.location.reload();
    } else {
      document.location.href = this.homeUrl 
    }
  },
  
  onNoMobileArticle: function() {
    // set cookie to stay on non-mobile version
    createCookie('app_mode', 'off', 365, '/', '{{ $gimme->publication->site|strchr:'.' }}');
        
    if (document.location.href == this.navigationItem.url) {
      window.location.reload();
    } else {
      document.location.href = this.navigationItem.url;
    }
  },

  onNavPanelItemTap: function(subList, subIdx, el, e) {
    var store  = subList.getStore(),
    record     = store.getAt(subIdx),
    recordNode = record.node,
    nestedList = this.navigationPanel,
    //title      = nestedList.renderTitleText(recordNode),
    card, type, name, number, title, short, url, link;

    if (record) {
      card          = record.get('card');
      type          = record.get('type');
      name          = record.get('name');
      number        = record.get('number');
      title         = record.get('title');
      short   = record.get('short');
      url           = record.get('url');
      link          = record.get('link');
    }

    this.navigationItem = {
      store:        store,
      record:       record,
      recordNode:   recordNode,
      nestedList:   nestedList,
      name:         name,
      number:       number,
      title:        title,
      short:  short,
      card:         card,
      type:         type,
      url:          url,
      link:         link
    };

    if (Ext.Viewport.orientation == 'portrait' && !Ext.is.Phone && !recordNode.childNodes.length) {
      this.navigationPanel.hide();
    }
    
    if (type == 'article' && !this.loadedItems['article_' + number]) {
      // loadArticle(), this function is asyncronos and calls showItem() after finished
      this.loadArticle_json(record);
    } else {
      // directly go to showItem()
      this.showItem();
    }
    
    if (type== 'section' || type == 'article') {
      /* ga: track pageview on section / article url */
      this.trackPageview(url);
    } else if (type == 'advertisement') {
      /* ga: track click on ads */
      this.trackEvent('click', link, url, name); 
    }
  },
  
  onNavPanelCardSwitch: function(container, newcard, oldcard, e) {
    if (!Ext.is.Phone) {
      if (e == 0) {
        this.navigationPanel.toolbar.setTitle(this.title);
      }
    }
    
    /* ga: track view of ads in section */
    var n = 0;
    var item = {};
    for (n=0; n<newcard.recordNode.childNodes.length; n++) {
      item = newcard.recordNode.childNodes[n].attributes.record.data;
      if (item.type == 'advertisement') {
        this.trackEvent('view', item.link, item.url, item.name); 
      } 
    }
    /* ga: track homepageview */
    if (e == 0) {
      this.trackPageview(); 
    }
  },
  
  beforeNavPanelCardSwitch: function(container, newcard, oldcard, e) {
    if (!Ext.is.Phone) {
      this.navigationPanel.toolbar.setTitle('');
      // here we handle buttons on nav panel
      if (e == 0) {
        this.reloadButton.show();
        this.noMobileHomeButton.show();
      } else {
        this.reloadButton.hide();
        this.noMobileHomeButton.hide();
      }
    }
  },

  initItem: function() {
    if (cardPanel.articlePanel.items.length) {
      this.loadedItems['article_' + cardPanel.articlePanel.items.items[0].number] = true;
      this.setActiveItem(cardPanel.articlePanel, 'slide');
      this.currentCard = cardPanel.articlePanel;
      this.navigationBar.setTitle(cardPanel.articlePanel.items.items[0].short ? cardPanel.articlePanel.items.items[0].short : cardPanel.articlePanel.items.items[0].title);
      
      this.navigationItem = {
        type:   'article',
        url:    cardPanel.articlePanel.items.items[0].url
      };
      this.toggleUiButtons();
    };
    
    /* ga: tracl home page */
    this.trackPageview();
    /* ga: track view of ads on start screen */
    var n = 0;
    var item = {};
    for (n=0; n<this.navigationItems.length; n++) {
      item = this.navigationItems[n];
      if (item.type == 'advertisement') {
        this.trackEvent('view', item.link, item.url, item.name); 
      } 
    }
  },

  showItem: function() {
    if (this.navigationItem.card) {
      this.setActiveItem(this.navigationItem.card, 'slide');
    }
    
    if (this.navigationItem.type == 'article' ) {
      this.loadedItems['article_' + this.navigationItem.number] = true;
      cardPanel.articlePanel.doLayout();
      cardPanel.articlePanel.setActiveItem('articlebody_' + this.navigationItem.number, Ext.is.Phone ? false : 'slide');
    } else if (this.navigationItem.type == 'advertisement') {
      window.open(this.navigationItem.link, '_blank');
    } else if (this.navigationItem.card) {
      this.currentCard = this.navigationItem.card;
    }

    this.toggleUiButtons();
    this.fireEvent('navigate', this, this.navigationItem.record);
    
    if (this.navigationItem.type !== 'section') {
      this.navigationBar.setTitle((Ext.is.Phone && this.navigationItem.short) ? this.navigationItem.short : this.navigationItem.title ? this.navigationItem.title : this.title);
    }
  },

  loadArticle_json: function(record) {
    var url = record.get('url');
    var params ={
      format: 'json',
      tpl: 130,
      cache_control: {{ $smarty.now }}
    }
    Ext.getBody().mask(this.maskText, 'demos-loading');

    Ext.util.JSONP.request({
      url: url,
      callbackKey: 'callback',
      params: params,
      scope: this,
      callback: function(response) {
        Ext.getBody().unmask();
        this.showItem()
      },
      failure: function(response, opts) {
        Ext.getBody().unmask();
        console.log('server-side failure with status code ' + response.status);
      },
    });
    //Ext.getBody().unmask();
  },

  onNavButtonTap : function() {
    this.navigationPanel.showBy(this.navigationButton, 'fade');
  },

  layoutOrientation : function(orientation, w, h) {
    if (!Ext.is.Phone) {
      if (orientation == 'portrait') {
        this.navigationPanel.hide(false);
        this.removeDocked(this.navigationPanel, false);
        if (this.navigationPanel.rendered) {
          this.navigationPanel.el.appendTo(document.body);
        }
        this.navigationPanel.setFloating(true);
        this.navigationPanel.setHeight(800);
        this.navigationButton.show(false);
      }
      else {
        this.navigationPanel.setFloating(false);
        this.navigationPanel.show(false);
        this.navigationButton.hide(false);
        this.insertDocked(0, this.navigationPanel);
      }
      this.navigationBar.doComponentLayout();
    }

    Ext.ux.UniversalUI.superclass.layoutOrientation.call(this, orientation, w, h);
  },
  
  trackEvent: function(p_action, p_link, p_url, p_name) {
    var category = p_action;      /* view or click */
    var action = p_link;          /* target url */
    var opt_label = p_url + "\n[" + p_name + "]";
    var opt_value = 1;            /* counter */
    var opt_noninteraction = p_action == 'click' ? false : true;
    
    console.log(['_trackEvent', category, action, opt_label, opt_value, opt_noninteraction]);
    _gaq.push(['_trackEvent', category, action, opt_label, opt_value, opt_noninteraction]); 
  },
  
  trackPageview: function(url) {
    console.log(['_trackPageview', url]);
    _gaq.push(['_trackPageview', url]);  
  },
});

app.Main = {
  init : function() {
    this.ui = new Ext.ux.UniversalUI({
      title: '<div class="logosmall"><span>TagesWoche</span></div>',
      backText: 'Liste',
      reloadText: '<img src="{{ url static_file="mobile/resources/img/reload.png" }}">',
      articleFlipText: '<img src="{{ url static_file="mobile/resources/img/flip.png" }}">',
      noMobileText: '<img src="{{ url static_file="mobile/resources/img/nomobile.png" }}">',
      maskText: 'lade Artikel&hellip;',
      useTitleAsBackText: false,
      navigationItems: app.Structure,
      homeUrl: '{{ url options="root_level" }}',
    });

    this.ui.initItem();
    
    if (!readCookie('app_switch_hint') && !Ext.is.Phone) {
      this.ui.popup.html  = 'Sie können durch Klick auf <img src="{{ url static_file="mobile/resources/img/nomobile.png" }}"> jederzeit zur Browservariante wechseln.';
      this.ui.popup.show();
      createCookie('app_switch_hint', 'passed', 365, '/', '{{ $gimme->publication->site|strchr:'.' }}')
    }
  }
};

Ext.setup({
  tabletIcon: '{{ url static_file="mobile/resources/img/tageswoche-72.png" }}',
  phoneIcon: '{{ url static_file="mobile/resources/img/tageswoche-57.png" }}',
  glossOnIcon: true,
  onReady: function() {
    app.Main.init();
  }
});

Ext.Ajax.on('requestcomplete', function(conn, resp){
  try {
    if (resp.responseText) {
      var jsonData = Ext.JSON.decode(resp.responseText);
      //jsonData is available here if you want to check for anything - eg log expired, not authorised etc that may be set by server
      }
    } catch(err) {
      alert ('Irregular JSON');
    }
});
Ext.Ajax.on('requestexception', function(conn, resp){
  alert ('An error has occurred contacting the server. ');
});

{{* from http://cubiq.org/add-to-home-screen/comment-page-1 *}}
if ('standalone' in navigator && !navigator.standalone 
    && (/iphone|ipod|ipad/gi).test(navigator.platform) 
    && (/Safari/i).test(navigator.appVersion)
    && !readCookie('app_hs_hint')) {
      
  var addToHomeConfig = {
    startDelay: 5000,
  	animationIn: 'bubble',
  	animationOut: 'drop',
  	lifespan:10000,
  	expire: 0,
  	message: 'de_de'
  };

	document.write('<link rel="stylesheet" href="{{ url static_file="mobile/resources/css/add2home.css" }}">');
	document.write('<script type="application/javascript" src="{{ url static_file="mobile/src/add2home.js" }}"><\/s' + 'cript>');
  createCookie('app_hs_hint', 'passed', 365, '/', '{{ $gimme->publication->site|strchr:'.' }}');
}
