module.exports = function(modules, downloads, users, mainopts) {
  function Registry() {
    if (!(this instanceof Registry)) return new Registry(name)
  }

  Registry.prototype.list = function(options, callback) {
    return modules.get('_design/app/_view/browseAll', {
      group_level: 1
    }, callback)
  }
  Registry.prototype.list.select = ['rows', true, 'key', '0']

  Registry.prototype.listByDate = function(options, callback) {
    var params = {}

    if (options.since && typeof options.since !== 'string')
      params.startkey = new Date(+options.since)
    if (options.until && typeof options.until !== 'string')
      params.endkey   = new Date(+options.until)

    return modules.get('_design/app/_view/updated', params, callback)
  }
  Registry.prototype.listByDate.select = ['rows', true]
  Registry.prototype.listByDate.map = function(row) {
    return { name: row.id, date: row.key }
  }

  return Registry
}
