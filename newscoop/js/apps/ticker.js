/**
 * Ticker view
 */
var TickerView = Backbone.View.extend({
    tagName: 'section',

    initialize: function() {
        this.template = _.template($('#ticker-' + this.model.getTemplateType() + '-template').html());
    },

    render: function() {
        $(this.el).html(this.template({doc: this.model})).addClass(this.model.getTemplateType());
        return this;
    }
});

/**
 * Ticker list view
 */
var TickerListView = Backbone.View.extend({
    initialize: function() {
        this.collection.bind('reset', this.render, this);
    },

    render: function() {
        var list = $(this.el);
        list.find('section').detach();

        this.collection.each(function(doc) {
            var view = new TickerView({model: doc});
            list.find('footer').before(view.render().el);
        });

        return this;
    }
});
