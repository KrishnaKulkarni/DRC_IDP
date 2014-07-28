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
    var $li = $(event.target).closest("li");
    var id = $li.prop('id');
    $li.addClass("featured");
  },

  createMatch: function(event) {
    var $li = $(event.target).closest("li");
    var id = $li.prop('id');

    var selectedIdentity = IdentityMatches.Collections.searchResults.get(id);
    IdentityMatches.Collections.selectedMatches.add(selectedIdentity);
    $li.addClass('already-selected');

    var matchInput = "<input type='hidden' id='" + id +"' name='gold_standard_matches[" + id + "]'>";
    $("#create-reconciliations").append(matchInput);
  },

  render: function() {
    var selectedIds = IdentityMatches.Collections.selectedMatches.pluck("id");
    var alreadySelected = IdentityMatches.Collections.searchResults.filter(function(identity){ return selectedIds.indexOf(identity.id) != -1 }); 
    this.collection.forEach(function(identity){
      if(selectedIds.indexOf(identity.id) != -1){
        identity.alreadySelected = "already-selected";
      }
      else {
        identity.alreadySelected = null;
      }
    });

    var renderedContent = this.template({ 
      iomIdentities: this.collection,
      alreadySelected: alreadySelected
     });
    this.$el.html(renderedContent);

    return this;
  }
});