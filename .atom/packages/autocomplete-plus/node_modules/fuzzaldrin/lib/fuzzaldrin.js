(function() {
  var stringScore;

  stringScore = require('../vendor/stringscore');

  module.exports = {
    filter: require('./filter'),
    score: function(string, query) {
      if (!string) {
        return 0;
      }
      if (!query) {
        return 0;
      }
      return stringScore(string, query);
    }
  };

}).call(this);
