#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export DOCKER_HOST=tcp://localhost:4243
export TERM=xterm-256color
export GL_ENABLE_DEBUG_ATTACH=YES

export PATH="$(brew --prefix homebrew/php/php55)/bin:$PATH"

export GOPATH="$HOME/src/go"
export PATH="${GOPATH//://bin:}/bin:$PATH"

shopt -s cdspell          # autocorrects cd misspellings

alias ls='ls -G'			# colorized ls
alias grep='grep -G'  # colorized grep
# alias timesync='sudo ntpd -qg; sudo hwclock -w'	# sync time

alias du1='du -h --max-depth=1'
alias fin='find . -iname'
alias fn='find . -name'
alias hi='history | tail -20'

PS1='\e[0;34m[\u@\h \W]\$  \e[m'
PS1='\e[0;34m┌─\e[0;35m\u\e[0;32m[\W] \e[0;34m\n └─ \e[m'

export EDITOR="vim"

# put ~/bin on PATH if you have it
test -d "$HOME/bin" &&
PATH="$HOME/bin:$PATH"

# ex - archive extractor
# usage: ex <file>
ex () {
  if [ -f $1 ] ; then
    case $1 in
      *.rar) rar x $1   ;;
      *.zip) unzip $1   ;;
      *.7z)  7z x $1    ;;
      *)     tar xf $1  ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# roll - archive wrapper
# usage: roll <foo.tar.gz> ./foo ./bar
roll () {
  FILE=$1
  case $FILE in
    *.tar.bz2) shift && tar cjf $FILE $* ;;
    *.tar.gz) shift && tar czf $FILE $* ;;
    *.tar.xz) shift && tar cJf $FILE $* ;;
    *.tgz) shift && tar czf $FILE $* ;;
    *.zip) shift && zip $FILE $* ;;
    *.rar) shift && rar $FILE $* ;;
  esac
}

# swap() -- switch 2 filenames around
function swap() {
  local TMPFILE=tmp.$$
  mv "$1" $TMPFILE
  mv "$2" "$1"
  mv $TMPFILE "$2"
}
 
# use bash-completion package!
