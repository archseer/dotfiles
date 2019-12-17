#!/bin/bash
set -euxo pipefail

log() {
  declare desc="log formatter"
  echo "-----> $*"
}

BASE="$HOME/.dotfiles"

git clone --recurse-submodules https://github.com/archSeer/dotfiles $BASE

cd $(dirname $HOME)

# RC files
log "Placing dotfiles"
for rc in config zshenv tmux.conf; do
  mkdir -pv bak
  [ -e ~/.$rc ] && mv -v ~/.$rc bak/.$rc
  ln -sfv $BASE/$rc ~/.$rc
done

# zsh stuff
log "Setting up zsh"
# add zsh to /etc/shells
ln -s $BASE/config/zsh/prompt_hyrule_setup ~/.config/zsh/.zgen/sorin-ionescu/prezto-master/modules/prompt/functions
chsh -s $(which zsh)
env zsh

# Apply tmux settings
log "Setting up tmux"
tmux source-file ~/.tmux.conf

# vim (minpac)
log "Setting up nvim"
vim -u ~/.vim/packages.vim +PackUpdate +qall
