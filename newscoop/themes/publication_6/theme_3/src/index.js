Ext.ns('app', 'cardPanel', 'Ext.ux');

Ext.ux.UniversalUI = Ext.extend(Ext.Panel, {
    fullscreen: true,
    layout: 'card',
    items: [{
        cls: 'launchscreen',
        html: '<h1>Basler Wochenzeitung</h1>'
    }],
    backText: 'Liste',
    useTitleAsBackText: true,
    navigationItem: {},
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
        var btns = [this.navigationButton];
        if (Ext.is.Phone) {
            btns.unshift(this.backButton);
        }

        this.navigationBar = new Ext.Toolbar({
            ui: 'dark',
            dock: 'top',
            title: this.title,
            items: btns.concat(this.buttons || [])
        });

        this.navigationPanel = new Ext.NestedList({
            store: app.StructureStore,
            useToolbar: Ext.is.Phone ? false : true,
            updateTitleText:  true,
            dock: 'left',
            hidden: !Ext.is.Phone && Ext.Viewport.orientation == 'portrait',
            toolbar: Ext.is.Phone ? this.navigationBar : null,
            listeners: {
                itemtap: this.onNavPanelItemTap,
                scope: this
            }
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


        Ext.ux.UniversalUI.superclass.initComponent.call(this);
    },

    toggleUiBackButton: function() {
        var navPnl = this.navigationPanel;

        if (Ext.is.Phone) {
            if (this.getActiveItem() === navPnl) {

                var currList      = navPnl.getActiveItem(),
                    currIdx       = navPnl.items.indexOf(currList),
                    recordNode    = currList.recordNode,
                    title         = navPnl.renderTitleText(recordNode),
                    parentNode    = recordNode ? recordNode.parentNode : null,
                    backTxt       = (parentNode && !parentNode.isRoot) ? navPnl.renderTitleText(parentNode) : this.title || '',
                    activeItem;


                if (currIdx <= 0) {
                    this.navigationBar.setTitle(this.title || '');
                    this.backButton.hide();
                } else {
                    this.navigationBar.setTitle(title);
                    if (this.useTitleAsBackText) {
                        this.backButton.setText(backTxt);
                    }

                    this.backButton.show();
                }
            // on a demo
            } else {
                activeItem = navPnl.getActiveItem();
                recordNode = activeItem.recordNode;
                backTxt    = (recordNode && !recordNode.isRoot) ? navPnl.renderTitleText(recordNode) : this.title || '';

                if (this.useTitleAsBackText) {
                    this.backButton.setText(backTxt);
                }
                this.backButton.show();
            }
            this.navigationBar.doLayout();
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
        this.toggleUiBackButton();
        this.fireEvent('navigate', this, {});
    },

    onNavPanelItemTap: function(subList, subIdx, el, e) {
        var store      = subList.getStore(),
            record     = store.getAt(subIdx),
            recordNode = record.node,
            nestedList = this.navigationPanel,
            //title      = nestedList.renderTitleText(recordNode),
            card, preventHide, anim, type;

        if (record) {
            card        = record.get('card');
            anim        = record.get('cardSwitchAnimation');
            preventHide = record.get('preventHide');
            type        = record.get('type');
            title       = record.get('title');
        }

        this.navigationItem = {
          store: store,
          record: record,
          recordNode: recordNode,
          nestedList: nestedList,
          title:title,
          card: card,
          preventHide: preventHide, 
          anim: anim, 
          type: type
        };
        
        if (Ext.Viewport.orientation == 'portrait' && !Ext.is.Phone && !recordNode.childNodes.length && !preventHide) {
            this.navigationPanel.hide();
        }

        if (type == 'article') {
          // loadArticle(), this function is asyncronos and calls showItem() after finished
          this.loadArticle(record);
        } else {
          // directly go to showItem()
          this.showItem();
        }
    },
    
    showItem: function() {
      if (this.navigationItem.card) {
            this.setActiveItem(this.navigationItem.card, this.navigationItem.anim || 'slide');
            this.currentCard = this.navigationItem.card;
        }

        if (this.navigationItem.type == 'article') {
            this.navigationBar.setTitle(this.navigationItem.title);
        }

        this.toggleUiBackButton();
        this.fireEvent('navigate', this, this.navigationItem.record);
    },
    
    loadArticle: function(record) {
      var source = record.get('source');
      var url = source.split('?');
      var tpl = url[1].split('=');
      Ext.util.JSONP.request({
        url: url[0],
        callbackKey: 'callback',
        params: {format: 'json', tpl: tpl[1]},
        scope: this,
        callback: function(response) {this.showItem()},
        failure: function(response, opts) {
            console.log('server-side failure with status code ' + response.status);
        },
      });
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
                this.navigationPanel.setHeight(400);
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
    
});

app.Main = {
    init : function() {
        this.ui = new Ext.ux.UniversalUI({
            title: Ext.is.Phone ? 'TagesWoche' : 'TagesWoche',
            useTitleAsBackText: false,
            navigationItems: app.Structure,
            /*
            buttons: [{xtype: 'spacer'}, this.sourceButton],
            listeners: {
                navigate : this.onNavigate,
                scope: this
            }
            */
        });
    },
};

Ext.setup({
    tabletStartupScreen: 'resources/img/tablet_startup.png',
    phoneStartupScreen: 'resources/img/phone_startup.png',
    icon: 'resources/img/icon.png',
    glossOnIcon: false,

    onReady: function() {
        app.Main.init();
    }
});

