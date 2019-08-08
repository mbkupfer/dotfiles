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

