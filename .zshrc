# ZShell configuration file
# Jacek Karolak (j.karolak@sabr.pl)

# ENV Vars and PATHs
export PATH="/usr/local/bin:\
/usr/local/Cellar/ruby/1.9.2-p180/bin:\
/usr/bin:\
/bin:\
/usr/sbin:\
/sbin:\
/usr/X11/bin:\
/usr/local/sbin:\
/Library/PostgreSQL/8.4/bin:\
/usr/local/texlive/2010/bin/universal-darwin/"

export NODE_PATH="/usr/local/lib/node/"

cdpath=( . ~ ~/sandbox/ ~/edu/studia/WZIM/SEM6\ -\ 2011/)

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

alias -r s='cd ~/sandbox/'
alias -r h='cd ~'
alias -r d='cd ~/Downloads/'

##
# ls
##
setopt extendedglob
alias -r l='ls'
alias -r la='l -al'
alias -r l.='l -a|grep "^\.[^\.]"' #list 'dot' files
alias -r l@='l -dF *(@)' #list links
alias -r l/='l -F|grep "\>/"' #list with grep 

##
# misc
##
alias -r m='mkdir -p'
alias -r cls='clear'
alias -r e='mvim -p'
alias -r hi='history|less'
alias -r p='python'
# stupid wx wants python to play in 32bit mode
alias -r p32bit='arch -i386 /usr/bin/python'
alias -r py3='/usr/local/bin/python3.1'
alias -r ec='e -f ~/.dotfiles/.zshrc; source ~/.dotfiles/.zshrc'
alias -r reload='source ~/.dotfiless/.zshrc'
alias -r t='touch'
alias -r pi='pip install'
alias -r b='brew'
alias -r bu='b update > /dev/null; b outdated'
alias -r bi='b install'
# Ask wiki!
alias -r wiki='p /Users/Sabr/sandbox/wiki_ask_py/wiki_ask.py'
# Downloads files from rapidshare using prepared cookie
alias -r rap='wget --header="Cookie: enc=`cat ~/.dotfiless/rapidsharecookie` " -c -i'

##
# Git related aliases
##
alias -r g='git'
alias -r gs='git status'
alias -r ga='git add'
alias -r gc='git commit'
alias -r gcm='git commit -m'
alias -r gch='git checkout -b'
alias -r gb='git branch'
alias -r gl='git log'

# Options
# =======

# When complete from middle, move cursor
setopt always_to_end

# Spelling correction
setopt correct

# Autocd 
setopt autocd


# Completition
# ============
autoload -U compinit && compinit
zstyle ':completion:*' menu select
# tab completion for PID :D
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list alwa
zstyle ':completion:*:kill:*:processes' command "ps x"

# Movement
bindkey "^A" beginning-of-line
bindkey "^W" forward-word
bindkey "^B" backward-word
bindkey "^Z" beginning-of-history
bindkey "^X" end-of-history
bindkey "^Q" quoted-insert
bindkey "[[3~" delete-char
bindkey "^R" history-search-backward
bindkey "^T" history-search-forward

# Functions
# =========

# Download files from Pycon blip.tv
blip.tv() {
    if (( $# == 0 )) then 
        echo usage: blip.tv filename
    else
        wget "blip.tv/file/get/$*"
    fi
}

# Ls + grep regexp
lg() {
    ls -F|grep "$*"
}


# Make a directory and go there.
mc() {
    mkdir -p $*
    cd $*
}

# Soft deletion
del() {
    mv $* ~/.Trash/
}

# Downloads files from hotfile using prepared cookie
hf() {
    cmd="wget --load-cookies ~/.dotfiless/hotfilecookie -c"
    if (( $# == 0 ))
    then
        eval ${cmd} $(pbpaste)
    else
        eval ${cmd} '-i' $*
    fi;
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

# download entire site
wg() {
    if (( $# == 0 ))
    then
        URL=$(pbpaste)
    else
        URL=$1
    fi;
    wget \
         --recursive \
         --no-clobber \
         --page-requisites \
         --html-extension \
         --convert-links \
         --restrict-file-names=windows \
         --domains $(python -c "from urlparse import urlparse; url=urlparse('$URL'); print url.netloc") \
         --no-parent \
         $URL
}

# Prompt
# ======
autoload -U colors && colors
# set some colors
for COLOR in RED GREEN YELLOW WHITE BLACK CYAN BLUE; do
    eval PR_$COLOR='%{$fg[${(L)COLOR}]%}'        
    eval PR_BRIGHT_$COLOR='%{$fg_bold[${(L)COLOR}]%}'
done                                                
PR_RESET="%{${reset_color}%}"; 

autoload -Uz vcs_info

precmd() {
    psvar=()
    vcs_info
    [[ -n $vcs_info_msg_0_ ]] && psvar[1]="$vcs_info_msg_0_"
}
setopt prompt_subst

PROMPT="%~ %1v ${PR_BLUE}>${PR_RESET} "

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


