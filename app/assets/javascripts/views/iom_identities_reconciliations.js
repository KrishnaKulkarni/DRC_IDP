IdentityMatches.Views.IomIdentitiesReconciliations = Backbone.View.extend({
  template: JST["iom_identities/reconciliations"],

  events: {
    "click ul" : "featureItem",
    "dblclick ul" : "removeMatch"
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

  removeMatch: function(event) {
 //   $(event.target).parent("a").addClass("move");
    var li = $(event.target);
    li.parent("a").prependTo("#matches-list");

    var id = li.prop('id');
    $("#create-reconciliations").children("#" + id).remove();
    //    $(".move").appendTo("#matches-list");
    //  $(".move").removeClass("move");
  },

  render: function() {
    var renderedContent = this.template({});
    this.$el.html(renderedContent);

    return this;
  }
});