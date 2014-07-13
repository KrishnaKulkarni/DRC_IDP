IdentityMatches.Views.IomIdentitiesSearch = Backbone.View.extend({
  template: JST["iom_identities/search"],
  tagName: "div",

  events: {
    "submit form" : "searchMatches"
  },

  initialize: function(options) {

  },

  searchMatches: function(event) {
   event.preventDefault();
   console.log("Clicked Search button!");
    var params = $(event.currentTarget).serializeJSON();
    console.log(params);
  },

  render: function() {
    console.log("Search#render called");
    var renderedContent = this.template({});
    this.$el.html(renderedContent);
    var that = this;

    $.get( "search_fields", function( data ) {
      that.$el.children('form').append(data);
    });

    return this;
  }
});