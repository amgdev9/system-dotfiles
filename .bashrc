source /usr/share/git/completion/git-prompt.sh
export PATH=$PATH:$HOME/Scripts

alias ls="ls --color"

PS1="\[\033[1;34m\]\W\$(__git_ps1 '\[\033[1;32m\]:git(\[\033[1;31m\]%s\[\033[1;32m\])')\[\033[1;0m\] > "
