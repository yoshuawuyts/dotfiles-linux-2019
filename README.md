# Dotfiles
Dotfiles and provisioner for OS X.

Installs [brew formulae][brewfile], [OS X applications][caskfile] and
sets up sensible defaults.

## Installation
Paste this snippet in `terminal.app`:
```bash
cd ~/ && \
git clone https://github.com/yoshuawuyts/dotfiles.git && \
cd dotfiles && \
source ./setup/index.sh
```

## License
[MIT](https://tldrlegal.com/license/mit-license) ©
[Yoshua Wuyts](yoshuawuyts.com)

[brewfile]: https://github.com/yoshuawuyts/dotfiles/blob/master/.setup/Brewfile
[caskfile]: https://github.com/yoshuawuyts/dotfiles/blob/master/.setup/Caskfile
