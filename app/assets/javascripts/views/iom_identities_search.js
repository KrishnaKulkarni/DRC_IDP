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
   var params = $(event.currentTarget);
    // var params = $(event.currentTarget).serializeJSON();
   console.log(params);
   // $.post("kldjasfl", function(data){
   //   console.log("response:", data)
   // });
   // $.post( "test.php", $( "#search-matches-form" ).serialize() );
   $.ajax({
     type: "POST",
     url: "match_results",
     data: $( "#search-matches-form" ).serialize(),
     success: function(resp){
      console.log("Response ::", resp);
      var indexView = new IdentityMatches.Views.IomIdentitiesIndex({
        collection: new IdentityMatches.Collections.IomIdentities(resp)
      });    
      $("#found-matches").html(indexView.render().$el)
     }
   });

  },

  render: function() {
    console.log("Search#render called");
    var renderedContent = this.template({});
    this.$el.html(renderedContent);
    var that = this;

    $.get( "search_fields", function( data ) {
      that.$el.children('form').append(data);
      that.$el.find('section.more-identity-information').remove();
    });

    return this;
  }
});