module.exports = function(modules) {
  function Keyword(name) {
    if (!(this instanceof Keyword)) return new Keyword(name)
    this.name = name
  }

  Keyword.prototype.count = function(options, callback) {
    return modules.get('_design/app/_view/byKeyword', {
        group_level: 1
      , startkey: [this.name]
      , endkey: [this.name, {}]
    }, callback)
  }
  Keyword.prototype.count.select = ['rows', true, 'value']
  Keyword.prototype.count.single = true

  Keyword.prototype.list = function(options, callback) {
    return modules.get('_design/app/_view/byKeyword', {
        group_level: 2
      , startkey: [this.name]
      , endkey: [this.name, {}]
    })
  }
  Keyword.prototype.list.select = ['rows', true]
  Keyword.prototype.list.map = function(row) {
    return row.key[1]
  }

  return Keyword
}