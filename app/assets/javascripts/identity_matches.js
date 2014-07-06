window.IdentityMatches = {
  Models: {},
  Collections: {},
  Routers: {},
  Views: {},
  
  initialize: function() {    

    
    // Search sub-view construction
    // var searchView = new IdentityMatches.Views.IomIdentitiesSearch();
    // $(".display-info-column").html(searchView.render().$el);
  
    new IdentityMatches.Routers.MatchesRouter();
    Backbone.history.start();
  }
  
};

$(IdentityMatches.initialize);