IdentityMatches.Views.IomIdentitiesShow = Backbone.View.extend({
  template: JST["iom_identities/show"],
  
  events: {
  },
  
  initialize: function(options) {    
  },
  
  render: function() {
    var renderedContent = this.template({ iomIdentity: this.model });
    this.$el.html(renderedContent);
    
    return this;
  }
});