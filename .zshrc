#
# Imports.
#

source ~/.exports
source ~/.aliases

#
# Version managers
#

source /Users/yoshuawuyts/.gvm/scripts/gvm
source ~/.rvm/scripts/rvm
source ~/.nvm/nvm.sh

#
# Oh-my-zsh.
#

ZSH_THEME="pure"
plugins=(git)
export ZSH=$HOME/.oh-my-zsh
source $ZSH/oh-my-zsh.sh