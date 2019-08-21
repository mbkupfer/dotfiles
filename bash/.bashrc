# this file is sourced by non-login interactive shells and ~/.bash_profile

## XDG config
if [[ ! -x "$XDG_CONFIG_HOME" ]]; then
    shell_config="$HOME/.config/shell"
else
    shell_config="$XDG_CONFIG_HOME/shell"
fi

if [[ ! -x "$shell_config" ]]; then
    mkdir -p "$shell_config"
fi

## XDG data
if [[ ! -x "$XDG_DATA_HOME" ]]; then
    shell_data="$HOME/.local/share/shell"
else
    shell_data="$XDG_DATA_HOME/shell"
fi

if [[ ! -x "$shell_data" ]]; then
    mkdir -p "$shell_data"
fi

# path setup
source "$shell_config/path-edit.sh"
path_front /sbin /usr/sbin /usr/local/sbin /usr/local/bin /usr/bin /bin ~/bin
path_back /Library/Frameworks/Python.framework/Versions/3.7/bin/ 

# completion setup
source "$shell_config/git-completion.bash"
source "$shell_config/tmux.sh"

# cd options
shopt -s cdspell
if ((BASH_VERSINFO >= 4)); then
    shopt -s autocd dirspell
fi

# glob options
shopt -s dotglob extglob nocaseglob
if ((BASH_VERSINFO >= 4)); then
    shopt -s globstar
fi

# job options
shopt -s huponexit
if ((BASH_VERSINFO >= 4)); then
    shopt -s checkjobs
fi

# shell options
shopt -s checkhash checkwinsize

# history
shopt -s cmdhist histappend histverify

HISTCONTROL=ignoreboth
# Unset for unlimited history
HISTSIZE=
HISTFILESIZE=
# Use separate history file to avoid truncation
HISTFILE="$shell_data/bash_history"

# environment varaibles
source "$shell_config/environ.sh"

# prompt setup
source "$shell_config/git-prompt.sh"
PROMPT_DIRTRIM=2

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWCOLORHINTS=1
GIT_PS1_SHOWUPSTREAM=auto

set_prompt () {
    local last_command=$?
    PS1=' '

    # save after every command
    history -a

    # color escape codes
    local color_off='\[\e[0m\]'
    local color_red='\[\e[0;31m\]'
    local color_green='\[\e[0;32m\]'
    local color_yellow='\[\e[0;33m\]'
    local color_blue='\[\e[0;34m\]'
    local color_purple='\[\e[0;35m\]'
    local color_cyan='\[\e[0;36m\]'

    # add purple exit code if non-zero
    if [[ $last_command != 0 ]]; then
        PS1+=$color_purple
        PS1+='$? '
        PS1+=$color_off
    fi

    PS1+="m@ksim "
    # shortened working directory
    PS1+='\w '
    PS1+=$color_green

    # add Git status with color hints
    PS1+="$(__git_ps1 '%s ')"
    PS1+=$color_off
    PS1+="$ "
}
PROMPT_COMMAND='set_prompt'

# aliases
source "$shell_config/aliases.sh"


# disable flow control so C-s and C-q work
if [[ -t 1 ]]; then
    stty -ixon -ixoff
fi

# source local configurations
if [[ -r "$shell_config/local.sh" ]]; then
    source "$shell_config/local.sh"
fi


# Manualy disable bouncing in defualts as this
# keeps getting re-enabled for some reason.
if [[ -f "$shell_config/no-bouncing.sh" ]]; then
    source "$shell_config/no-bouncing.sh"
fi
