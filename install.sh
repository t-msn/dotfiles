#!/bin/bash

if [ -e /etc/fedora-release ]; then
	sudo dnf -y install git vim-enhanced neovim tmux bash-completion
	sudo pip3 install neovim

	# for deoplete
	sudo pip3 install jedi
	sudo dnf -y install clang

	sudo dnf copr enable carlwgeorge/ripgrep
	sudo dnf -y install ripgrep
	sudo dnf install fzf
else
	echo 'nothing specific done for this architecture'
fi

echo 'clone some git directories'
mkdir ~/src
git clone https://github.com/b4b4r07/enhancd.git ~/src/enhancd
git clone https://github.com/thewtex/tmux-mem-cpu-load ~/src/tmux-mem-cpu-load
