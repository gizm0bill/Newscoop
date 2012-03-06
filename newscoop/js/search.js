(function($) {
    window.Result = Backbone.Model.extend({
        url: function() {
            return "?format=json";
        },

        initialize: function() {
            this.set('query', this.get('responseHeader').params.q);
            this.set('fq', this.get('responseHeader').params.fq);
            this.set('count', this.get('response').numFound);
            this.set('docs', this.get('response').docs);
            this.set('facets_type', this.parseFacets(this.get('facet_counts').facet_fields.type));
        },

        parse: function(response) {
            return {
                'query': response.responseHeader.params.q,
                'fq': response.responseHeader.params.fq,
                'count': response.response.numFound,
                'docs': response.response.docs,
                'facets_type': this.parseFacets(response.facet_counts.facet_fields.type)
            };
        },

        parseFacets: function(facetsRaw) {
            facets = {};
            for (var i = 1; i < facetsRaw.length; i +=2) {
                facets[facetsRaw[i - 1]] = facetsRaw[i];
            }

            return facets;
        }
    });

    var Document = Backbone.Model.extend();
    var DocumentCollection = Backbone.Collection.extend({model: Document});

    /**
     * Single document view
     */
    var DocumentView = Backbone.View.extend({
        tagName: 'li',

        initialize: function() {
            this.model.bind('change', this.render, this);
            this.template = _.template($('#doc').html());
            this.render();
        },

        render: function() {
            $(this.el).html(this.template({doc: this.model})).addClass(this.model.get('type'));
            return this;
        }
    });

    /**
     * Document list view
     */
    var DocumentListView = Backbone.View.extend({
        initialize: function() {
            this.collection = new DocumentCollection;
            this.collection.bind('reset', this.render, this);
            this.options.result.bind('change', this.reset, this);
            this.reset();
        },

        reset: function() {
            this.collection.reset(this.options.result.get('docs'));
        },

        render: function() {
            var list = $('#document-list').first();
            list.empty();
            this.collection.each(function(doc) {
                var view = new DocumentView({model: doc});
                list.append(view.render().el);
            });
            return this;
        }
    });

    var ResultView = Backbone.View.extend({
        el: $('#app'),

        events: {
            'change #search-field': 'refresh',
            'click #facets a': 'filter'
        },

        initialize: function() {
            this.model.bind('change', this.render, this);
            this.template = _.template($('#search-result').html());
            this.render();
        },

        render: function() {
            $(this.el).html(this.template({result: this.model}));
            return this;
        },

        refresh: function() {
            this.options.router.navigate("search/" + this.getQuery(), {trigger: true});
        },

        filter: function(e) {
            e.preventDefault();
            var fq = "type:" + e.target.hash.slice(1);
            this.options.router.navigate("search/" + this.getQuery() + "/" + fq, {trigger: true});
        },

        getQuery: function() {
            return $(this.el).find('#search-field').val();
        }
    });

    window.SearchRouter = Backbone.Router.extend({
        routes: {
            "search/:q/:fq": "search",
            "search/:q": "search"
        },

        initialize: function(result) {
            this.result = result;
            var resultView = new ResultView({model: this.result, router: this});
            var documentsView = new DocumentListView({result: this.result});
        },

        search: function(q, fq) {
            if (fq === undefined) {
                fq = '';
            }

            if (this.result.get('query') !== q || this.result.get('fq') !== fq) {
                this.result.set('query', q);
                this.result.set('fq', fq);
                this.result.fetch();
            }
        }
    });
})(jQuery);
