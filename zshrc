source "${HOME}/.zgen/zgen.zsh"

if ! zgen saved; then
  echo "Creating a zgen save"

  #zgen prezto editor key-bindings 'vi'
  zgen prezto editor key-bindings 'emacs'
  zgen prezto utility:ls color 'yes'
  zgen prezto '*:*' color 'yes'

  zgen prezto
  zgen prezto environment
  zgen prezto terminal
  zgen prezto editor
  zgen prezto history
  zgen prezto directory
  zgen prezto utility
  zgen prezto completion   # must be loaded after utility
  zgen prezto prompt theme 'hyrule'

  zgen prezto history-substring-search
  zgen load zsh-users/zsh-autosuggestions
  zgen load zsh-users/zsh-completions src
  zgen save
fi
# override prezto
setopt clobber

# Add the missing sbin to path
export PATH="/usr/local/sbin:$PATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8
export LC_CTYPE="en_US.UTF-8"

export EDITOR='nvim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

export GL_ENABLE_DEBUG_ATTACH=YES

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# put ~/bin on PATH if you have it
test -d "$HOME/bin" &&
PATH="$HOME/bin:$PATH"

export GOPATH="$HOME/src/go"
export PATH="${GOPATH//://bin:}/bin:$PATH"

#export PATH="$HOME/src/moon/bin:$PATH"

alias mm='middleman'

alias vim='nvim'
alias v='nvim'
alias g='/usr/local/bin/git'

alias k='kubectl'
alias h='helm'
alias f='fly -t ci'

#alias vim='echo'
#alias git='echo'
alias ag='rg'

# OSX is turning into shit, askpass isn't working so I copied it from
# https://github.com/markcarver/mac-ssh-askpass/blob/master/ssh-askpass
# into ~/bin/ssh-askpass
export SSH_ASKPASS="ssh-askpass"

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

fzf-down() {
  fzf --height 50% "$@" --border
}

gh() {
  git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
  fzf-down --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
    --header 'Press CTRL-S to toggle sort' \
    --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always | head -'$LINES |
  grep -o "[a-f0-9]\{7,\}"
}

zle -N gh
bindkey '^g^h' gh

# erlang shell history
export ERL_AFLAGS="-kernel shell_history enabled"
export ELIXIR_EDITOR="vi +__LINE__ __FILE__"

# autocomplete kubectl
source <(kubectl completion zsh)

export PATH="$HOME/.yarn/bin:$PATH"
