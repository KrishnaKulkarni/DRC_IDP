IdentityMatches.Views.IomIdentitiesSearch = Backbone.View.extend({
  template: JST["iom_identities/search"],
  tagName: "div",

  events: {
    "click input.search-button" : "searchMatches",
    "click input.register-button" : "registerMatches",
  },

  initialize: function(options) {
  },

  searchMatches: function(event) {
   event.preventDefault();
   var params = $(event.currentTarget);
    // var params = $(event.currentTarget).serializeJSON();
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

  registerMatches: function(event) {
   event.preventDefault();
   $.ajax({
     type: "POST",
     url: "api/gold_standard_identities",
     data: $( "#search-matches-form").serialize(),
     success: function(resp){
      console.log("Response ::", resp);
      var message = "You have successfully registered " + resp["first_name"] + " " + resp["last_name"] + ".";
      $(".status-message").text(message);
      $(".status-message").addClass("success-green");
      id = resp['id'];
      var goldInput = "<input type='hidden' name='gold_standard_identities[" + id + "]'>";
      $("#base-gold-identity").html(goldInput);
     },
     error: function(resp) {
       console.log(resp);
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