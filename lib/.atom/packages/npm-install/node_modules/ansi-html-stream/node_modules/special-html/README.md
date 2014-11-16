# special-html

Converts special UTF-8 characters in a string to their HTML escape code equivalents.

## Installation

``` javascript
$ npm install special-html
```

## Usage

``` javascript
var special = require('special-html')
  , original = '├── http-browserify@0.1.6 (concat-stream@0.0.8)'

console.log(special(original))
// &#9500;&#9472;&#9472; http-browserify@0.1.6 (concat-stream@0.0.8)
```
