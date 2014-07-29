# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="pure"
#autoload -U promptinit && promptinit
#prompt pure
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to disable command auto-correction.
# DISABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh
source /Users/yoshuawuyts/.gvm/scripts/gvm

# User configuration

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

[ -s "/Users/yoshuawuyts/.nvm/nvm.sh" ] && . "/Users/yoshuawuyts/.nvm/nvm.sh" # This loads nvm

# List files with details
alias ls='gls -ohppgn --color=auto --group-directories-first'
alias l='ls -G'

# List all files
alias la='ls -ApC'

# Remove files
alias rm='rm -rf'

# Git stuff {
  alias add='git add'
  alias branch='git branch --color'
  alias branchd='git branch -d'
  alias checkout='git checkout -q'
  alias clean='git branch --merged | xargs git branch -d'
  alias clone='git clone -q'
  alias commit='git commit'
  alias diff='git diff --word-diff'
  alias log='git log --color --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'
  alias merge='git merge'
  alias pull='git pull --rebase'
  alias push='git push -q --tags && git push -q'
  alias rebase='git rebase -i'
  alias status='git status -s'
  alias s='status'
# }

# httpster
alias httpster='httpster -p 1337'
alias h='httpster'

#gulp
alias g='gulp'

#android
export ANDROID_HOME=/opt/android-sdk/sdk
export PATH=$ANDROID_HOME/tools:$PATH
export PATH=$ANDROID_HOME/platform-tools:$PATH
export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64
export PATH=$PATH:/usr/lib/jvm/java-6-openjdk/bin

alias avd='android avd'

# tree command
alias t='tree -a -L 3 -A -C -I "node_modules|.git"'
alias ts='t -d'

# Node module shortcuts
alias pkg='pkg-name'

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

alias shs='sudo python -m SimpleHTTPServer'
