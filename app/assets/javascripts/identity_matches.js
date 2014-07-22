window.IdentityMatches = {
  Models: {},
  Collections: {},
  Routers: {},
  Views: {},

  initialize: function() {


    // Search sub-view construction
    // var searchView = new IdentityMatches.Views.IomIdentitiesSearch();
    // $(".display-info-column").html(searchView.render().$el);
    IdentityMatches.Collections.iomIdentities.fetch({
      success: function() {
        console.log("Successfully fetched current stored identities.");
      }
    });

    IdentityMatches.Collections.villages.fetch();
    IdentityMatches.Collections.groups.fetch();
    IdentityMatches.Collections.collectives.fetch();
    IdentityMatches.Collections.territories.fetch();
    IdentityMatches.Collections.provinces.fetch();
    new IdentityMatches.Routers.MatchesRouter();
    Backbone.history.start();
  }

};

$(IdentityMatches.initialize);