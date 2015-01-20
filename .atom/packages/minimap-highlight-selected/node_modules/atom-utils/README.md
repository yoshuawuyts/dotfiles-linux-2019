## atom-utils

A bunch of general purpose utilities for Atom packages.

### requirePackages

Returns a promise that is only resolved when all the requested packages have been activated.

```coffee
{requirePackages} = require 'atom-utils'

requirePackages('tree-view', 'find-and-replace', 'snippets')
.then ([treeView, findAndReplace, snippets]) ->
  # Do something with the required packages
```
