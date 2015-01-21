
# Oh-my-zsh.
ZSH_THEME="pure"
plugins=(git)
export ZSH=$HOME/.oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/base16-tomorrow-night-eighties.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

# Imports.
source ~/.exports.sh
source ~/.aliases.sh

# Version managers.
source $(brew --prefix nvm)/nvm.sh
source ~/.rvm/scripts/rvm
