(function() {
  var Deprecation, Emitter, grim, _;

  _ = require('underscore-plus');

  Emitter = require('emissary').Emitter;

  Deprecation = require('./deprecation');

  if (global.__grim__ == null) {
    grim = global.__grim__ = {
      grimDeprecations: [],
      maxDeprecationCallCount: function() {
        return 250;
      },
      getDeprecations: function() {
        return _.clone(grim.grimDeprecations);
      },
      getDeprecationsLength: function() {
        return grim.grimDeprecations.length;
      },
      clearDeprecations: function() {
        return grim.grimDeprecations = [];
      },
      logDeprecations: function() {
        var deprecation, deprecations, _i, _len, _results;
        deprecations = grim.getDeprecations();
        deprecations.sort(function(a, b) {
          return b.getCallCount() - a.getCallCount();
        });
        console.warn("\nCalls to deprecated functions\n-----------------------------");
        _results = [];
        for (_i = 0, _len = deprecations.length; _i < _len; _i++) {
          deprecation = deprecations[_i];
          _results.push(console.warn("(" + (deprecation.getCallCount()) + ") " + (deprecation.getOriginName()) + " : " + (deprecation.getMessage()), deprecation));
        }
        return _results;
      },
      deprecate: function(message) {
        var deprecation, deprecations, methodName, stack;
        stack = Deprecation.generateStack().slice(1);
        methodName = Deprecation.getFunctionNameFromCallsite(stack[0]);
        deprecations = grim.grimDeprecations;
        if (!(deprecation = _.find(deprecations, function(d) {
          return d.getOriginName() === methodName;
        }))) {
          deprecation = new Deprecation(message);
          grim.grimDeprecations.push(deprecation);
        }
        if (deprecation.getCallCount() < grim.maxDeprecationCallCount()) {
          deprecation.addStack(stack);
          return grim.emit("updated", deprecation);
        }
      }
    };
    Emitter.extend(grim);
  }

  module.exports = global.__grim__;

}).call(this);
