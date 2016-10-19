# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
. ~/.bash_aliases.sh

export EDITOR=vim
export PAGER=less
export LESS=MeqiwR

# If running interactively, then:
if [ "$PS1" ]; then
#  mesg n
  PS1="[\u@\h:\w]\$ "
fi

# perform a listing by pressing the ctrl-a anytime
#bind -x '"\C-A":"ll"'
# Ctrl-L: clear screen
#bind -m vi-insert 'Control-l: clear-screen'

# ensure history file updates do appends rather than overwrites
shopt -s histappend

# Colour output of wcgrep
export WCGREP_GREPARGS="-HnI --color"

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

# RVM - for ruby installation/management
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# Rapid7 customisation
. ~/.bash_rapid7

# gitify the prompt
GIT_PROMPT_ONLY_IN_REPO=1
#GIT_PROMPT_END_USER="\n\[\033[0;37m\]$(date +%H:%M)\[\033[0;0m\] $"
GIT_PROMPT_END_USER="\n\[\033[0;37m\]$PS1\[\033[0;0m\]"
. ~/src/bash-git-prompt/gitprompt.sh

export PATH=$PATH:$HOME/bin

# perlbrew for PT stuff
#source ~/perl5/perlbrew/etc/bashrc


export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting