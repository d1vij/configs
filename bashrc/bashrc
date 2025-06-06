# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, overwrite the one in /etc/bash.bashrc)
#PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '

# Commented out, but if you want a color prompt, uncomment below
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]⮞ divij@ubuntu\[\033[00m\]:\[\033[01;34m\]\w\[\033[01;32m\] $\[\033[00m\] '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@ubuntu: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

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

# Bash Command Timer v1.5.0

BCT_ENABLE=1
BCT_SUCCESS_COLOR='33' # yellow
BCT_ERROR_COLOR='33'   # yellow
BCT_TIME_FORMAT='%b %d %I:%M%p'
BCT_MILLIS=1
BCT_WRAP=0

if date +'%N' | grep -qv 'N'; then
        BCTTime="date '+%s%N'"
        BCTPrintTime() { date --date="@$1" +"$BCT_TIME_FORMAT"; }
elif hash gdate 2>/dev/null && gdate +'%N' | grep -qv 'N'; then
        BCTTime="gdate '+%s%N'"
        BCTPrintTime() { gdate --date="@$1" +"$BCT_TIME_FORMAT"; }
elif hash perl 2>/dev/null; then
        BCTTime="perl -MTime::HiRes -e 'printf(\"%d\",Time::HiRes::time()*1000000000)'"
        BCTPrintTime() { date -r "$1" +"$BCT_TIME_FORMAT"; }
else
        echo 'No compatible date/gdate/perl found, aborting'
        exit 1
fi

BCT_AT_PROMPT=1
BCT_FIRST_PROMPT=1

BCTPreCommand() {
        local EXIT="$?"
        BCT_COLOR=$([ "$EXIT" -eq 0 ] && echo "$BCT_SUCCESS_COLOR" || echo "$BCT_ERROR_COLOR")
        [ -n "$BCT_AT_PROMPT" ] || return
        unset BCT_AT_PROMPT
        BCT_COMMAND_START_TIME=$(eval "$BCTTime")
}

BCTPostCommand() {
        BCT_AT_PROMPT=1
        [ -n "$BCT_FIRST_PROMPT" ] && unset BCT_FIRST_PROMPT && return
        [ "$BCT_ENABLE" -eq 1 ] || return

        local MSEC=1000000
        local SEC=$((MSEC * 1000))
        local MIN=$((60 * SEC))
        local HOUR=$((60 * MIN))
        local DAY=$((24 * HOUR))

        local start=$BCT_COMMAND_START_TIME
        local end=$(eval "$BCTTime")
        local elapsed=$((end - start))
        local d=$((elapsed / DAY))
        local h=$((elapsed % DAY / HOUR))
        local m=$((elapsed % HOUR / MIN))
        local s=$((elapsed % MIN / SEC))
        local ms=$((elapsed % SEC / MSEC))
        local str=""
        [ $d -gt 0 ] && str+="${d}d "
        [ $h -gt 0 ] && str+="${h}h "
        [ $m -gt 0 ] && str+="${m}m "
        if [ "$BCT_MILLIS" -eq 1 ]; then
                ms=$(printf '%03d' "$ms")
        else
                ms=""
        fi
        str+="${s}s${ms}"

        local now=$(BCTPrintTime $((end / SEC)))
        local output="[ $str | $now ]"
        if [ -n "$BCT_COLOR" ]; then
                output_colored="\033[${BCT_COLOR}m$output\033[0m"
        else
                output_colored="$output"
        fi

        local output_len=${#output}
        local total_len=$COLUMNS
        local filler_len=$((total_len - output_len))
        local filler="----"
        local repeated_filler=""
        while [ ${#repeated_filler} -lt $filler_len ]; do
                repeated_filler+="$filler"
        done
        repeated_filler=${repeated_filler:0:$filler_len}

        # Grey color for the filler line
        local GREY='\033[90m'
        local RESET='\033[0m'
        echo -e "${GREY}${repeated_filler}${output_colored}${RESET}"
}

trap 'BCTPreCommand' DEBUG
PROMPT_COMMAND='BCTPostCommand'

export DOTNET_ROOT=$HOME/.dotnet8
export PATH=$DOTNET_ROOT:$PATH
sudo service ssh start
