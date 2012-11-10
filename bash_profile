export EDITOR='subl -w'
export CLICOLOR=1
force_color_prompt=yes

HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# sudo locale-gen tr_TR.UTF-8 for the following to work!
export LANG="tr_TR.UTF-8"
export LC_COLLATE="tr_TR.UTF-8"
export LC_CTYPE="tr_TR.UTF-8"
export LC_MESSAGES="tr_TR.UTF-8"
export LC_MONETARY="tr_TR.UTF-8"
export LC_NUMERIC="tr_TR.UTF-8"
export LC_TIME="tr_TR.UTF-8"

export WORKON_HOME=~/.virtualenvs

# in case of using virtualenv
# source /usr/local/bin/virtualenvwrapper.sh
source ~/.dotfiles/git-completion.bash
source ~/.dotfiles/profile
source ~/.dotfiles/paths
source ~/.dotfiles/aliases

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi