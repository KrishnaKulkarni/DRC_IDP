IdentityMatches.Collections.IomIdentities = Backbone.Collection.extend({
  model: IdentityMatches.Models.IomIdentity,

  url: function(){
    return this.goldStandardIdentity.url() + "/iom_identities";
  },
  
  initialize: function(models, options) {
   this.goldStandardIdentity = options.goldStandardIdentity;
  }
});