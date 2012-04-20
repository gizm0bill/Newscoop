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
        'click button': 'search',
        'send': 'search',
        'click #did-you-mean > a': 'didYouMean'
    },

    webcode: /^[\+\@][a-z]{5,6}$/i,

    initialize: function() {
        this.collection.bind('reset', this.render, this);
        this.render();
    },

    render: function() {
        $(this.el).find('input').val(this.collection.query);
        if (this.collection.hasSuggestion()) {
            $(this.el).find('#did-you-mean').show().find('a').text(this.collection.getSuggestion());
        } else {
            $(this.el).find('#did-you-mean').hide();
        }
    },

    search: function(e) {
        e.preventDefault();

        this.collection.query = $(this.el).find('input').val();
        if (this.collection.query.match(this.webcode)) {
            window.location = window.location.origin + window.location.pathname.replace('search/', this.collection.query);
        }

        this.collection.type = null;
        this.collection.date = null;
        this.collection.start = null;
        router.navigate(this.collection.nav(), {trigger: true});
    },

    didYouMean: function(e) {
        e.preventDefault();
        $(this.el).find('input').val(this.collection.getSuggestion());
        this.search(e);
    }
});

/**
 * Document list view
 */
var DocumentListView = Backbone.View.extend({
    initialize: function() {
        this.collection.bind('reset', this.render, this);
        this.emptyTemplate = _.template(this.options.emptyTemplate.html());
    },

    render: function() {
        var list = $(this.el).empty();
        $('#search-pagination').show();
        this.collection.each(function(doc) {
            var view = new DocumentView({model: doc});
            list.append(view.render().el);
        });

        if (this.collection.count < 13) {
            $('#search-pagination').hide();
        }

        if (this.collection.count === 0) {
            $("<li />").html(this.emptyTemplate()).appendTo($(this.el));
        }

        return this;
    }
});

/**
 * Base filter view
 */
var FilterView = Backbone.View.extend({
    /**
     * Disable filter for given item
     *
     * @param {object} li
     * @return {void}
     */
    disableFilter: function(li) {
        li.find('a').hide();
        li.find('span').detach();
        $('<span />').text(li.find('a').text()).appendTo(li);
    },

    /**
     * Enable filter for given item
     *
     * @param {object} li
     * @return {void}
     */
    enableFilter: function(li) {
        li.find('span').detach();
        li.find('a').show();
    }
});

/**
 * Type filter view
 */
var TypeFilterView = FilterView.extend({
    events: {
        'click a': 'filter'
    },

    initialize: function() {
        this.collection.bind('reset', this.render, this);
        this.render();
    },

    render: function() {
        $(this.el).find('li').removeClass('main');
        if (!this.collection.type) {
            $(this.el).find('li').first().addClass('main');
        } else {
            $(this.el).find('a[href="#' + this.collection.type + '"]').closest('li').addClass('main');
        }

        var facets = this.collection.facets;
        var view = this;
        $(this.el).find('a').not(':first').each(function() {
            var type = $(this).attr('href').slice(1);
            if (!facets[type]) {
                view.disableFilter($(this).closest('li'));
            } else {
                view.enableFilter($(this).closest('li'));
            }
        });
    },

    filter: function(e) {
        e.preventDefault();
        this.collection.type = e.target.hash.slice(1);
        this.collection.start = null;
        router.navigate(this.collection.nav(), {trigger: true});
    }
});

/**
 * Date filter view
 */
