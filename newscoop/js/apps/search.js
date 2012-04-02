/**
 * Document model
 */
var Document = Backbone.Model.extend({
    day: 3600 * 24,
    month: 3600 * 24 * 30,
    year: 3600 * 24 * 365,

    types: {
        'news': 'article',
        'newswire': 'article',
        'dossier': 'article',
        'user': 'user',
        'tweet': 'twitter',
        'event': 'event',
        'comment': 'omni',
        'link': 'link'
    },

    /**
     * Get relative date
     *
     * @param {string} property
     * @return {string}
     */
    relDate: function(property) {
        var date = new Date(this.get(property));
        var now = new Date();
        var diff = Math.ceil(Math.abs(now.getTime() - date.getTime()) / 1000);

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
    },

    /**
     * Get template type
     *
     * @return {string}
     */
    getTemplateType: function() {
        if (!this.get('type') in this.types) {
            console.log(this.get('type'));
        } else {
            return this.types[this.get('type')];
        }
    }
});

/**
 * Document collection
 */
var DocumentCollection = Backbone.Collection.extend({
    model: Document,

    buildParams: function() {
        var params = {q: this.query};

        if (this.type) {
            params.type = this.type;
        }

        if (this.date) {
            params.date = this.date;
        }

        if (this.start) {
            params.start = this.start;
        }

        return params;
    },

    url: function() {
        var params = this.buildParams();
        params.format = 'json';
        return '?' + jQuery.param(params);
    },

    nav: function() {
        var params = this.buildParams();
        return '?' + jQuery.param(params);
    },

    parse: function(response) {
        this.response = response;
        this.query = response.responseHeader.params.q;
        this.count = parseInt(response.response.numFound);
        this.start = parseInt(response.response.start);
        this.rows = parseInt(response.responseHeader.params.rows);
        this.type = response.responseHeader.params.type;
        this.date = response.responseHeader.params.date;
        return response.response.docs;
    }
});


/**
 * Document view
 */
var DocumentView = Backbone.View.extend({
    tagName: 'li',

    initialize: function() {
        this.template = _.template($('#document-' + this.model.getTemplateType() + '-template').html());
    },

    render: function() {
        $(this.el).html(this.template({doc: this.model})).addClass(this.model.getTemplateType());
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
        this.collection.type = null;
        this.collection.date = null;
        this.collection.start = null;
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
        this.collection.start = null;
        router.navigate(this.collection.nav());
        this.collection.fetch();
    }
});

/**
 * Date filter view
 */
var DateFilterView = Backbone.View.extend({
    events: {
        'click a': 'filter',
        'click input[type=submit]': 'filterRange'
    },

    filter: function(e) {
        e.preventDefault();
        this.collection.date = e.target.hash.slice(1);
        this.collection.start = null;
        router.navigate(this.collection.nav());
        this.collection.fetch();
    },

    filterRange: function(e) {
        e.preventDefault();

        var from = $(this.el).find('input.from').val() || '';
        var to = $(this.el).find('input.to').val() || '';

        if (from === '' && to === '') {
            alert("Provide at least 1 date");
            return;
        }

        this.collection.date = [from, to].join(',');
        this.collection.start = null;
        router.navigate(this.collection.nav());
        this.collection.fetch();
    }
});

/**
 * Pagination view
 */
var PaginationView = Backbone.View.extend({
    events: {
        'click .prev a': 'goTo',
        'click .next a': 'goTo'
    },

    initialize: function() {
        this.collection.bind('reset', this.render, this);
    },

    render: function() {
        $(this.el).find('.start').text(Math.floor(this.collection.start / this.collection.rows) + 1);
        $(this.el).find('.end').text(Math.ceil(this.collection.count / this.collection.rows));

        if (this.collection.start > 0) { // active prev
        } else {
        }

        if (this.collection.count > this.collection.start + this.collection.rows) { // active next
        } else {
        }
    },

    goTo: function(e) {
        e.preventDefault();

        var lastStart = (Math.ceil(this.collection.count / this.collection.rows) - 1) * this.collection.rows;
        if ($(e.target).closest('li').hasClass('prev')) {
            var start = Math.max(0, this.collection.start - this.collection.rows);
        } else {
            var start = Math.min(lastStart, this.collection.start + this.collection.rows);
        }

        if (start == this.collection.start) {
            return;
        }

        this.collection.start = start;
        router.navigate(this.collection.nav());
        this.collection.fetch();
    }
});

/**
 * Router
 */
var SearchRouter = Backbone.Router.extend({
    routes: {
        "?*params": "search"
    },

    search: function(params) {
    }
});
