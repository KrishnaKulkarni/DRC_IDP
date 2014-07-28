IdentityMatches.Collections.IomIdentities = Backbone.Collection.extend({
  model: IdentityMatches.Models.IomIdentity,

 url: "api/iom_identities",

  initialize: function(models, options) {
  // this.goldStandardIdentity = options.goldStandardIdentity;
  }
});