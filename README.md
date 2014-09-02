# Dotfiles
Dotfiles and provisioner for OS X.

Installs [brew formulae][brewfile], [OS X applications][caskfile] and
sets up sensible defaults.

## Installation
Paste this snippet in `terminal.app`:
```bash
cd ~/ && \
git clone https://github.com/yoshuawuyts/dotfiles.git && \
mv ./dotfiles/** ~/ && \
mv ./dotfiles.* ~/ && \
sh ./.setup/index.sh
```

## Resources
- [mathiasbynens/dotfiles][mathias]
- [kevensuttle/osxdefaults][osx]

## License
[MIT](https://tldrlegal.com/license/mit-license) ©
[Yoshua Wuyts](yoshuawuyts.com)

[brewfile]: https://github.com/yoshuawuyts/dotfiles/blob/master/.setup/Brewfile
[caskfile]: https://github.com/yoshuawuyts/dotfiles/blob/master/.setup/Caskfile
[mathias]: https://github.com/mathiasbynens/dotfiles
[osx]: https://github.com/kevinSuttle/OSXDefaults/blob/master/.osx
