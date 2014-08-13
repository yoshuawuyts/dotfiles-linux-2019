var assert = require('assert')
  , special = require('../')

suite('special-html', function() {
  suite('Should convert', function() {
    '├─✓✖∑®†ß'.split('').forEach(function(c) {
      var code = c.charCodeAt(0)
      test(c + ' (' + code + ')', function() {
        assert.equal(special(c), '&#' + code + ';')
      })
    })
  })
  suite('Should not convert', function() {
    'abcdefgHIJKLUVWxyz-!?*~ <>'.split('').forEach(function(c) {
      var code = c.charCodeAt(0)
      test(c + ' (' + code + ')', function() {
        assert.equal(special(c), c)
      })
    })
  })
})
