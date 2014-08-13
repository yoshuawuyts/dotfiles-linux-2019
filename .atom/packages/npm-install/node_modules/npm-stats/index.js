var es = require('event-stream')
  , jsonstream = require('JSONStream')

function passthrough(data) {
  return data
}

var stats = module.exports = function(registry, mainopts) {
  mainopts = mainopts || {}

  var nano = require('nano')(registry || 'http://isaacs.iriscouch.com/')
    , modules = nano.db.use(mainopts.modules || 'registry')
    , downloads = nano.db.use(mainopts.downloads || 'downloads')
    , users = nano.db.use(mainopts.users || 'public_users')

  var Keyword = require('./lib/keyword')(modules, downloads, users, mainopts)
    , Module = require('./lib/module')(modules, downloads, users, mainopts)
    , User = require('./lib/user')(modules, downloads, users, mainopts)
    , Registry = require('./lib/registry')(modules, downloads, users, mainopts)

  function modifier(method) {
    return function(options, callback) {
      options = options || {}

      if (typeof options === 'string') {
        options = { string: options }
      }
      if (typeof options === 'function') {
        callback = options
        options = {}
      }

      if (!method.select || mainopts.dirty) {
        return method.call(this, options, callback)
      }

      var buffer = ''
      var write = callback ? function write(data) {
        buffer += data
        this.queue(data)
      } : function(data) {
        this.queue(data)
      }

      var stream = es.pipeline(
          method.call(this, options)
        , jsonstream.parse(method.select)
        , es.mapSync(method.map || passthrough)
        , method.single
          ? es.stringify()
          : jsonstream.stringify('[', ',', ']')
        , es.through(write, end)
      )

      if (callback) stream.on('error', callback)

      function end() {
        var self = this

        if (callback) {
          try {
            callback(null, JSON.parse(buffer))
          } catch(e) {
            callback(e)
          }
          return
        }

        this.queue(null)
      }

      return stream
    }
  }

  ;[Registry, Keyword, User, Module].forEach(function(model) {
    Object.keys(model.prototype).forEach(function(name) {
      var method = model.prototype[name]

      model.prototype[name] = modifier(model.prototype[name])
    })
  })

  var registry = new Registry

  registry.user = User
  registry.module = Module
  registry.keyword = Keyword

  return registry
}
