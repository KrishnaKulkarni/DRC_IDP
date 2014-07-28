IdentityMatches.Views.IomIdentitiesReconciliations = Backbone.View.extend({
  template: JST["iom_identities/reconciliations"],

  events: {
    "click ul" : "featureItem",
    "dblclick ul" : "removeMatch"
  },

  initialize: function(options) {
    this.listenTo(this.collection, "add remove", this.render);
  },

  featureItem: function(event) {

    $("li.featured").removeClass("featured");
    $(event.target).closest("li").addClass("featured");
  },

  removeMatch: function(event) {
    var li = $(event.target).closest("li");
    li.parent("a").prependTo("#matches-list");

    var id = li.prop('id');

    var identityToRemove = IdentityMatches.Collections.selectedMatches.get(id);
    IdentityMatches.Collections.selectedMatches.remove(identityToRemove);

    $("#create-reconciliations").children("#" + id).remove();
  },

  render: function() {
    console.log("Selected render called");
    var renderedContent = this.template({ iomIdentities: this.collection });
    this.$el.html(renderedContent);

    return this;
  }
});