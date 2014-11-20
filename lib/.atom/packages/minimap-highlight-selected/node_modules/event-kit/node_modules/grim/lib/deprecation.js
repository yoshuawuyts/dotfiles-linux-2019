(function() {
  var Deprecation, _;

  _ = require('underscore-plus');

  module.exports = Deprecation = (function() {
    Deprecation.generateStack = function() {
      var error, originalPrepareStackTrace, stack;
      originalPrepareStackTrace = Error.prepareStackTrace;
      Error.prepareStackTrace = function(error, stack) {
        return stack;
      };
      error = new Error();
      Error.captureStackTrace(error);
      stack = error.stack.slice(1);
      Error.prepareStackTrace = originalPrepareStackTrace;
      return stack;
    };

    Deprecation.getFunctionNameFromCallsite = function(callsite) {
      var _ref, _ref1, _ref2;
      if (callsite.isToplevel()) {
        return (_ref = callsite.getFunctionName()) != null ? _ref : '<unknown>';
      } else {
        if (callsite.isConstructor()) {
          return "new " + (callsite.getFunctionName());
        } else if (callsite.getMethodName() && !callsite.getFunctionName()) {
          return callsite.getMethodName();
        } else {
          return "" + (callsite.getTypeName()) + "." + ((_ref1 = (_ref2 = callsite.getMethodName()) != null ? _ref2 : callsite.getFunctionName()) != null ? _ref1 : '<anonymous>');
        }
      }
    };

    function Deprecation(message) {
      this.message = message;
      this.callCount = 0;
      this.stacks = [];
    }

    Deprecation.prototype.getFunctionNameFromCallsite = function(callsite) {
      return Deprecation.getFunctionNameFromCallsite(callsite);
    };

    Deprecation.prototype.getLocationFromCallsite = function(callsite) {
      if (callsite.isNative()) {
        return "native";
      } else if (callsite.isEval()) {
        return "eval at " + (this.getLocationFromCallsite(callsite.getEvalOrigin()));
      } else {
        return "" + (callsite.getFileName()) + ":" + (callsite.getLineNumber()) + ":" + (callsite.getColumnNumber());
      }
    };

    Deprecation.prototype.getOriginName = function() {
      return this.originName;
    };

    Deprecation.prototype.getMessage = function() {
      return this.message;
    };

    Deprecation.prototype.getStacks = function() {
      return _.clone(this.stacks);
    };

    Deprecation.prototype.getCallCount = function() {
      return this.callCount;
    };

    Deprecation.prototype.addStack = function(stack) {
      var existingStack;
      if (this.originName == null) {
        this.originName = this.getFunctionNameFromCallsite(stack[0]);
      }
      stack = this.parseStack(stack);
      if (existingStack = this.isStackUnique(stack)) {
        existingStack.callCount++;
      } else {
        this.stacks.push(stack);
      }
      return this.callCount++;
    };

    Deprecation.prototype.parseStack = function(stack) {
      stack = stack.map((function(_this) {
        return function(callsite) {
          return {
            functionName: _this.getFunctionNameFromCallsite(callsite),
            location: _this.getLocationFromCallsite(callsite),
            fileName: callsite.getFileName()
          };
        };
      })(this));
      stack.callCount = 1;
      return stack;
    };

    Deprecation.prototype.isStackUnique = function(stack) {
      var stacks;
      stacks = this.stacks.filter(function(s) {
        var callsite, functionName, i, location, _i, _len, _ref;
        if (s.length !== stack.length) {
          return false;
        }
        for (i = _i = 0, _len = s.length; _i < _len; i = ++_i) {
          _ref = s[i], functionName = _ref.functionName, location = _ref.location;
          callsite = stack[i];
          if (!(functionName === callsite.functionName && location === callsite.location)) {
            return false;
          }
        }
        return true;
      });
      return stacks[0];
    };

    return Deprecation;

  })();

}).call(this);