var DateFilterView = FilterView.extend({
    events: {
        'click a': 'filter',
        'click input[type=submit]': 'filterRange'
    },

    initialize: function() {
        this.collection.bind('reset', this.render, this);
        this.render();
    },

    render: function() {
        $(this.el).find('li').removeClass('main');
        if (!this.collection.date) {
            $(this.el).find('li').first().addClass('main');
        } else {
            if (this.collection.date.indexOf(",") === -1) {
                $(this.el).find('a[href="#' + this.collection.date + '"]').closest('li').addClass('main');
            } else {
                var from = this.collection.date.split(",")[0];
                var to = this.collection.date.split(",")[1];

                if (from) {
                    $(this.el).find('#range_from').val(from).closest('li').addClass('main');
                }

                if (to) {
                    $(this.el).find('#range_to').val(to).closest('li').addClass('main');
                }
            }
        }
    },

    filter: function(e) {
        e.preventDefault();
        $(this.el).find('#range_from').val(null);
        $(this.el).find('#range_to').val(null);
        this.collection.date = e.target.hash.slice(1);
        this.collection.start = null;
        router.navigate(this.collection.nav(), {trigger: true});
    },

    filterRange: function(e) {
        e.preventDefault();
        var from = $(this.el).find('input.from').val() || '';
        var to = $(this.el).find('input.to').val() || '';
        this.collection.date = from || to ? [from, to].join(',') : null;
        this.collection.start = null;
        router.navigate(this.collection.nav(), {trigger: true});
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
        router.navigate(this.collection.nav(), {trigger: true});
    }
});

/**
 * Base ticker filter view
 */
var TickerFilterView = FilterView.extend({
    events: {
        'click a': 'filter'
    },

    initialize: function() {
        this.collection.bind('reset', this.render, this);
        this.render();
    },

    /**
     * Set main class to selected/first li
     *
     * @param {string} selected
     * @return {void}
     */
    setMain: function(selected) {
        $(this.el).find('li').removeClass('main');
        if (!selected) {
            $(this.el).find('li').first().addClass('main');
        } else {
            $(this.el).find('a[href="#' + selected + '"]').closest('li').addClass('main');
        }
    },

    /**
     * Set blacklisted options inactive
     *
     * @param {object} blacklist
     * @param {string} selected
     * @return {void}
     */
    setInactive: function(blacklist, selected) {
        var view = this;
        $(this.el).find('li').each(function() {
            var value = $(this).find('a').first().attr('href').slice(1);
            if (selected in blacklist && value in blacklist[selected]) {
                view.disableFilter($(this));
            } else {
                view.enableFilter($(this));
            }
        });
    },

    /**
     * Filter collection
     *
     * @param {object} e
     * @return {void}
     */
    filter: function(e) {
        e.preventDefault();
        var filter = $(e.target).attr('href').slice(1);
        this.collection[this.param] = filter ? filter : null;
        this.collection.start = null;
        router.navigate(this.collection.nav(), {trigger: true});
    }
});

/**
 * Source filter view
 */
var SourceFilterView = TickerFilterView.extend({
    blacklist: {
        basel: { twitter: true },
        schweiz: { twitter: true },
        international: { twitter: true },
        sport: { twitter: true },
        kultur: { twitter: true },
        leben: { twitter: true },
        blog: {
            twitter: true,
            agentur: true,
            link: true
        }
    },

    param: 'source',

    render: function() {
        this.setMain(this.collection.source);
        this.setInactive(this.blacklist, this.collection.section);
    }
});

/**
 * Section filter view
 */
var SectionFilterView = TickerFilterView.extend({
    blacklist: {
        twitter: {
            basel: true,
            schweiz: true,
            international: true,
            sport: true,
            kultur: true,
            leben: true,
            blog: true
        },
        agentur: {
            blog: true
        },
        link: {
            blog: true
        }
    },

    param: 'section',

    render: function() {
        this.setMain(this.collection.section);
        this.setInactive(this.blacklist, this.collection.source);
    }
});

/**
 * Sort view
 */
var SortView = Backbone.View.extend({
    events: {
        'click': 'sort'
    },

    initialize: function() {
        this.collection.bind('reset', this.render, this);
        this.render();
    },

    render: function() {
        if (this.collection.sortf) {
            $('<strong class="sort-dir">&darr;</strong>').appendTo($(this.el));
        } else {
            $(this.el).find('.sort-dir').detach();
        }
    },

    sort: function() {
        this.collection.sortf = this.collection.sortf ? null : 'latest';
        this.collection.start = null;
        router.navigate(this.collection.nav(), {trigger: true});
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
        window.documents.fetch();
    }
});
