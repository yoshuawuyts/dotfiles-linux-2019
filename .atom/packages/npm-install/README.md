# npm-install [![Flattr this!](https://api.flattr.com/button/flattr-badge-large.png)](https://flattr.com/submit/auto?user_id=hughskennedy&url=http://github.com/hughsk/npm-install&title=npm-install&description=hughsk/npm-install%20on%20GitHub&language=en_GB&tags=flattr,github,javascript&category=software)[![experimental](http://hughsk.github.io/stability-badges/dist/experimental.svg)](http://github.com/hughsk/stability-badges) #

Automatically install and save any missing npm modules being used in the current file.

![Imgur](http://i.imgur.com/yH6kdSq.gif)

Uses [detective](http://github.com/substack/node-detective) to analyse the current file for require calls, installing and saving any that aren't already in the project's `package.json` file.

## Usage ##

Open the Command Palette, and type `npm install` if you're in a JavaScript or CoffeeScript file.

## License ##

MIT. See [LICENSE.md](http://github.com/hughsk/npm-install/blob/master/LICENSE.md) for details.
