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
    var $li = $(event.target).closest("li");

    var id = $li.prop('id');

    var identityToRemove = IdentityMatches.Collections.selectedMatches.get(id);
    IdentityMatches.Collections.selectedMatches.remove(identityToRemove);
    $("#matches-list").find("li#"+ id).removeClass('already-selected');

    $("#create-reconciliations").children("#" + id).remove();
  },

  render: function() {
    var renderedContent = this.template({ iomIdentities: this.collection });
    this.$el.html(renderedContent);

    return this;
  }
});