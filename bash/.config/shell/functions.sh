#!/usr/bin/env bash

# make and cd into a directory as same time
mkcdir(){
  mkdir -p -- "$1" &&
    cd -P -- "$1"
}


# strong password generator
strongpw() {
    read -rs -p 'Encryption key: ' key
    echo '' # line break
    echo -n "$key:$1" | shasum -a 256 | perl -ne "s/([0-9a-f]{2})/print chr hex \$1/gie" | base64 | tr +/ Ea | cut -b 1-20
}


# man commands
# http://scriptingosx.com/2017/04/on-viewing-man-pages/

preman() {
  man -t $1 | open -f -a "Preview"
}

xmanpage() {
	open x-man-page://$@
}

# Open profile and then source file
edit_profile(){
  vim ~/.bashrc && source $_
}

##########################################
#  PYTHON VIRTUAL ENVIRONMENT FUNCTIONS  #
##########################################

_deactivate_venv() {
    if [[ -n "$VIRTUAL_ENV" ]]; then
        deactivate
    fi
    if [[ -n $TMUX ]]; then
        tmux set-environment -u VIRTUAL_ENV
    fi
}

venv() {
    case $1 in
        "")
            source venv/bin/activate
            if [[ -n $TMUX ]]; then
                tmux set-environment VIRTUAL_ENV "$VIRTUAL_ENV"
            fi
        ;;
        create)
            python3 -m virtualenv venv
            venv
        ;;
        deactivate)
             _deactivate_venv
        ;;
        delete)
            _deactivate_venv
            rm -rf venv/
        ;;
    esac
}


######################################
#  Virtual environment aware python  #
######################################

pip() {

    if [[ -n "$VIRTUAL_ENV" ]]; then
        "$VIRTUAL_ENV"/bin/pip "$@";
    else pip "$@";
    fi
}

python() {
    if [[ -n "$VIRTUAL_ENV" ]]; then
        "$VIRTUAL_ENV"/bin/python "$@";
    else python "$@";
    fi
}

###################
#  Documentation  #
###################

docs() {
    case $1 in
        "python")
            py_ver="$(python3 --version | grep -o '\d\.\d')"
            open /Library/Frameworks/Python.framework/Versions/$py_ver/Resources/English.lproj/Documentation/index.html
        ;;
    esac
}

#######################################
#  Force dock not to bounce on MacOS  #
#######################################

no_bouncing(){
    defaults write com.apple.Dock "no-bouncing" -bool TRUE
    killall Dock
}
