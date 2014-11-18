# Dotfiles
Dotfiles and provisioner for OS X.

Version controlled dotfiles. Symlinks the dotfiles from the repository into
root, installs applications and configures the OS, all from one command.

## Installation
```sh
git clone https://github.com/yoshuawuyts/dotfiles.git Repositories/yoshua/dotfiles
```

## Usage
```
Usage:

  make [command]

Commands:

  all                    :install
  install                Install all the things
  help                   Display help
```

## See also
- [mathiasbynens/dotfiles][mathias]
- [kevensuttle/osxdefaults][osx]

## License
[MIT](https://tldrlegal.com/license/mit-license)

[brewfile]: https://github.com/yoshuawuyts/dotfiles/blob/master/.setup/Brewfile
[caskfile]: https://github.com/yoshuawuyts/dotfiles/blob/master/.setup/Caskfile
[mathias]: https://github.com/mathiasbynens/dotfiles
[osx]: https://github.com/kevinSuttle/OSXDefaults/blob/master/.osx
