# map-async

Asynchronously map over a list

## Example

``` js
var map = require("map-async")

map({
    foo: "bar"
    , baz: "boz"
}, function iterator(value, key, cb) {
    return value + value
}, function finish(err, result) {
    /* ... */
})
```

## Installation

`npm install map-async`

## Contributors

 - Raynos

## MIT Licenced
