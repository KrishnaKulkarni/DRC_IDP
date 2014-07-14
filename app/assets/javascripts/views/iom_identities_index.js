IdentityMatches.Views.IomIdentitiesIndex = Backbone.View.extend({
  template: JST["iom_identities/index"],

  events: {
    "click button.refresh" : "refresh",
    "click ul" : "featureItem",
    "dblclick ul" : "createMatch"
  },

  initialize: function(options) {
  },

  refresh: function() {
    this.collection.fetch({
      success: this.render.bind(this)
    });
  },

  featureItem: function(event) {
    console.log("Single click works");

    $("li.featured").removeClass("featured");
    $(event.target).addClass("featured");
  },

  createMatch: function(event) {
    console.log("Double click works");
    var li = $(event.target);
    li.parent("a").appendTo("#reconciliations-list");
    var id = li.prop('id');
    var matchInput = "<input type='hidden' id='" + id +"' name='gold_standard_matches[" + id + "]'>";
    $("#create-reconciliations").append(matchInput);
  },

  render: function() {
    var renderedContent = this.template({ iomIdentities: this.collection });
    this.$el.html(renderedContent);

    return this;
  }
});