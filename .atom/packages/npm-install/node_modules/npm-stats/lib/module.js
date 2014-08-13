function leading(n, d) {
  d = d || 2
  n += ''
  while (n.length < d) n = "0" + n
  return n
}

function ymd(date) {
  date = new Date(date)
  return [date.getFullYear(), leading(date.getMonth() + 1), leading(date.getDate())].join('-')
}

module.exports = function(modules, downloads, users, mainopts) {
  function Module(name) {
    if (!(this instanceof Module)) return new Module(name)
    this.name = name
  }

  Module.prototype.info = function(options, callback) {
    return modules.get(this.name, callback)
  }

  Module.prototype.downloads = function(options, callback) {
    options.since = options.since ? ymd(options.since) : "2000"
    options.until = options.until ? ymd(options.until) : "3000"

    return downloads.get('_design/app/_view/pkg', {
        group_level: 3
      , startkey: [this.name, options.since]
      , endkey: [this.name, options.until]
    }, callback)
  }
  Module.prototype.downloads.select = ['rows', true]
  Module.prototype.downloads.map = function(row) {
    return { date: row.key[1], value: row.value }
  }

  Module.prototype.totalDownloads = function(options, callback) {
    return downloads.get('_design/app/_view/pkg', {
        group_level: 1
      , startkey: [this.name]
      , endkey: [this.name, {}]
    }, callback)
  }
  Module.prototype.totalDownloads.select = ['rows']
  Module.prototype.totalDownloads.single = true
  Module.prototype.totalDownloads.map = function(row) {
    return (row && row[0] && row[0].value) || 0
  }

  Module.prototype.stars = function(options, callback) {
    return modules.get('_design/app/_view/starredByPackage', {
      startkey: this.name
      , endkey: this.name
    }, callback)
  }
  Module.prototype.stars.select = ['rows', true, 'value']

  Module.prototype.latest = function(options, callback) {
    return modules.get('_design/app/_view/byField', {
      key: this.name
    }, callback)
  }
  Module.prototype.latest.select = ['rows', true, 'value']
  Module.prototype.latest.single = true

  Module.prototype.field = function(options, callback) {
    var field = options.field || options.string

    return modules.get('_design/app/_list/byField/byField', {
        field: field
      , key: this.name
    }, callback)
  }

  Module.prototype.size = function(options, callback) {
    return modules.get('_design/app/_view/howBigIsYourPackage', {
      key: this.name
    }, callback)
  }
  Module.prototype.size.select = ['rows', true, 'value']
  Module.prototype.size.single = true

  Module.prototype.dependents = function(options, callback) {
    return modules.get('_design/app/_view/dependedUpon', {
        group_level: 2
      , startkey: [this.name]
      , endkey: [this.name, {}]
    }, callback)
  }
  Module.prototype.dependents.select = ['rows', true, 'key']
  Module.prototype.dependents.map = function(row) {
    return row[1]
  }

  return Module
}