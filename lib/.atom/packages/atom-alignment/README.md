# atom-alignment package

[Atom package](https://atom.io/packages/atom-alignment)

> Inspired by sublime text plugin ([sublime_alignment](https://github.com/wbond/sublime_alignment))


## Usage

A simple key-binding for aligning multi-line and multiple selections in Atom.

use `ctrl+cmd+a` (like sublime text)

```javascript
var a = b;
var ab = c;
var abcd = d;
var ddddd =d;
```

```javascript
var a     = b;
var ab    = c;
var abcd  = d;
var ddddd = d;
```

On multiple range line

```javascript
var a = b;
var ab = c;
var notMePlease='NOOOO';
var abcd = d;
var ddddd =d;
```

```javascript
var a     = b;
var ab    = c;
var notMePlease='NOOOO';
var abcd  = d;
var ddddd = d;
```

## License

MIT © [Simon Paitrault](http://www.freyskeyd.fr)
