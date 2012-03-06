{{extends file="layout.tpl"}}

{{ if $result }}
{{block content}}

<div id="app"></div>
<ul id="document-list"></ul>

<script type="text/template" id="search-result">
    <h1>Search results for '<%= result.escape('query') %>'</h1>
    <p>Total count: <%= result.escape('count') %>.</p>
</script>

<script type="text/template" id="doc">
    <% if (doc.get('type') === 'user') { %>
    <h3><%= doc.escape('user') %></h3>
    <p><%= doc.escape('bio') %></p>
    <% } else if (doc.get('type') === 'comment') { %>
    <h3><%= doc.escape('subject') %></h3>
    <p><%= doc.escape('message') %></p>
    <% } else { %>
    <h3><%= doc.escape('headline') %></h3>
    <p><%= doc.escape('lead') %></p>
    <% } %>
</script>

<script type="text/javascript" src="{{ $view->baseUrl('js/jquery/jquery-1.6.4.min.js') }}"></script>
<script type="text/javascript" src="{{ $view->baseUrl('js/underscore.js') }}"></script>
<script type="text/javascript" src="{{ $view->baseUrl('js/backbone.js') }}"></script>
<script type="text/javascript">
(function($) {
    var Result = Backbone.Model.extend({
        initialize: function() {
            this.set('query', this.get('responseHeader').params.q);
            this.set('count', this.get('response').numFound);
            this.set('docs', this.get('response').docs);
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

        initialize: function() {
            this.model.bind('change', this.render, this);
            this.template = _.template($('#search-result').html());
            this.render();
        },

        render: function() {
            $(this.el).html(this.template({result: this.model}));
            return this;
        }
    });

    $(function() { 
        var result = new Result({{ json_encode($result) }});
        var resultView = new ResultView({model: result});
        var documentsView = new DocumentListView({result: result});
    });
})(jQuery);
</script>
{{/block}}

{{ else }}
{{ block content }}
<h1>Search - use form to begin search</h1>

{{ $form }}
{{ /block }}
