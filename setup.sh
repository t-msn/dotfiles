#!/bin/bash

ln -sf "$PWD/.bashrc" ~/.bashrc
ln -sf "$PWD/.bashrc-func" ~/.bashrc-func
ln -sf "$PWD/.bash_profile" ~/.bash_profile
ln -sf "$PWD/.inputrc" ~/.inputrc

ln -sf "$PWD/.tmux.conf" ~/.tmux.conf
if [ $(uname) == 'Linux' ]; then
	ln -s "$PWD/.tmux.conf.linux" ~/.tmux.conf.linux
else if [ $(uname) == 'Darwin' ]; then
	ln -s "$PWD/.tmux.conf.osx" ~/.tmux.conf.osx
fi

# vim
mkdir -p ~/.config/vim
ln -s "$PWD/.vimrc" ~/.vimrc
ln -s "$PWD/dein.toml" ~/.config/vim
ln -s "$PWD/dein_lazy.toml" ~/.config/vim
ln -s "$PWD/dein_misc.toml" ~/.config/vim

# neovim
mkdir -p ~/.config/nvim
ln -s "$PWD/init.vim" ~/.config/nvim
ln -s "$PWD/dein_nvim.toml" ~/.config/nvim/
ln -s "$PWD/dein_nvim_lazy.toml" ~/.config/nvim
