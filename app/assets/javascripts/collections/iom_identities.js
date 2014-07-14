IdentityMatches.Collections.IomIdentities = Backbone.Collection.extend({
  model: IdentityMatches.Models.IomIdentity,

  // url: function(){
  //   return this.goldStandardIdentity.url() + "/iom_identities";
  // },

 url: "api/iom_identities",
  // url: "api/gold_standard_identities",


  initialize: function(models, options) {
  // this.goldStandardIdentity = options.goldStandardIdentity;
  }
});

// Need a gold standard identity to initialize with
IdentityMatches.Collections.iomIdentities = new IdentityMatches.Collections.IomIdentities();