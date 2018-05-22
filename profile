# ~/.profile skeleton
# ~/.profile runs on interactive login shells if it exists
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
echo "~/.profile has run"

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# commandline editing
set -o emacs    # emacs style command line mode (default)
#set -o vi      # vi style command line mode

stty sane # should normalize backspace issues?

# pass colours through to less
export LESS="-R"
export LESSOPEN='|~/.lessfilter %s'


# set timezone to london, important for interaction with comdb2 databases
export TZ="Europe/London"

export TERM=screen-256color

# always color gtest
export GTEST_COLOR=yes

# Aliasing
alias xterm="xterm -ls &"

#ls is quite a long command
alias ll='ls -li'
alias la='ls -lai'
alias lu="ls -U"

# find
alias ffind='find . -iname'

# git alias
alias gs='git status'
alias gd='git diff'
alias gb='git branch'
alias gc='git checkout'
alias gitlg='git log --graph --pretty=format:'\''%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\'' --abbrev-commit'
alias gitup='git push --set-upstream origin'
alias gitsync='git pull upstream master'

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

# build system aliasing
alias cmakebuild="mkdir build && cd build && cmake .."
alias cmakeclean="rm -r build"

# other configurations
source ~/.others
