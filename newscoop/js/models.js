/**
 * Document model
 */
var Document = Backbone.Model.extend({
});

/**
 * Document collection
 */
var DocumentCollection = Backbone.Collection.extend({
    model: Document,

    url: function() {
        return "?format=json&q=" + this.q + "&fq=" + this.fq;
    },

    parse: function(response) {
        this.q = response.responseHeader.params.q;
        this.numFound = response.response.numFound;
        return response.response.docs;
    },

    parseReset: function(response) {
        this.reset(this.parse(response));
    }
});
