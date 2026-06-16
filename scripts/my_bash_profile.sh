#!/bin/bash
#

# create commonly used folders
[ -d "$HOME/.tmp" ] || mkdir $HOME/.tmp
[ -d "$HOME/.tmp/vimundo" ] || mkdir $HOME/.tmp/vimundo
[ -d "$HOME/.tmp/vimswap" ] || mkdir $HOME/.tmp/vimswap
[ -d "$HOME/.tmp/vimbackup" ] || mkdir $HOME/.tmp/vimbackup
[ -d "$HOME/src" ] || mkdir $HOME/src
[ -d "$HOME/bin" ] || mkdir $HOME/bin
[ -d "$HOME/tmp" ] || mkdir $HOME/tmp
[ -d "$HOME/workspace" ] || mkdir $HOME/workspace

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	    . "$HOME/.bashrc"
    fi
fi

