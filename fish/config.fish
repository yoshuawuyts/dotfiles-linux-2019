fish_vi_key_bindings

# Set PATH
if test "$MANPATH" = ""
  set -gx MANPATH (manpath)
end
set -gx PATH /usr/share/bcc/tools/ /usr/share/bcc/tools/lib/ $PATH
set -gx MANPATH /usr/share/bcc/man/man8 $MANPATH

# Aliases
alias git='hub'
alias g='git'
alias gh='hub browse'
alias ls='ls --color=auto --group-directories-first'
alias ll='ls -alph --color=auto --group-directories-first'
alias s='git status --short'
