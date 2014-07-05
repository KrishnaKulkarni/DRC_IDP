window.IdentityMatches = {
  Models: {},
  Collections: {},
  Views: {},
  
  initialize: function() {    
    // List sub-view construction
    var indexView = new IdentityMatches.Views.IomIdentitiesIndex({
      collection: IdentityMatches.Collections.iomIdentities
    });
    IdentityMatches.Collections.iomIdentities.fetch({
      success: function() {
        $("#found-matches").html(indexView.render().$el)
      }
    });
    
    // Search sub-view construction
    // var searchView = new IdentityMatches.Views.IomIdentitiesSearch();
    // $(".display-info-column").html(searchView.render().$el);
  }
  
};

$(IdentityMatches.initialize);