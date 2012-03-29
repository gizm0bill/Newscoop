/**
 * Document model
 */
var Document = Backbone.Model.extend({
    day: 3600 * 24,
    month: 3600 * 24 * 30,
    year: 3600 * 24 * 365,

    /**
     * Get relative date
     */
    relDate: function(property) {
        var published = new Date(this.get(property));
        var now = new Date();
        var diff = Math.ceil(Math.abs(now.getTime() - published.getTime()) / 1000);

        if (diff < 60) {
            return 'vor ' + diff + ' Sek.';
        } else if (diff < 3600) {
            return 'vor ' + (diff / 60).toFixed() + ' Min.';
        } else if (diff < this.day) {
            return 'vor ' + (diff / 3600).toFixed() + ' Std.';
        } else if (diff < this.month) {
            return 'vor ' + (diff / this.day).toFixed() + ' Tag';
        } else if (diff < this.year) {
            return 'vor ' + (diff / this.month).toFixed() + ' Monat';
        } else {
            return 'vor ' + (diff / this.year).toFixed() + ' Jahr';
        }
    }
});

/**
 * Document collection
 */
var DocumentCollection = Backbone.Collection.extend({
    model: Document,

    url: function() {
        var params = {q: this.query, type: this.type, date: this.date, page: this.page, format: 'json'};
        return '?' + jQuery.param(params);
    },

    nav: function() {
        var params = {q: this.query};

        if (this.type) {
            params.type = this.type;
        }

        if (this.date) {
            params.date = this.date;
        }

        if (this.page) {
            params.page = this.page;
        }

        return '?' + jQuery.param(params);
    },

    parse: function(response) {
        this.query = response.responseHeader.params.q;
        this.numFound = response.response.numFound;
        return response.response.docs;
    }
});


/**
 * Document view
 */
var DocumentView = Backbone.View.extend({
    tagName: 'li',

    initialize: function() {
        this.template = _.template($('#document-' + this.model.get('type') + '-template').html());
    },

    render: function() {
        $(this.el).html(this.template({doc: this.model})).addClass(this.model.get('type'));
        return this;
    }
});

/**
 * Search form view
 */
var SearchFormView = Backbone.View.extend({
    events: {
        'blur input': 'search',
        'click button': 'search'
    },

    initialize: function() {
        this.collection.bind('reset', this.render, this);
    },

    render: function() {
        $(this.el).find('input').val(this.collection.query);
    },

    search: function() {
        this.collection.query = $(this.el).find('input').val();
        this.collection.type = '';
        this.collection.date = '';
        router.navigate(this.collection.nav());
        this.collection.fetch();
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

/**
 * Type filter view
 */
var TypeFilterView = Backbone.View.extend({
    events: {
        'click a': 'filter'
    },

    filter: function(e) {
        e.preventDefault();
        this.collection.type = e.target.hash.slice(1);
        router.navigate(this.collection.nav());
        this.collection.fetch();
    }
});

/**
 * Date filter view
 */
DateFilterView = Backbone.View.extend({
    events: {
        'click a': 'filter'
    },

    filter: function(e) {
        e.preventDefault();
        this.collection.date = e.target.hash.slice(1);
        router.navigate(this.collection.nav());
        this.collection.fetch();
    }
});

var SearchRouter = Backbone.Router.extend({
    routes: {
        "?*params": "search"
    },

    search: function(params) {
    }
});
