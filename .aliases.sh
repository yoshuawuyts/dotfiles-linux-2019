
# Core utils.
alias la='gls -ohpgn --color=auto --group-directories-first -o'
alias rmrf='rm -rf'
alias t='tree -a -L 3 -A -C -I "node_modules|.git"'

# Git.
alias git branch='git branch --color'
alias git checkout='git checkout -q'
alias git clean='git branch --merged | xargs git branch -d'
alias git diff='git diff --patch-with-stat --color=always --word-diff=color'
alias glog='git log --color --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'
alias git pull='git pull --rebase'
alias git push='git push -q --tags && git push -q'
alias git rebase='git rebase -i'
alias git status='git status -s'
alias s='status'

# Node utils.
alias pkg='pkg-name'

# Applications
alias vlc='~/Applications/VLC.app/Contents/MacOS/VLC'

# Tmux
alias tmux="TERM=screen-256color-bce tmux -u2"
