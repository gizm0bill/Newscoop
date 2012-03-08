var SearchRouter = Backbone.Router.extend({
    routes: {
        "search/:q/:fq": "search",
        "search/:q": "search"
    },

    search: function(q, fq) {
    }
});
