/**
 * Item model
 */
var Item = Backbone.Model.extend({
    idAttribute: 'Id',

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
                return 'wrapup open';
                break;

            default:
                return 'quote tw';
        }
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
    },

    render: function() {
        var template = _.template($('#item-' + this.model.getClass().replace(' ', '-') + '-template').html());
        $(this.el).html(template({item: this.model})).addClass(this.model.getClass());
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
        var item = $(e.target).closest('li');
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

    initialize: function() {
        this.collection.bind('reset', this.render, this);
    },

    render: function() {
        var list = $(this.el).empty().addClass('liveblog-post-list');
        this.collection.each(function(item) {
            var view = new ItemView({model: item});
            list.append(view.render().el);
        });

        return this;
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
            $(collection.view.el).prepend('<a href="#" id="update-livedesk">New items: ' + newPostsCount + '</a>');
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
