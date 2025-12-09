# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000000
HISTFILESIZE=200000000


# make less more friendly for non-text input files, see lesspipe(1)
# Check if the file at /usr/bin/lesspipe is executable ?? if yes then eval(lesspipe) so as to automatically open long files in less
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Shopts

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# if set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar
shopt -s extglob

# custom paths to append to the $path
PATHS=(
  "~/bin"
  "~/.local/bin"
  $PATH
)

# exports 
export PATH=$(IFS=:; echo "${PATHS[*]}")
export PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[01;32m\] $\[\033[00m\] '
export EDITOR=nvim
export VISUAL=nvim
export MANPAGER="nvim +Man!"
export TZ=Asia/Kolkata

if [[ -n "$SSH_CONNECTION" ]]; then
  export PS1='\[\033[32m\]\u@\h\[\033[33m(SSH)\[\033[00m\]:\[\033[34m\]\w\[\033[01;32m\] $\[\033[00m\] '
else
  export PS1='\[\033[32m\]\u@\h\[\033[00m\]:\[\033[34m\]\w\[\033[32m\] $\[\033[00m\] '
fi


# keybinds
bind 'C-xC-e: edit-and-execute-command'

# node version manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# ctrl+backspace to delete whole word
stty werase \^H

# for homebrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

eval "$(fzf --bash)"
