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
        return response.BlogPostList;
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
    initialize: function() {
        this.collection = new ItemCollection();
        this.list = new  ListView({collection: this.collection});
        this.collection.bind('reset', this.render, this);
    },

    render: function() {
        $(this.el).html(this.list.render().el);
        return this;
    },

    reset: function(data) {
        this.collection.reset(this.collection.parse(data));
    }
});
