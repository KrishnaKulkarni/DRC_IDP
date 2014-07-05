window.IdentityMatches = {
  Models: {},
  Collections: {},
  Views: {},
  
  initialize: function() {    
    var view = new IdentityMatches.Views.IomIdentitiesIndex({
      collection: IdentityMatches.Collections.iomIdentities
    });

    IdentityMatches.Collections.iomIdentities.fetch({
      success: function() {
        $("body").append(view.render().$el)
      }
    });
  }
  
};

$(IdentityMatches.initialize);