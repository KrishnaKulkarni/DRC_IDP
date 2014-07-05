IdentityMatches.Views.IomIdentitiesIndex = Backbone.View.extend({
  template: JST["iom_identities/index"],
  
  events: {
    "click button.refresh" : "refresh"
  },
  
  initialize: function(options) {
    
  },
  
  searchMatches: function() {
   console.log("Clicked Search button!");
  },
  
  refresh: function() {
    this.collection.fetch({
      success: this.render.bind(this)
    });
  },
  
  render: function() {
    var renderedContent = this.template({ iom_identities: this.collection });
    this.$el.html(renderedContent);
    
    return this;
  }
});