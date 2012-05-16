/**
 * Item model
 */
var Item = Backbone.Model.extend({
    idAttribute: 'Id',

    getPublished: function() {
        var date = new Date(this.get('PublishedOn'));
        return date.getDate() + '/' + (date.getMonth() + 1) + ' ' + date.getHours() + ':' + date.getMinutes();
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
            'lastmod': collection.getLastModified()
        }, function(data, textStatus, jqXHR) {
            if (data) {
                for (var i = data.length - 1; i >= 0; i--) {
                    var model = collection.get(data[i].Id);
                    if (model) {
                        model.set(data[i]);
                    } else {
                        collection.add(data[i]);
                    }
                }
            }

            collection.view.update(collection);
        });
    },

    /**
     * Get last modified date for sync call
     *
     * last modified is max of publishedOn + updatedOn of all the items
     *
     * @return {string}
     */
    getLastModified: function() {
        var values = this.map(function(item) {
            var date = new Date(item.has('UpdatedOn') ? item.get('UpdatedOn') : item.get('PublishedOn'));
            return date.getTime();
        });

        var maxTime = _.max(values);
        var maxDate = new Date();
        maxDate.setTime(maxTime);
        return maxDate.toUTCString();
    },

    /**
     * Return value for collection ordering
     *
     * @return {int}
     */
    comparator: function(item) {
        var date = new Date(item.get('PublishedOn'));
        return - date.getTime();
    }
});

/**
 * Item view
 */
var ItemView = Backbone.View.extend({
    tagName: 'li',
    template: _.template($('#item-template').html()),

    initialize: function() {
        this.model.bind('change', this.update, this);
    },

    render: function() {
        $(this.el).html(this.template({item: this.model}));
        return this;
    },

    update: function() {
        this.render();
        $(this.el).addClass('updated');
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
        var list = $(this.el).empty();
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

        $('<p id="last-updated"></p>').text('updated on ' + (new Date()).toLocaleTimeString()).prependTo($(this.el));
        return this;
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
