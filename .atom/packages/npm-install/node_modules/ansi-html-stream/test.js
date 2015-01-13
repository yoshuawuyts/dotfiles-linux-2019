var assert = require('assert')
  , concat = require('concat-stream')
  , clone = require('clone')
  , ansi = require('./')

require('colors')

var colors = [
    { hex: '#ff7e76', fgcode: '31', bgcode: '41', name: 'red' }
  , { hex: '#a4f87b', fgcode: '32', bgcode: '42', name: 'green' }
  , { hex: '#f6fcc0', fgcode: '33', bgcode: '43', name: 'yellow' }
  , { hex: '#9cd8fb', fgcode: '34', bgcode: '44', name: 'blue' }
  , { hex: '#ff85f6', fgcode: '35', bgcode: '45', name: 'magenta' }
  , { hex: '#cfd0f8', fgcode: '36', bgcode: '46', name: 'cyan' }
];

function testClassAndInline(callback) {
  [true, false].forEach(function(classTest) {
    suite(classTest ? 'Classes' : 'Inline', function() {
      callback(classTest)
    })
  })
};

function testAllColors(callback) {
  testClassAndInline(function(classTest) {
    colors.forEach(function(props) {
      props = clone(props)
      props.classes = classTest
      callback(props)
    })
  })
};

function testColorGroups(n, m, callback) {
  if (typeof m === 'function') {
    callback = m;
    m = 0;
  }
  testClassAndInline(function(classTest) {
    var l = colors.length - n + 1
      , i = 0
      , props

    function handle(c) {
      c = clone(c)
      c.classes = classTest
      return c
    };

    for (; i < l && (!m || i < m); i += 1) {
      callback.apply(this, colors.slice(i, i + n).map(handle))
    }
  })
};

function concatANSI(input, options, callback) {
  var stream = ansi(options)
  stream.pipe(concat(callback))
  stream.end(input)
  return stream
};

suite('ANSI Stream', function() {
  suite('Single Chunks', function() {
    testAllColors(function(props) {
      test(props.name[props.name], function(done) {
        concatANSI('hello'[props.name], {
            chunked: false
          , classes: props.classes
        }, function(err, data) {
          if (err) return done(err)
          if (props.classes) {
            assert.equal(data, '<span class="ansi-fg-' + props.name + '">hello</span>')
          } else {
            assert.equal(data, '<span style="color:' + props.hex + '">hello</span>')
          }
          done()
        })
      })
    })
  })

  suite('Mixed Plain and Coloured', function() {
    testAllColors(function(props) {
      test(props.name[props.name], function(done) {
        concatANSI('lorem ' + 'ipsum'[props.name] + ' dolor', {
            chunked: false
          , classes: props.classes
        }, function(err, data) {
          if (err) return done(err)
          if (props.classes) {
            assert.equal(data, 'lorem <span class="ansi-fg-' + props.name + '">ipsum</span> dolor')
          } else {
            assert.equal(data, 'lorem <span style="color:' + props.hex + '">ipsum</span> dolor')
          }
          done()
        })
      })
    })
  })

  suite('Handles underline', function(done) {
    test('Underline with no colour', function(done) {
      concatANSI('not underlined, ' + 'underlined'.underline + ', not underlined', {
        chunked: false
      }, function(err, data) {
        assert.equal(data, 'not underlined, <span style="text-decoration:underline">underlined</span>, not underlined')
      })
      done()
    })
    test('Underline and colour', function(done) {
      concatANSI('not underlined, ' + 'underlined & coloured'.red.underline + ', not underlined', {
        chunked: false
      }, function(err, data) {
        assert.equal(data, 'not underlined, <span style="text-decoration:underline"><span style="color:#ff7e76">underlined &amp; coloured</span></span>, not underlined')
      })
      done()
    })
  })

  suite('Side-by-side colour changes', function() {
    testColorGroups(2, 2, function(col1, col2) {
      var string = [
          'lorem'
        , 'ipsum'[col1.name]
        , 'dolor'[col2.name]
        , 'sit'
      ].join(' ')

      test(col1.name[col1.name] + ', ' + col2.name[col2.name], function() {
        concatANSI(string, {
          classes: col1.classes
        }, function(err, data) {
          if (err) return done(err)
          if (col1.classes) {
            assert.equal(data, 'lorem <span class="ansi-fg-' + col1.name + '">ipsum</span> <span class="ansi-fg-' + col2.name + '">dolor</span> sit')
          } else {
            assert.equal(data, 'lorem <span style="color:' + col1.hex + '">ipsum</span> <span style="color:' + col2.hex + '">dolor</span> sit')
          }
        })
      })
    })
  })

  suite('Overriding colours', function() {
    function testCombo(bg, cb) {
      return function() {
        testColorGroups(3, 2, function(col1, col2, col3) {
          var string = [
              '\u001b[' + col1[bg[0] ? 'bgcode' : 'fgcode'] + 'm'
            , 'hello'
            , '\u001b[' + col2[bg[1] ? 'bgcode' : 'fgcode'] + 'm'
            , 'world\n'
            , '\u001b[' + col3[bg[2] ? 'bgcode' : 'fgcode'] + 'm'
            , 'again'
          ].join('');

          function colors(col) { return col.name[col.name] };

          test([col1, col2, col3].map(colors).join(', '), function(done) {
            concatANSI(string, {
              classes: col1.classes
            }, function(err, data) {
              if (err) return done(err)

              var args = [col1, col2, col3]
              args.unshift(data)
              args.push(done)

              cb.apply(this, args)
            })
          })
        })
      };
    };

    function span(col, background) {
      return col.classes ?
        '<span class="ansi-' + (background ? 'bg' : 'fg') + '-' + col.name + '">' :
        '<span style="' + (background ? 'background-color' : 'color' ) + ':' + col.hex + '">'
    };

    suite('Foregrounds', testCombo([false, false, false], function(data, col1, col2, col3, done) {
      assert.equal(data, [
          span(col1, false) + 'hello</span>'
        , span(col2, false) + 'world\n</span>'
        , span(col3, false) + 'again</span>'
      ].join(''))
      done()
    }))

    suite('Backgrounds', testCombo([true, true, true], function(data, col1, col2, col3, done) {
      assert.equal(data, [
          span(col1, true) + 'hello</span>'
        , span(col2, true) + 'world\n</span>'
        , span(col3, true) + 'again</span>'
      ].join(''))
      done()
    }))

    suite('BG/FG/FB', testCombo([true, false, true], function(data, col1, col2, col3, done) {
      assert.equal(data, [
          span(col1, true) + 'hello'
        , span(col2, false) + 'world\n</span></span>'
        , span(col3, true) + 'again</span>'
      ].join(''))
      done()
    }))

    suite('BG/FG/FG', testCombo([true, false, false], function(data, col1, col2, col3, done) {
      assert.equal(data, [
          span(col1, true) + 'hello'
        , span(col2, false) + 'world\n</span>'
        , span(col3, false) + 'again</span></span>'
      ].join(''))
      done()
    }))

    suite('FG/FG/BG', testCombo([true, true, false], function(data, col1, col2, col3, done) {
      assert.equal(data, [
          span(col1, true) + 'hello</span>'
        , span(col2, true) + 'world\n'
        , span(col3, false) + 'again</span></span>'
      ].join(''))
      done()
    }))
  })
})
