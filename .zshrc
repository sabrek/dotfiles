# ZShell configuration file
# Jacek Karolak (j.karolak@sabr.pl)

# ENV Vars
export EDITOR='mvim -p -f -c "au VimLeave * opendiff -a Terminal"'
export PYTHONPATH='/Users/Sabr/python/:/Users/Sabr/play/django/pdp:/Users/Sabr/play/django/pdp2'
export PYTHONSTARTUP=$ZDOTDIR'/.pythonrc.py'

# VirtualEnvWrapper
# =======
export WORKON_HOME=~/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh


# History
# =======

HISTSIZE=1000
SAVEHIST=1000
HISTFILE=$ZDOTDIR/.zhistory
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS

# Aliases
# =======

##
# cd
##
alias -r .='cd ..'
alias -r ..='cd ..'
alias -r ...='cd ..'
alias -r cd..='cd ..'
alias -r cd...='cd ..'
alias -r ~='cd ~'
alias -r c='cd '

##
# ls
##
alias -r l='ls'
alias -r la='ls -al'
alias -r l.='ls -a|grep "^\.[^\.]"' #list 'dot' files
alias -r l@='ls -F|grep "\>@"' #list links
alias -r l/='ls -F|grep "\>/"' #list with grep 

##
# misc
##
alias -r m='mkdir -p'
alias -r cls='clear'
alias -r g='git'
alias -r e='mvim -p'
alias -r h='history|less'
alias -r p='python'
alias -r ec='e -f ~/dotfiles/.zshrc; source ~/dotfiles/.zshrc'
alias -r t='touch'

# Options
# =======

# When complete from middle, move cursor
setopt always_to_end

# Spelling correction
setopt correct

# Functions
# =========

# Ls + grep regexp
lg() {
    ls -F|grep "$*"
}


# Make a directory and go there.
mc() {
    mkdir -p $*
    cd $*
}

# git toys
function git(){hub "$@"}

# unrar thing
unrar() {
    /Applications/UnRarX.app/Contents/MacOS/UnRarX $*&
}

# preview
preview() {
    /Applications/Preview.app/Contents/MacOS/Preview $*&
}

# Prompt
# ======

PS1='%n [%1~]%# '

# Magic
# =====


# # If "cd /path/to/file", then cd will simply go to "/path/to"
# (eliminating the file name).
cd () {
    if (( $# != 1 )); then
        builtin cd "$@"
        return
    fi

    if [[ -f "$1" ]]; then
        builtin cd "$1:h"
    else
        builtin cd "$1"
    fi
}


