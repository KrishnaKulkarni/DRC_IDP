IdentityMatches.Views.IomIdentitiesSearch = Backbone.View.extend({
  template: JST["iom_identities/search"],
  tagName: "div",

  events: {
    "click input.search-button" : "searchMatches"
  },

  searchMatches: function(event) {
   event.preventDefault();
   var params = $(event.currentTarget);
   $.ajax({
     type: "POST",
     url: "match_results",
     data: $( "#search-matches-form" ).serialize(),
     success: function(resp){
      console.log("Response ::", resp);
      IdentityMatches.Collections.searchResults.set(resp);

      var indexView = new IdentityMatches.Views.IomIdentitiesIndex({
        collection: IdentityMatches.Collections.searchResults
      });
      $("#found-matches").html(indexView.render().$el);
     }
   });

  },

  render: function() {
    console.log("Search#render called");
    var renderedContent = this.template({});
    this.$el.html(renderedContent);
    var that = this;

    $.get( "search_fields", function( data ) {
      that.$el.children('form').prepend(data);
      that.$el.find('section.more-identity-information').remove();
    });

    return this;
  }
});