#!/bin/bash

# sudo apt-get install -y ripgrep silversearcher-ag
git clone https://github.com/archSeer/dotfiles ~/.dotfiles

cd $(dirname $BASH_SOURCE)
BASE="~/.dotfiles" # $(pwd)

# RC files
for rc in *rc *profile tmux.conf gitconfig spacemacs vim/colors; do
  mkdir -pv bak
  [ -e ~/.$rc ] && mv -v ~/.$rc bak/.$rc
  ln -sfv $BASE/$rc ~/.$rc
done

# zsh stuff
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions

# Apply tmux settings
tmux source-file ~/.tmux.conf

# vim-plug
export GIT_SSL_NO_VERIFY=true
mkdir -p ~/.vim/pack/minpac/opt
git clone https://github.com/k-takata/minpac.git ~/.vim/pack/minpac/opt/minpac

# nvim
mkdir -p ~/.config/nvim/autoload
ln -sf $BASE/vimrc ~/.config/nvim/init.vim
#ln -sf ~/.vim/autoload/plug.vim ~/.config/nvim/autoload/

vim -u ~/.vim/packages.vim +PackUpdate +qall
