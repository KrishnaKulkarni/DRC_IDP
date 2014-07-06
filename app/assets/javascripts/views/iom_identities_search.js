IdentityMatches.Views.IomIdentitiesSearch = Backbone.View.extend({
  template: JST["iom_identities/search"],
  
  events: {
    "click button#search-for-matches" : "searchMatches"
  },
  
  initialize: function(options) {
    
  },
  
  searchMatches: function() {
   console.log("Clicked Search button!");
  },
  
  render: function() {
    var that = this;
    
    $.get( "search_form", function( data ) {
      that.$el.html(data);
    });
    return this;
  }
});