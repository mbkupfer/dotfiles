# If you come from bash you might have to change your $PATH.
export PATH=$HOME/.local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="ys"
# ZSH_THEME="random"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    vi-mode 
    tmux
    pylint
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Hook for direnv
eval "$(direnv hook zsh)"

# run-help setup
unalias run-help 2> /dev/null
autoload run-help

#######################################################################
#                              functions                              #
#######################################################################

############
#  python  #
############

function venv() {
    source venv/bin/activate
}

############
#  Heroku  #
############

# Push current branch to heroku deployment
function hk_push() {
    git push heroku $(git_current_branch):master
}

##########
#  misc  #
##########

# add grep for alias searching since regex is more flexibly
# than the pattern matching approach.
function alias_grep() {
    builtin alias | grep $1
}

# password generator
function strongpw() {
    read  -s 'key?Encryption key: '
    echo '' # line break
    echo -n $(echo -n "$key:$1" \
        | shasum -a 256 \
        | perl -ne "s/([0-9a-f]{2})/print chr hex \$1/gie" \
        | base64 \
        | tr +/ Ea \
        | cut -b 1-${2-20}) \
        | clip.exe
}

function klsof() {
    kill $(lsof -ti :$1)
}

#######################################################################
#                               aliases                               #
#######################################################################

alias gstat="git diff --stat | cat"
alias gci="git commit -v"
alias gcia="git commit -v --amend"
alias hk="heroku"
alias so="source"
# get ls the way I like it
alias ls='\ls -l --color=auto'
alias ldot="\ls -ald .* --color=auto"
alias zshconfig="$EDITOR ~/.zshrc && source ~/.zshrc"
alias da="direnv allow"
alias python="python3"
alias pip="pip3"
alias du='du -hd 0'

####################
#  autocompletion  #
####################

autoload -U bashcompinit
bashcompinit

test -e "${HOME}/.local/share/env" && source "${HOME}/.local/share/env"


########################
#  Fuzzy finder setup  #
########################

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

###########################################################################
# allow $USER to use keys. Only enter once and it will remain enabled till
# you delete it or reboot the server 
###########################################################################
/usr/bin/keychain -q $HOME/.ssh/id_rsa
source $HOME/.keychain/$HOST-sh

