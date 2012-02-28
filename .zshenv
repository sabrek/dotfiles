#!/bin/zsh

# Sabr's ZSH Env setup
# 30-01-2010 15:01
#

ZDOTDIR=~/.dotfiles

export X11HOME=/usr/X11

path=(~/bin .)
path=($path /bin /usr/bin /usr/sbin /sbin)
path=($path $X11HOME/bin /usr/local/bin)
path=($path /usr/local/Cellar/ruby/1.9.3-p0/bin)

