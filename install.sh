#!/bin/bash

log() {
  declare desc="log formatter"
  echo "-----> $*"
}

# sudo apt-get install -y ripgrep silversearcher-ag
git clone https://github.com/archSeer/dotfiles ~/.dotfiles

cd $(dirname $BASH_SOURCE)
BASE="~/.dotfiles" # $(pwd)

# RC files
log "Placing dotfiles"
for rc in *rc *profile tmux.conf gitconfig vim/colors; do
  mkdir -pv bak
  [ -e ~/.$rc ] && mv -v ~/.$rc bak/.$rc
  ln -sfv $BASE/$rc ~/.$rc
done


if [[ "$OSTYPE" == "darwin"* ]]; then
  log "Installing homebrew"
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

  log "Installing brew packages"
  brew bundle

  # TODO: install proggy
fi

# zsh stuff
log "Setting up zsh"
echo /usr/local/bin/zsh | sudo tee -a /etc/shells
chsh -s /usr/local/bin/zsh
env zsh

git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"
ln -s $BASE/zsh/custom/themes/prompt_hyrule_setup ~/.zgen/sorin-ionescu/prezto-master/modules/prompt/functions

# Apply tmux settings
log "Setting up tmux"
tmux source-file ~/.tmux.conf

# vim (minpac)
log "Setting up (n)vim"
mkdir -p ~/.vim/pack/minpac/opt
git clone https://github.com/k-takata/minpac.git ~/.vim/pack/minpac/opt/minpac

# nvim
mkdir -p ~/.config/nvim/autoload
ln -sf $BASE/vimrc ~/.config/nvim/init.vim
#ln -sf ~/.vim/autoload/plug.vim ~/.config/nvim/autoload/

vim -u ~/.vim/packages.vim +PackUpdate +qall
