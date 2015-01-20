(function() {
  var Emitter, PropertyAccessors, Sequence, isEqual,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    __slice = [].slice;

  isEqual = require('underscore-plus').isEqual;

  Emitter = require('emissary').Emitter;

  PropertyAccessors = require('property-accessors');

  module.exports = Sequence = (function(_super) {
    __extends(Sequence, _super);

    Emitter.includeInto(Sequence);

    PropertyAccessors.includeInto(Sequence);

    Sequence.prototype.suppressChangeEvents = false;

    Sequence.fromArray = function(array) {
      if (array == null) {
        array = [];
      }
      array = array.slice();
      array.__proto__ = this.prototype;
      return array;
    };

    function Sequence() {
      var elements;
      elements = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      return Sequence.fromArray(elements);
    }

    Sequence.prototype.set = function(index, value) {
      var insertedValues, oldLength, removedValues;
      if (index >= this.length) {
        oldLength = this.length;
        removedValues = [];
        this[index] = value;
        insertedValues = this.slice(oldLength, +(index + 1) + 1 || 9e9);
        index = oldLength;
      } else {
        removedValues = [this[index]];
        insertedValues = [value];
        this[index] = value;
      }
      return this.emitChanged({
        index: index,
        removedValues: removedValues,
        insertedValues: insertedValues
      });
    };

    Sequence.prototype.splice = function() {
      var count, index, insertedValues, removedValues;
      index = arguments[0], count = arguments[1], insertedValues = 3 <= arguments.length ? __slice.call(arguments, 2) : [];
      removedValues = Sequence.__super__.splice.apply(this, arguments);
      this.emitChanged({
        index: index,
        removedValues: removedValues,
        insertedValues: insertedValues
      });
      return removedValues;
    };

    Sequence.prototype.push = function() {
      var index, insertedValues, result;
      insertedValues = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      index = this.length;
      this.suppressChangeEvents = true;
      result = Sequence.__super__.push.apply(this, arguments);
      this.suppressChangeEvents = false;
      this.emitChanged({
        index: index,
        removedValues: [],
        insertedValues: insertedValues
      });
      return result;
    };

    Sequence.prototype.pop = function() {
      var result;
      this.suppressChangeEvents = true;
      result = Sequence.__super__.pop.apply(this, arguments);
      this.suppressChangeEvents = false;
      this.emitChanged({
        index: this.length,
        removedValues: [result],
        insertedValues: []
      });
      return result;
    };

    Sequence.prototype.unshift = function() {
      var insertedValues, result;
      insertedValues = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      this.suppressChangeEvents = true;
      result = Sequence.__super__.unshift.apply(this, arguments);
      this.suppressChangeEvents = false;
      this.emitChanged({
        index: 0,
        removedValues: [],
        insertedValues: insertedValues
      });
      return result;
    };

    Sequence.prototype.shift = function() {
      var result;
      this.suppressChangeEvents = true;
      result = Sequence.__super__.shift.apply(this, arguments);
      this.suppressChangeEvents = false;
      this.emitChanged({
        index: 0,
        removedValues: [result],
        insertedValues: []
      });
      return result;
    };

    Sequence.prototype.isEqual = function(other) {
      var v;
      return (this === other) || isEqual((function() {
        var _i, _len, _results;
        _results = [];
        for (_i = 0, _len = this.length; _i < _len; _i++) {
          v = this[_i];
          _results.push(v);
        }
        return _results;
      }).call(this), (function() {
        var _i, _len, _results;
        _results = [];
        for (_i = 0, _len = other.length; _i < _len; _i++) {
          v = other[_i];
          _results.push(v);
        }
        return _results;
      })());
    };

    Sequence.prototype.onEach = function(callback) {
      this.forEach(callback);
      return this.on('changed', function(_arg) {
        var i, index, insertedValues, value, _i, _len, _results;
        index = _arg.index, insertedValues = _arg.insertedValues;
        _results = [];
        for (i = _i = 0, _len = insertedValues.length; _i < _len; i = ++_i) {
          value = insertedValues[i];
          _results.push(callback(value, index + i));
        }
        return _results;
      });
    };

    Sequence.prototype.onRemoval = function(callback) {
      return this.on('changed', function(_arg) {
        var index, removedValues, value, _i, _len, _results;
        index = _arg.index, removedValues = _arg.removedValues;
        _results = [];
        for (_i = 0, _len = removedValues.length; _i < _len; _i++) {
          value = removedValues[_i];
          _results.push(callback(value, index));
        }
        return _results;
      });
    };

    Sequence.prototype.lazyAccessor('$length', function() {
      var _this = this;
      return this.signal('changed').map(function() {
        return _this.length;
      }).distinctUntilChanged().toBehavior(this.length);
    });

    Sequence.prototype.setLength = function(length) {
      var index, insertedValues, removedValues;
      if (length < this.length) {
        index = length;
        removedValues = this.slice(index);
        insertedValues = [];
        this.length = length;
        return this.emitChanged({
          index: index,
          removedValues: removedValues,
          insertedValues: insertedValues
        });
      } else if (length > this.length) {
        index = this.length;
        removedValues = [];
        this.length = length;
        insertedValues = this.slice(index);
        return this.emitChanged({
          index: index,
          removedValues: removedValues,
          insertedValues: insertedValues
        });
      }
    };

    Sequence.prototype.emitChanged = function(event) {
      if (!this.suppressChangeEvents) {
        return this.emit('changed', event);
      }
    };

    return Sequence;

  })(Array);

}).call(this);
