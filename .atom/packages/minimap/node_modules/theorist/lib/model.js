(function() {
  var Behavior, Delegator, Emitter, Model, PropertyAccessors, Subscriber, nextInstanceId, _ref,
    __slice = [].slice;

  _ref = require('emissary'), Behavior = _ref.Behavior, Subscriber = _ref.Subscriber, Emitter = _ref.Emitter;

  PropertyAccessors = require('property-accessors');

  Delegator = require('delegato');

  nextInstanceId = 1;

  module.exports = Model = (function() {
    Subscriber.includeInto(Model);

    Emitter.includeInto(Model);

    PropertyAccessors.includeInto(Model);

    Delegator.includeInto(Model);

    Model.resetNextInstanceId = function() {
      return nextInstanceId = 1;
    };

    Model.properties = function() {
      var arg, args, defaultValue, name, _i, _len, _ref1, _results, _results1;
      args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      if (typeof args[0] === 'object') {
        _ref1 = args[0];
        _results = [];
        for (name in _ref1) {
          defaultValue = _ref1[name];
          _results.push(this.property(name, defaultValue));
        }
        return _results;
      } else {
        _results1 = [];
        for (_i = 0, _len = args.length; _i < _len; _i++) {
          arg = args[_i];
          _results1.push(this.property(arg));
        }
        return _results1;
      }
    };

    Model.property = function(name, defaultValue) {
      if (this.declaredProperties == null) {
        this.declaredProperties = {};
      }
      this.declaredProperties[name] = defaultValue;
      this.prototype.accessor(name, {
        get: function() {
          return this.get(name);
        },
        set: function(value) {
          return this.set(name, value);
        }
      });
      return this.prototype.accessor("$" + name, {
        get: function() {
          return this.behavior(name);
        }
      });
    };

    Model.behavior = function(name, definition) {
      if (this.declaredBehaviors == null) {
        this.declaredBehaviors = {};
      }
      this.declaredBehaviors[name] = definition;
      this.prototype.accessor(name, {
        get: function() {
          return this.behavior(name).getValue();
        }
      });
      return this.prototype.accessor("$" + name, {
        get: function() {
          return this.behavior(name);
        }
      });
    };

    Model.hasDeclaredProperty = function(name) {
      var _ref1;
      return (_ref1 = this.declaredProperties) != null ? _ref1.hasOwnProperty(name) : void 0;
    };

    Model.hasDeclaredBehavior = function(name) {
      var _ref1;
      return (_ref1 = this.declaredBehaviors) != null ? _ref1.hasOwnProperty(name) : void 0;
    };

    Model.evaluateDeclaredBehavior = function(name, instance) {
      return this.declaredBehaviors[name].call(instance);
    };

    Model.prototype.declaredPropertyValues = null;

    Model.prototype.behaviors = null;

    Model.prototype.alive = true;

    function Model(params) {
      var propertyName;
      this.assignId(params != null ? params.id : void 0);
      for (propertyName in this.constructor.declaredProperties) {
        if (params != null ? params.hasOwnProperty(propertyName) : void 0) {
          this.set(propertyName, params[propertyName]);
        } else {
          if (this.get(propertyName, true) == null) {
            this.setDefault(propertyName);
          }
        }
      }
    }

    Model.prototype.assignId = function(id) {
      return this.id != null ? this.id : this.id = id != null ? id : nextInstanceId++;
    };

    Model.prototype.setDefault = function(name) {
      var defaultValue, _ref1;
      defaultValue = (_ref1 = this.constructor.declaredProperties) != null ? _ref1[name] : void 0;
      if (typeof defaultValue === 'function') {
        defaultValue = defaultValue.call(this);
      }
      return this.set(name, defaultValue);
    };

    Model.prototype.get = function(name, suppressDefault) {
      if (this.constructor.hasDeclaredProperty(name)) {
        if (this.declaredPropertyValues == null) {
          this.declaredPropertyValues = {};
        }
        if (!(suppressDefault || this.declaredPropertyValues.hasOwnProperty(name))) {
          this.setDefault(name);
        }
        return this.declaredPropertyValues[name];
      } else {
        return this[name];
      }
    };

    Model.prototype.set = function(name, value) {
      var properties, _ref1, _ref2;
      if (typeof name === 'object') {
        properties = name;
        for (name in properties) {
          value = properties[name];
          this.set(name, value);
        }
        return properties;
      } else {
        if (this.get(name, true) !== value) {
          if (this.constructor.hasDeclaredProperty(name)) {
            if (this.declaredPropertyValues == null) {
              this.declaredPropertyValues = {};
            }
            this.declaredPropertyValues[name] = value;
          } else {
            this[name] = value;
          }
          if ((_ref1 = this.behaviors) != null) {
            if ((_ref2 = _ref1[name]) != null) {
              _ref2.emitValue(value);
            }
          }
        }
        return value;
      }
    };

    Model.prototype.advisedAccessor('id', {
      set: function(id) {
        if (id >= nextInstanceId) {
          return nextInstanceId = id + 1;
        }
      }
    });

    Model.prototype.behavior = function(name) {
      var behavior;
      if (this.behaviors == null) {
        this.behaviors = {};
      }
      if (behavior = this.behaviors[name]) {
        return behavior;
      } else {
        if (this.constructor.hasDeclaredProperty(name)) {
          return this.behaviors[name] = new Behavior(this.get(name)).retain();
        } else if (this.constructor.hasDeclaredBehavior(name)) {
          return this.behaviors[name] = this.constructor.evaluateDeclaredBehavior(name, this).retain();
        }
      }
    };

    Model.prototype.when = function(signal, action) {
      var _this = this;
      return this.subscribe(signal, function(value) {
        if (value) {
          if (typeof action === 'function') {
            return action.call(_this);
          } else {
            return _this[action]();
          }
        }
      });
    };

    Model.prototype.destroy = function() {
      var behavior, name, _ref1;
      if (!this.isAlive()) {
        return;
      }
      this.alive = false;
      if (typeof this.destroyed === "function") {
        this.destroyed();
      }
      this.unsubscribe();
      _ref1 = this.behaviors;
      for (name in _ref1) {
        behavior = _ref1[name];
        behavior.release();
      }
      return this.emit('destroyed');
    };

    Model.prototype.isAlive = function() {
      return this.alive;
    };

    Model.prototype.isDestroyed = function() {
      return !this.isAlive();
    };

    return Model;

  })();

}).call(this);
