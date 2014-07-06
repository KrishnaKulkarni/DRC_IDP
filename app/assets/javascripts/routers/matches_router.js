IdentityMatches.Routers.MatchesRouter = Backbone.Router.extend({
  routes: {
    "" : "searchMatchesForm",
    "iom_identities" : "iomIdentitiesIndex",
    "iom_identities/:id" : "iomIdentitiesShow"
  },
  
  searchMatchesForm: function() {
    console.log("Put the form in!");
    var searchView = new IdentityMatches.Views.IomIdentitiesSearch({});
    $(".search-bar").html(searchView.render().$el);
  },
  
  // Should I be separating fetching from rendering, as they do in the demo?
  iomIdentitiesIndex: function() {    
    var indexView = new IdentityMatches.Views.IomIdentitiesIndex({
      collection: IdentityMatches.Collections.iomIdentities
    });    

    IdentityMatches.Collections.iomIdentities.fetch({
      success: function() {
        $("#found-matches").html(indexView.render().$el)
      }
    });    
  },
  
  iomIdentitiesShow: function(id) {
    var iomIdentity = IdentityMatches.Collections.iomIdentities.get(id);
    var showView = new IdentityMatches.Views.IomIdentitiesShow({
      model: iomIdentity
    });    
    $("#featured-identity").html(showView.render().$el);
  }
  
});