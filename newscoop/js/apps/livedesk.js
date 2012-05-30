/**
 * Item model
 */
var Item = Backbone.Model.extend({
    idAttribute: 'Id',
    services: {
        'flickr': true,
        'google': true,
        'twitter': true,
        'facebook': true,
        'youtube': true
    },

    /**
     * Get published time
     *
     * @return {string}
     */
    getPublished: function() {
        var date = new Date(this.get('PublishedOn'));
        return date.toDateString() + ' ' + date.toLocaleTimeString();
    },

    /**
     * Get css class based on type
     *
     * @return {string}
     */
    getClass: function() {
        switch (this.get('Type').Key) {
            case 'wrapup':
                return 'wrapup';
                break;

            case 'quote':
                return 'quotation';
                break;

            case 'advertisement':
                return 'advertisement';
                break;

            default:
                if (this.isService()) {
                    return 'service';
                }

                return 'tw';
        }
    },

    /**
     * Test if post is from service
     *
     * @return {bool}
     */
    isService: function() {
        return this.get('AuthorName') in this.services;
    },

    /**
     * Test if post is quote
     *
     * @return {bool}
     */
    isQuote: function() {
        return this.getClass() == 'quotation';
    }
});

/**
 * Item collection
 */
var ItemCollection = Backbone.Collection.extend({
    model: Item,

    /**
     * Update collection - add new items and update rest
     */
    sync: function(method, collection, options) {
        $.getJSON(collection.url, {
            'cid': collection.getMaxCid()
        }, function(data, textStatus, jqXHR) {
            if (data) {
                for (var i = data.length - 1; i >= 0; i--) {
                    var model = collection.get(data[i].Id);
                    if (model) { // update existing
                        model.set(data[i]);

                        // remove deleted posts
                        if (model.has('DeletedOn') && model.get('DeletedOn').length) {
                            collection.remove(model);
                        }
                    } else { // add new
                        collection.add(data[i]);
                    }
                }
            }

            collection.view.update(collection);
        });
    },

    /**
     * Get last change id
     *
     * @return {int}
     */
    getMaxCid: function() {
        return _.max(this.pluck('CId'));
    },

    /**
     * Return value for collection ordering
     *
     * @return {int}
     */
    comparator: function(item) {
        var date = new Date(item.get('PublishedOn'));
        return 1 - date.getTime(); // desc
    }
});

/**
 * Item view
 */
var ItemView = Backbone.View.extend({
    tagName: 'li',

    events: {
        'click .big-toggle': 'toggleWrap'
    },

    initialize: function() {
        this.model.bind('change', this.update, this);
        this.model.bind('remove', this.remove, this);
    },

    render: function() {
        try {
            var template = _.template($('#item-' + this.model.getClass() + '-template').html());
        } catch (err) {
            console.log("No template for " + this.model.getClass() + " type.");
            return this;
        }

        $(this.el).html(template({item: this.model})).addClass(this.model.getClass());

        if (this.model.getClass() == 'wrapup') {
            $(this.el).addClass('open');
        }

        if (this.model.has('AuthorPerson') && 'imageLink' in this.model.get('AuthorPerson')) {
            $(this.el).addClass('quote');
        }

        if (this.model.isService()) {
            $(this.el).addClass(this.model.get('AuthorName')).removeClass('quote');
            if (this.model.get('AuthorName') == 'flickr') {
                $(this.el).find('img').attr('src', $(this.el).find('a').attr('href'));
            }
        }

        if (this.model.isQuote()) {
            $(this.el).removeClass('quote');
        }

        return this;
    },

    update: function() {
        var view = this;
        $(this.el).fadeTo(500, '0.1', function() {
            $(view.render().el).fadeTo(500, '1');
        });
    },

    toggleWrap: function(e) {
        e.preventDefault();
        this._toggleWrap($(e.target).closest('li').first());
    },

    _toggleWrap: function(item) {
        if (item.hasClass('open')) {
            item.removeClass('open').addClass('closed');
            item.nextUntil('.wrapup').hide();
        } else {
            item.removeClass('closed').addClass('open');
            item.nextUntil('.wrapup').show();
        }
    }
});

/**
 * List view
 */
var ListView = Backbone.View.extend({
    tagName: 'ol',

    render: function() {
        var list = $(this.el).empty().addClass('liveblog-post-list');
        var views = [];
        this.collection.each(function(item) {
            var view = new ItemView({model: item});
            list.append(view.render().el);
            views.push(view);
        });

        this.closeAllButFirstWrapup(views);

        return this;
    },

    closeAllButFirstWrapup: function(views) {
        var first = true;
        for (var i = 0; i < views.length; i++) {
            if ($(views[i].el).hasClass('wrapup') && !first) {
                views[i]._toggleWrap($(views[i].el));
            } else if ($(views[i].el).hasClass('wrapup')) {
                first = false;
            }
        }
    }
});

/**
 * Livedesk view
 */
var LivedeskView = Backbone.View.extend({
    wait: 13000, // ms
    length: 0,

    events: {
        'click #update-livedesk': 'render'
    },

    initialize: function() {
        this.collection = new ItemCollection();
        this.list = new  ListView({collection: this.collection});
        this.collection.bind('reset', this.render, this);
        this.collection.view = this;
        this.timer = _.delay(this.fetch, this.wait, this);
        this.updated = (new Date()).toUTCString();
    },

    /**
     * Render the livedesk
     */
    render: function(e) {
        if (this.timer) {
            clearTimeout(this.timer);
        }

        if ('preventDefault' in e) {
            e.preventDefault();
        }

        this.length = this.collection.length;
        $(this.el).html(this.list.render().el);
        this.timer = _.delay(this.fetch, this.wait, this);

        $('<p id="last-updated" class="update-time"></p>').text('updated on ' + (new Date()).toLocaleTimeString()).prependTo($(this.el)); return this;
    },

    /**
     * Reset collection with initial data
     *
     * @param {object} data
     */
    reset: function(data) {
        this.collection.reset(data);
    },

    /**
     * Update view after fetching new items
     *
     * called by collection.sync
     *
     * @param {object} collection
     */
    update: function(collection) {
        $('#update-livedesk').detach();

        var newPostsCount = collection.length - collection.view.length;
        if (newPostsCount > 0) {
            $(collection.view.el).prepend('<a href="#" id="update-livedesk" class="grey-button full-button" style="margin-bottom: 16px">New items: ' + newPostsCount + '</a>');
        }

        $('#last-updated').fadeOut(function() {
            $(this).text('updated on ' + (new Date()).toLocaleTimeString()).fadeIn();
        });
    },

    /**
     * Fetch new items - called via _.delay
     *
     * @param {object} view
     */
    fetch: function(view) {
        $('#last-updated').text('updating...');
        view.collection.fetch();
        view.timer = _.delay(view.fetch, view.wait, view);
        view.updated = (new Date()).toUTCString();
    }
});
