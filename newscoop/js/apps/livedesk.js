/**
 * Item model
 */
var Item = Backbone.Model.extend({
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

    parse: function(response) {
        if (!response) { // workaround for 304 responses
            return this.toJSON();
        }

        if ('BlogPostList' in response) {
            return response.BlogPostList;
        }

        return response;
    }
});

/**
 * Item view
 */
var ItemView = Backbone.View.extend({
    tagName: 'li',
    template: _.template($('#item-template').html()),

    render: function() {
        $(this.el).html(this.template({item: this.model}));
        return this;
    }
});

/**
 * List view
 */
var ListView = Backbone.View.extend({
    tagName: 'ul',

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
    wait: 21000, // ms
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
        this.collection.reset(this.collection.parse(data));
    },

    /**
     * Update view after fetching new items
     *
     * @param {object} collection
     * @param {object} response
     */
    update: function(collection, response) {
        $('#update-livedesk').detach();
        var newPostsCount = collection.length - collection.view.length;
        if (newPostsCount > 0) {
            $(collection.view.el).prepend('<a href="#" id="update-livedesk">There are ' + newPostsCount + ' new items.</a>');
        } else {
            console.log(collection.length);
        }

        $('#last-updated').fadeOut(function() {
            $(this).text('updated on ' + (new Date()).toLocaleTimeString()).fadeIn();
        });

        collection.view.timer = _.delay(collection.view.fetch, collection.view.wait, collection.view);
        collection.view.updated = (new Date()).toUTCString();
    },

    /**
     * Fetch new items - called via _.delay
     *
     * @param {object} view
     */
    fetch: function(view) {
        $('#last-updated').text('updating...');
        view.collection.fetch({silent: true, success: view.update, headers: {
            'If-Modified-Since': view.updated
        }});
    }
});
