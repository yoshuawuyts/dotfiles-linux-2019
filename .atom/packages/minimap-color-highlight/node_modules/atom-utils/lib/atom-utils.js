(function() {
  var __slice = [].slice;

  module.exports = {
    requirePackages: function() {
      var packages;
      packages = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      return new Promise(function(resolve, reject) {
        var failures, promises, remains, required, solved;
        required = [];
        promises = [];
        failures = [];
        remains = packages.length;
        solved = function() {
          remains--;
          if (remains !== 0) {
            return;
          }
          if (failures.length > 0) {
            return reject(failures);
          }
          return resolve(required);
        };
        return packages.forEach(function(pkg, i) {
          return promises.push(atom.packages.activatePackage(pkg).then(function(activatedPackage) {
            required[i] = activatedPackage.mainModule;
            return solved();
          }).fail(function(reason) {
            failures[i] = reason;
            return solved();
          }));
        });
      });
    }
  };

}).call(this);
