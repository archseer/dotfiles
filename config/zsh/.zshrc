export ZGEN_DIR="${ZDOTDIR:-$HOME}/.zgen"
source "${ZGEN_DIR}/zgen.zsh"

if ! zgen saved; then
  echo "Creating a zgen save..."

  ZGEN_PREZTO_LOAD_DEFAULT=0 # don't load default list on `zgen prezto`

  zgen prezto editor key-bindings 'vi'
  zgen prezto editor dot-expansion 'yes'
  zgen prezto prompt theme 'hyrule'

  zgen prezto
  zgen prezto environment
  zgen prezto terminal
  zgen prezto editor
  zgen prezto history
  zgen prezto directory
  zgen prezto completion   # must be loaded after utility
  zgen prezto prompt

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

# You may need to manually set your language environment
export LANG=en_US.UTF-8
export LC_CTYPE="en_US.UTF-8"

export EDITOR='nvim'
export VISUAL='nvim'
export TERMINAL='alacritty'
export BROWSER='firefox-developer-edition'

export GL_ENABLE_DEBUG_ATTACH=YES

# android ndk
# export ANDROID_NDK_HOME="$(brew --prefix)/share/android-ndk"

# erlang shell history
export ERL_AFLAGS="-kernel shell_history enabled"
export ELIXIR_EDITOR="vi +__LINE__ __FILE__"

export WEECHAT_HOME="$HOME/.config/weechat"

export NNN_USE_EDITOR=1

# autocomplete kubectl
# source <(kubectl completion zsh)

eval "$(fasd --init auto)"
# I use sd the sed replacement util
unalias sd

# -- Aliases ----------------------------------------------------------------

alias vim='nvim'
alias v='nvim'
alias e='v $(fzf)'
alias g='/usr/bin/git'
alias l='ls -lahgF'
alias ll='ls -CF'
alias l='exa -lahgF --group-directories-first'
# --time-style=long-iso
alias ll='exa -F'

alias k='kubectl'
# alias h='helm'
# alias f='fly -t ci'

alias m='mix'
alias c='cargo'

# j stands for jump
alias j='fasd_cd -d'

alias yay="PKGEXT='.pkg.tar' yay"

alias open="xdg-open"

# alias vim='echo'
# alias git='echo'
# alias ag='rg'

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
    --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --stat --color=always | head -'$LINES |
  grep -o "[a-f0-9]\{7,\}"
}

zle -N gh
bindkey '^g^h' gh

source /home/speed/.config/broot/launcher/bash/br
