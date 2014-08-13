# ansi-html-stream [![Build Status](https://secure.travis-ci.org/hughsk/ansi-html-stream.png?branch=master)](http://travis-ci.org/hughsk/ansi-html-stream)

A through-stream that converts terminal output to HTML.

## Installation

``` bash
$ npm install ansi-html-stream
```

Or, if you want to install the CLI tool:

``` bash
$ [sudo] npm install -g ansi-html-stream
```

## Usage

Take this example to pipe a log of NPM's `install` command to an HTML file:

``` bash
$ npm install browserify --color always 2&>1 | ansi-html > browserify.html
```

And an equivalent from Node:

``` javascript
var spawn = require('child_process').spawn
  , ansi = require('ansi-html-stream')
  , fs = require('fs')

var npm = spawn('npm', ['install', 'browserify', '--color', 'always'], {
    cwd: process.cwd()
})

var stream = ansi({ chunked: false })
  , file = fs.createWriteStream('browserify.html', 'utf8')

npm.stdout.pipe(stream)
npm.stderr.pipe(stream)

stream.pipe(file, { end: false })

stream.once('end', function() {
  file.end('</pre>\n')
})

file.write('<pre>\n');
```

There are a few options you can pass to the stream too:

* `classes`: Use classes instead of inline styles for formatting.
* `theme`: Override the styling for particular ANSI codes. See [`colors.js`](http://github.com/hughsk/ansi-html-stream/blob/master/colors.js) for two examples.
* `chunked`: Ensure that each chunk's elements are self-contained - closes any open `<span>`s at the end and reopens them on the next chunk. Defaults to false.
