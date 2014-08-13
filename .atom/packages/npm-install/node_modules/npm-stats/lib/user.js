module.exports = function(module, downloads, users, mainopts) {
  function User(name) {
    if (!(this instanceof User)) return new User(name)
    this.name = name
    this.key = 'org.couchdb.user:' + this.name
  }

  User.prototype.count = function(options, callback) {
    return module.get('_design/app/_view/npmTop', {
        group_level: 1
      , startkey: [this.name]
      , endkey: [this.name, {}]
    }, callback)
  }
  User.prototype.count.select = ['rows', true, 'value']
  User.prototype.count.single = true

  User.prototype.list = function(options, callback) {
    return module.get('_design/app/_view/byUser', {
        startkey: this.name
      , endkey: this.name
    })
  }
  User.prototype.list.select = ['rows', true]
  User.prototype.list.map = function(row) {
    return row.value
  }

  User.prototype.starred = function(options, callback) {
    return module.get('_design/app/_view/starredByUser', {
        startkey: this.name
      , endkey: this.name
    })
  }
  User.prototype.starred.select = ['rows', true]
  User.prototype.starred.map = function(row) {
    return row.value
  }

  User.prototype.info = function(options, callback) {
    return users.get('org.couchdb.user:' + this.name, callback)
  }

  return User
}
