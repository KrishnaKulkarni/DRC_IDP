IdentityMatches.Routers.MatchesRouter = Backbone.Router.extend({
  routes: {
    "" : "setUpViews",
    "iom_identities" : "iomIdentitiesIndex",
    "iom_identities/:id" : "iomIdentitiesShow"
  },

  setUpViews: function() {
    var searchView = new IdentityMatches.Views.IomIdentitiesSearch({});
    $(".search-bar").html(searchView.render().$el);
    var reconciliationsView = new IdentityMatches.Views.IomIdentitiesReconciliations({});
    $("#matches").html(reconciliationsView.render().$el);
  },

  searchMatchesForm: function() {
    var searchView = new IdentityMatches.Views.IomIdentitiesSearch({});
    $(".search-bar").html(searchView.render().$el);
  },

  // Should I be separating fetching from rendering, as they do in the demo?
  iomIdentitiesIndex: function(matches) {
    var indexView = new IdentityMatches.Views.IomIdentitiesIndex({
      collection: matches
    });

    $("#found-matches").html(indexView.render().$el)

    // IdentityMatches.Collections.iomIdentities.fetch({
    //   success: function() {
    //     $("#found-matches").html(indexView.render().$el)
    //   }
    // });
  },

  iomIdentitiesShow: function(id) {
    var iomIdentity = IdentityMatches.Collections.iomIdentities.get(id);
    var showView = new IdentityMatches.Views.IomIdentitiesShow({
      model: iomIdentity
    });
    $("#featured-identity").html(showView.render().$el);
  }

});