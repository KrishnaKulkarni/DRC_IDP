IdentityMatches.Views.IomIdentitiesIndex = Backbone.View.extend({
  template: JST["iom_identities/index"],
  
  events: {
    "click button.refresh" : "refresh"
  },
  
  initialize: function(options) {
  },
  
  refresh: function() {
    this.collection.fetch({
      success: this.render.bind(this)
    });
  },
  
  render: function() {
    console.log("index#render");
    console.log("coll", this.collection);
    var renderedContent = this.template({ iomIdentities: this.collection });
    this.$el.html(renderedContent);
    
    return this;
  }
});