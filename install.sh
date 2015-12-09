#!/bin/bash

# sudo apt-get install -y silversearcher-ag
git clone https://github.com/archSeer/dotfiles ~/.dotfiles

cd $(dirname $BASH_SOURCE)
BASE="~/.dotfiles" # $(pwd)

# RC files
for rc in *rc *profile tmux.conf gitconfig spacemacs; do
  mkdir -pv bak
  [ -e ~/.$rc ] && mv -v ~/.$rc bak/.$rc
  ln -sfv $BASE/$rc ~/.$rc
done

# Apply tmux settings
tmux source-file ~/.tmux.conf

# vim-plug
export GIT_SSL_NO_VERIFY=true
mkdir -p ~/.vim/autoload
curl --insecure -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim

# nvim
mkdir -p ~/.config/nvim/autoload
ln -sf $BASE/vimrc ~/.config/nvim/init.vim
ln -sf ~/.vim/autoload/plug.vim ~/.config/nvim/autoload/

vim +PlugInstall +qall # +GoInstallBinaries +qall!
