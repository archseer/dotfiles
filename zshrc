source "${HOME}/.zgen/zgen.zsh"

if ! zgen saved; then
  echo "Creating a zgen save..."

  ZGEN_PREZTO_LOAD_DEFAULT=0 # don't load default list on `zgen prezto`

  zgen prezto editor key-bindings 'vi'
  zgen prezto editor dot-expansion 'yes'
  zgen prezto utility:ls color 'yes'
  zgen prezto utility safe-ops 'no'
  zgen prezto '*:*' color 'yes'
  zgen prezto prompt theme 'hyrule'

  zgen prezto
  zgen prezto environment
  zgen prezto terminal
  zgen prezto editor
  zgen prezto history
  zgen prezto directory
  zgen prezto utility
  zgen prezto completion   # must be loaded after utility
  zgen prezto prompt
  zgen prezto ssh

  zgen prezto history-substring-search
  zgen load zsh-users/zsh-autosuggestions
  # Load more completion files for zsh from the zsh-lovers github repo
  zgen load zsh-users/zsh-completions src
  zgen load Tarrasch/zsh-bd
  zgen save
fi
# override prezto
setopt clobber

# -- Exports ----------------------------------------------------------------

# Add the missing sbin to path
export PATH="/usr/local/sbin:$PATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8
export LC_CTYPE="en_US.UTF-8"

export EDITOR='nvim'

export GL_ENABLE_DEBUG_ATTACH=YES

# put ~/bin on PATH if you have it
test -d "$HOME/bin" &&
  PATH="$HOME/bin:$PATH"

# add rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
# add go
export GOPATH="$HOME/src/go"
export PATH="${GOPATH//://bin:}/bin:$PATH"
# add yarn
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
# add rust
export PATH="$HOME/.cargo/bin:$PATH"

#export PATH="$HOME/src/moon/bin:$PATH"

# erlang shell history
export ERL_AFLAGS="-kernel shell_history enabled"
export ELIXIR_EDITOR="vi +__LINE__ __FILE__"

# autocomplete kubectl
# source <(kubectl completion zsh)

eval "$(fasd --init auto)"

# -- Aliases ----------------------------------------------------------------

alias vim='nvim'
alias v='nvim'
alias e='v $(fzf)'
alias g='/usr/local/bin/git'
alias l='ls -alhF'
alias ll='ls -CF'

alias k='kubectl'
alias h='helm'
alias f='fly -t ci'

alias j='fasd_cd -d'

#alias vim='echo'
#alias git='echo'
alias ag='rg'

alias myip="dig +short myip.opendns.com @resolver1.opendns.com"

# Show laptop's IP addresses
alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"

# Mutes/Unmutes the system volume.
alias mute="osascript -e 'set volume output muted true'"
alias unmute="osascript -e 'set volume output muted false'"

function kex() {
  kubectl exec -i -t "$1" bin/app remote_console
}

# -- fzf --------------------------------------------------------------------

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
