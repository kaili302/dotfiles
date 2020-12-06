# ~/.profile skeleton
# ~/.profile runs on interactive login shells if it exists
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
echo "source $HOME/.profile"

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# commandline editing
set -o emacs    # emacs style command line mode (default)

# default editor
export EDITOR="nvim"

stty sane # should normalize backspace issues
stty -ixon # prevent ctrl-s freeze terminal

# set timezone to london, important for interaction with comdb2 databases
export TZ="Europe/London"

# export TERM=screen-256color

# set terminal to support utf-8
if ! [ -x "$(command -v locale)" ]; then
    echo 'Error: locale is not installed.' >&2
else
    export LC_ALL=en_US.UTF-8
    export LANG=en_US.UTF-8
    export LANGUAGE=en_US.UTF-8
    echo 'terminal supports utf-8'
fi

# always color gtest
export GTEST_COLOR=yes

# Aliasing

#ls is quite a long command
alias ll='ls -li'
alias la='ls -lai'
alias lu="ls -U"

# git alias
alias gs='git status -sb'
alias gd='git diff -w --color=always'
alias gb='git branch'
alias gc='git checkout'
alias gcm='git commit -m'
alias gcam='git commit -am'
alias gr='git remote'
alias grv='git remote -v'
alias gitlg='git log --graph --pretty=format:'\''%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\'' --abbrev-commit'
alias gitup='git push --set-upstream origin'
alias gitsync='git pull upstream master'
alias gitclean='git branch|grep -v master|xargs git branch -D'

# Normal Colors
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[00;38;5;33m'   # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White

# Bold
BBlack='\e[1;30m'       # Black
BRed='\e[01;31m'         # Red
BGreen='\e[1;32m'       # Green
BYellow='\e[1;33m'      # Yellow
BBlue='\e[01;38;5;33m'   # Blue
BPurple='\e[1;35m'      # Purple
BCyan='\e[1;36m'        # Cyan
BWhite='\e[1;37m'       # White

# Background
On_Black='\e[40m'       # Black
On_Red='\e[41m'         # Red
On_Green='\e[42m'       # Green
On_Yellow='\e[43m'      # Yellow
On_Blue='\e[44m'        # Blue
On_Purple='\e[45m'      # Purple
On_Cyan='\e[46m'        # Cyan
On_White='\e[47m'       # White

NC="\e[m"               # Color Reset
Color_Off=$NC

# Tmux aliasing
alias tmux="tmux -u -2"
alias tls="tmux -u -2 ls"
alias tt="tmux -u -2 attach -t"

alias j="jobs"

# fzf
# Do not search hidden file and repos
alias ffind="find . -not -path '*/\.*' -type f -iname"
alias fd="ffind * | fzf"
export FZF_COMPLETION_TRIGGER='*'
# Can select multiple processes with <TAB> or <Shift-TAB> keys
# kill -9 <TAB>

# build system aliasing
alias cmakebuild="mkdir build && cd build && cmake -GNinja -DCMAKE_EXPORT_COMPILE_COMMANDS=1 .. && cp compile_commands.json ../"
alias cmakeclean="rm -r build"
alias mak="if make -C cmake.bld/Linux >log 2>&1; then echo Succeed!; else less log; fi"
alias makj="if make -C cmake.bld/Linux -j >log 2>&1; then echo Succeed!; else less log; fi"
alias ninj="ninja -C cmake.bld/Linux -j 100"

# cheat sheet
bash_example(){
    set -o xtrace # Optional, begin printing all commands
    echo "Run $1" # first argument
    echo "Run $@" # all arguments
    set +o xtrace # End printing all commands
}

# short functions
itest(){
    #set -o xtrace
    BIN=`ffind ${PWD##*/}.i.t.tsk`
    [ -z "$2" ] && level=INFO || level=$2
    $BIN --assert-throws-stack --show-failures-only --bael-level \
                                                  $level --gtest_filter="*$1*"
    #set +o xtrace
}

utest(){
    #set -o xtrace
    BIN=`ffind ${PWD##*/}.u.t.tsk`
    [ -z "$2" ] && level=INFO || level=$2
    $BIN --assert-throws-stack --show-failures-only --bael-level \
                                                  $level --gtest_filter="*$1*"
    #set +o xtrace
}

gdbtest(){
    #set -o xtrace
    BIN=`ffind ${PWD##*/}.u.t.tsk`
    [ -z "$2" ] && level=INFO || level=$2
    gdb --args $BIN --assert-throws-stack --show-failures-only --bael-level \
                                                  $level --gtest_filter="*$1*"
    #set +o xtrace
}

rmcache(){
    set -o xtrace
    rm -rf $refroot/refroot-${PWD##*/}
    rm -rf $PWD/log*
    rm -rf $PWD/cmake.bld/
    rm -rf $PWD/compile_commands.json
    set +o xtrace
}

rmcacheall(){
    set -o xtrace
    rm -rf $refroot/refroot-*
    set +o xtrace
}

export PATH=$HOME/bin:$PATH

# other configurations
if [ -f "$HOME/.others" ]; then
    echo "source $HOME/.others"
    source $HOME/.others
fi

# run zsh if not yet
if ! ps $$|grep -q "zsh";then
    zsh
fi

alias kgrep="grep -r -I" # -I do not match binary

ksed(){
    set -o xtrace
    grep '--exclude-dir=cmake.bld' -rl "$1" | xargs sed -i "s/$1/$2/"
    set +o xtrace
}
