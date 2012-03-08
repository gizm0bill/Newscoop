var SearchRouter = Backbone.Router.extend({
    routes: {
        "search/:q*filters": "search"
    },

    search: function(q, filters) {
    }
});
