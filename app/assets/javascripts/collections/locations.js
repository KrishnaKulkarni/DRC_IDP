IdentityMatches.Collections.Villages = Backbone.Collection.extend({
  url: "api/locations/villages",

  initialize: function(models, options) {}
});

IdentityMatches.Collections.Groups = Backbone.Collection.extend({
  url: "api/locations/groups",

  initialize: function(models, options) {}
});

IdentityMatches.Collections.Collectives = Backbone.Collection.extend({

  url: "api/locations/collectives",

  initialize: function(models, options) {}
});

IdentityMatches.Collections.Territories = Backbone.Collection.extend({

  url: "api/locations/territories",

  initialize: function(models, options) {}
});

IdentityMatches.Collections.Provinces = Backbone.Collection.extend({

  url: "api/locations/provinces",

  initialize: function(models, options) {}
});

IdentityMatches.Collections.villages = new IdentityMatches.Collections.Villages();
IdentityMatches.Collections.groups = new IdentityMatches.Collections.Groups();
IdentityMatches.Collections.collectives = new IdentityMatches.Collections.Collectives();
IdentityMatches.Collections.territories = new IdentityMatches.Collections.Territories();
IdentityMatches.Collections.provinces = new IdentityMatches.Collections.Provinces();