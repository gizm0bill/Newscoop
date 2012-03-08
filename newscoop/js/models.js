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
        var params = {q: this.query, type: this.type, date: this.date, page: this.page, format: 'json'};
        return '?' + jQuery.param(params);
    },

    nav: function() {
        var params = {q: this.query};

        if (this.type !== '') {
            params.type = this.type;
        }

        if (this.date !== '') {
            params.date = this.date;
        }

        if (this.page !== 0) {
            params.page = this.page;
        }

        return '?' + jQuery.param(params);
    },

    parse: function(response) {
        this.query = response.responseHeader.params.q;
        this.numFound = response.response.numFound;
        return response.response.docs;
    },

    parseReset: function(response) {
        this.type = '';
        this.date = '';
        this.page = 0;
        this.reset(this.parse(response));
    }
});
