# ~/.profile skeleton
# ~/.profile runs on interactive login shells if it exists
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
echo "source $HOME/.profile"

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# commandline editing
set -o emacs    # emacs style command line mode (default)
export EDITOR=vim
export VISUAL=vim
export TERM=xterm-256color

stty sane # should normalize backspace issues
stty -ixon # prevent ctrl-s freeze terminal

# Better command history
HISTFILESIZE=-1
HISTSIZE=1000000
shopt -s histappend
HISTCONTROL=ignoredups
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# BASH Auto-complete
if [ -n "$BASH" ] ;then
    bind 'set show-all-if-ambiguous on'
    bind 'TAB:menu-complete'
    bind '"\e[Z":menu-complete-backward'
fi

# set timezone to london
#export TZ="Europe/London"

export PATH=$PATH:$HOME/bin
BASE_DIR="/home/$USER"
export BASE_DIR

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
alias ls='ls -h'
alias ll='ls -lih'
alias la='ls -laih'
alias lu="ls -U"

# git alias
alias gs='git status -sb'
alias gbk='git commit -am bk'
alias gru='git commit -am "review update"'
alias grc='git rebase --continue'
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

# Bash alias
mkcd() {
  mkdir -p "$1" && cd "$1"
}
alias j="jobs"
jk() {
  kill -9 %$1
}
alias kgrep="grep --color -r -I" # -I do not match binary

# Tmux aliasing
alias tmux="tmux -u -2"
alias tls="tmux -u -2 ls"
alias tt="tmux -u -2 attach -t"


ksed(){
    set -o xtrace
    grep '--exclude-dir=cmake.bld' -rl "$1" | xargs sed -i "s/$1/$2/"
    set +o xtrace
}

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

colortest() {
  local color escapes intensity style
  echo "NORMAL bold  dim   itali under rever strik  BRIGHT bold  dim   itali under rever strik"
  for color in $(seq 0 7); do
    for intensity in 3 9; do  # normal, bright
      escapes="${intensity}${color}"
      printf '\e[%sm\\e[%sm\e[0m ' "$escapes" "$escapes"
      for style in 1 2 3 4 7 9; do  # normal, bold, dim, italic, underline, reverse, strikethrough
        escapes="${intensity}${color};${style}"
        printf '\e[%sm\\e[%sm\e[0m ' "$escapes" "$style"
      done
      echo -n " "
    done
    echo
  done

  awk 'BEGIN{
    columns = 78;
    step = columns / 6;
    for (hue = 0; hue<columns; hue++) {
      x = (hue % step) * 255 / step;
      if (hue < step) {
        r = 255; g = x; b = 0;
      } else if (hue < step*2) {
        r = 255-x; g = 255; b = 0;
      } else if (hue < step*3) {
        r = 0; g = 255; b = x;
      } else if (hue < step*4) {
        r = 0; g = 255-x; b = 255;
      } else if (hue < step*5) {
        r = x; g = 0; b = 255;
      } else {
        r = 255; g = 0; b = 255-x;
      }
      printf "\033[48;2;%d;%d;%dm", r, g, b;
      printf "\033[38;2;%d;%d;%dm", 255-r, 255-g, 255-b;
      printf " \033[0m";
    }
    printf "\n";
  }'
}

# Python
# For python development, always use venv
alias venv-activate="source ~/.venv/bin/activate"
alias pretty-json="python -m json.tool"

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

sort_words(){
    set -o xtrace # Optional, begin printing all commands
    echo "$1" | tr " " "\n" | sort | tr "\n" " " ;echo
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

# other configurations
if [ -f "$HOME/.others" ]; then
    echo "source $HOME/.others"
    source $HOME/.others
fi


