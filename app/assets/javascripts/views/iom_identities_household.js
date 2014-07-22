IdentityMatches.Views.IomIdentitiesHousehold = Backbone.View.extend({
  template: JST["iom_identities/household"],

  events: {
    "click ul" : "featureItem"
  },

  initialize: function(options) {},

  featureItem: function(event) {
    $("li.featured").removeClass("featured");
    $(event.target).closest("li").addClass("featured");
  },

  render: function() {
    var renderedContent = this.template({ householdMembers: this.collection });
    this.$el.html(renderedContent);
    return this;
  }
});