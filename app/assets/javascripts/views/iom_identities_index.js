IdentityMatches.Views.IomIdentitiesIndex = Backbone.View.extend({
  template: JST["iom_identities/index"],

  events: {
    "click ul" : "featureItem",
    "dblclick ul" : "createMatch"
  },

  initialize: function(options) {
  },

  featureItem: function(event) {
    $("li.featured").removeClass("featured");
    $(event.target).closest("li").addClass("featured");
  },

  createMatch: function(event) {
    var li = $(event.target).closest("li");
    // li.parent("a").appendTo("#reconciliations-list");
    var id = li.prop('id');

    var selectedIdentity = IdentityMatches.Collections.searchResults.get(id);
    IdentityMatches.Collections.selectedMatches.add(selectedIdentity);

    var matchInput = "<input type='hidden' id='" + id +"' name='gold_standard_matches[" + id + "]'>";
    $("#create-reconciliations").append(matchInput);
  },

  render: function() {
    var renderedContent = this.template({ iomIdentities: this.collection });
    this.$el.html(renderedContent);

    return this;
  }
});