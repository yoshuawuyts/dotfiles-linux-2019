# npm-stats #

Convenience module for getting back data from an NPM registry.
All of the methods return a JSON stream, and/or take a callback.
Where specified, some methods take an optional options object as well.

## API ##

**registry = require('npm-stats')([url, options])**

Returns a new registry instance,
defaulting to [isaacs.iriscouch.com](https://isaacs.iriscouch.com/).

Options:

* `dirty`: pass this as true to disable data cleaning, instead getting
  the raw data direct from NPM's CouchDB.
* `modules`: the database to use for retrieving modules. Defaults
  to "registry".
* `downloads`: the database to use for retrieving download data. Defaults
  to "downloads".
* `users`: the database to use for retrieving users. Defaults to "users".

**registry.list()**

Returns an array containing every module currently in the chosen NPM registry.

**registry.listByDate(options)**

Get a list of each module in the chosen NPM registry, sorted by date last
updated, in ascending order.

You can also pass the following options:

* `since`: only include modules updated since this date.
* `until`: only include modules updated before this date.

### Keywords ###

**registry.keyword(name).count()**

Get the number of modules using a specific keyword.

**registry.keyword(name).list()**

Get a list of modules using a specific keyword.

### Users ###

**registry.user(name).count()**

Get the number of modules a user has authored.

**registry.user(name).list()**

Get a list of the modules a user has authored.

**registry.user(name).starred()**

Get a list of the modules a user has starred.

### Modules ###

**registry.module(name).info()**

Returns the data normally accessible from
`https://registry.npmjs.org/:pkg`.

**registry.module(name).downloads()**

Returns a list of download counts for the module, by date, e.g.:

``` json
[
  { "date": "2012-12-10", "value": 64 },
  { "date": "2012-12-11", "value": 82 }
]
```

Days without a download are omitted. Options:

* `since`: The earliest date to return download info from.
* `until`: The latest date to return download info from.

**registry.module(name).stars()**

Returns a list of the users who have starred a module.

**registry.module(name).latest()**

Returns the latest `package.json` file for a module.

**registry.module(name).field(name, [callback])**

Returns a field from the latest `package.json` file for a module.

**registry.module(name).size()**

Returns data on the module's size, e.g.

``` json
{
  "_id": "browserify",
  "size": 26338241,
  "count": 179,
  "avg": 147141.01117318432
}
```
