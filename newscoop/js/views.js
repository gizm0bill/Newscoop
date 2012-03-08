/**
 * Document view
 */
var DocumentView = Backbone.View.extend({
    tagName: 'li',
    template: _.template($('#doc').html()),

    render: function() {
        $(this.el).html(this.template({doc: this.model})).addClass(this.model.get('type'));
        return this;
    }
});

/**
 * Result view
 */
var ResultView = Backbone.View.extend({
    el: $('#app'),

    events: {
        'change #search-field': 'refresh',
        'click #type-filter a': 'filter'
    },

    initialize: function() {
        this.collection.bind('reset', this.render, this);
        this.router = this.options.router;
        this.documentList = new DocumentListView({collection: this.collection, el: $('#results')});
    },

    render: function() {
        $(this.el).find('#search-query').text(this.collection.q);
        $(this.el).find('#search-count').text(this.collection.numFound);
        $(this.el).find('#search-field').attr('placeholder', this.collection.q);
        return this;
    },

    refresh: function() {
        this.collection.q = this.getQuery();
        this.collection.fq = '';
        this.options.router.navigate("search/" + this.collection.q);
        this.collection.fetch();
    },

    filter: function(e) {
        e.preventDefault();
        this.collection.fq = e.target.hash.slice(1);
        this.options.router.navigate("search/" + this.collection.q + "/" + this.collection.fq);
        this.collection.fetch();
    },

    getQuery: function() {
        return $(this.el).find('#search-field').val();
    }
});

/**
 * Document list view
 */
var DocumentListView = Backbone.View.extend({
    initialize: function() {
        this.collection.bind('reset', this.render, this);
    },

    render: function() {
        var list = $(this.el).empty();
        this.collection.each(function(doc) {
            var view = new DocumentView({model: doc});
            list.append(view.render().el);
        });

        return this;
    }
});
