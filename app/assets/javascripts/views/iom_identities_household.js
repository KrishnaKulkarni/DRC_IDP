IdentityMatches.Views.IomIdentitiesHousehold = Backbone.View.extend({
  template: JST["iom_identities/household"],

  events: {
    "click ul" : "featureItem",
    "click #name" : "sortByName",
    "click #last-name" : "sortByLastName",
    "click #first-name" : "sortByFirstName",
    "click #age" : "sortByAge"
  },

  initialize: function(options) {
    this.listenTo(this.collection, "add remove", this.render);
  },

  featureItem: function(event) {
    $("li.featured").removeClass("featured");
    $(event.target).closest("li").addClass("featured");
  },

  sortByAge: function(){
    this.collection = IdentityMatches.Collections.householdMembers.sortBy(function(identity) { return identity.get('date_of_birth') } );
    this.render();
    $("span.selected").removeClass("selected");
    $("span#age").addClass("selected");
  },

  sortByName: function(){
    this.collection = IdentityMatches.Collections.householdMembers.sortBy(function(identity) { return identity.get('last_name') + identity.get('first_name') } );
    this.render();
    $("span.selected").removeClass("selected");
    $("span#name").addClass("selected");
  },

  sortByFirstName: function(){
    this.collection = IdentityMatches.Collections.householdMembers.sortBy(function(identity) { return identity.get('first_name') } );
    this.render();
    $("span.selected").removeClass("selected");
    $("span#first-name").addClass("selected");
  },

  sortByLastName: function(){
    this.collection = IdentityMatches.Collections.householdMembers.sortBy(function(identity) { return identity.get('last_name') } );
    this.render();
    $("span.selected").removeClass("selected");
    $("span#last-name").addClass("selected");
  },

  render: function() {
    var renderedContent = this.template({ householdMembers: this.collection });
    this.$el.html(renderedContent);
    return this;
  }
});