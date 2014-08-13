var escape = require('escape-html')
  , special = require('special-html')
  , map = require('map-stream')
  , clone = require('clone')
  , extend = require('xtend')

/**
 * Returns a through-stream that converts ANSI escape
 * code formatting to HTML.
 *
 * @param options         {Object}
 * @param options.classes {Boolean} If true, use classes instead of inline styles. Defaults to false.
 * @param options.chunked {String}  Wrap each chunk in <span class="options.chunked">
 * @param options.theme   {Object}  Override existing styles - see lib/colors.js
 */
function createStream(options) {
  var options = options || {}
    , colors = require('./colors')
    , groupStack = [] // Keeps track of opened span types.
    , spanStack = []  // Keeps track of opened span markup.
    , chunked = options.chunked && escape(options.chunked) || false
    , groups
    , stream

  colors = clone(colors[options.classes ? 'classes' : 'inline'])
  colors = extend(colors, options.theme || {})

  colors.resets = colors.resets || [{'0':false}]

  groups = Object.keys(colors)

  groups.forEach(function(group) {
    Object.keys(colors[group]).forEach(function(key) {
      var text = '<span'
        , style = colors[group][key]

      if (!style) return

      Object.keys(style).forEach(function(attr) {
        text += ' ' + attr + '="' + style[attr].replace(/\"/g, '') + '"'
      })
      text += '>'

      colors[group][key] = text
    })
  })

  stream = map(function write(string, next) {
    if (chunked) {
      string = spanStack.join('') + string
    }

    string = special(escape(string))
    string = string
      .replace(/\x1B\[([0-9;]*?\d)m/g, handleANSI)    // Handle ANSI colour codes,
      .replace(/\x1B\[(?:[0-9;]*?\d)[a-zA-Z]/g, '')   // and remove other
      .replace(/\x1B\[(?:[suK]|2J|\=\d\d?[h|])/g, '') // ANSI codes

    if (chunked) {
      spanStack.forEach(function() {
        string += '</span>'
      })
    }

    return next(null, string)
  })

  stream.oldend = stream.end
  stream.end = function end(data) {
    if (data) this.write(data)

    var string = ''
    groupStack.forEach(function() {
      string += '</span>'
    })

    this.emit('data', string)
    return this.oldend()
  };

  function handleANSI(fragment, codes) {
    var codes = codes.split(';')
      , prefix = ''
      , suffix = ''

    codes.forEach(function(code) {
      var group
        , style
        , stackIndex

      for (group in colors) {
        if ((style = colors[group][code]) !== undefined) break;
      }

      if (!style) {
        stackIndex = group === 'resets' ? 0 : groupStack.indexOf(group)
        spanStack.splice(stackIndex)
        groupStack.splice(stackIndex).forEach(function() { prefix += '</span>' })
        return
      }

      stackIndex = groupStack.indexOf(group)

      if (stackIndex !== -1) {
        spanStack.splice(stackIndex)
        groupStack.splice(stackIndex).forEach(function() {
          prefix += '</span>'
        })
      }

      groupStack.push(group)
      spanStack.push(style)
      prefix += style
    })

    return prefix + suffix
  };

  return stream
};

module.exports = createStream
module.exports.createStream = module.exports
