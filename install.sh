#!/bin/bash

if [ -e /etc/fedora-release ]; then
	sudo dnf -y install git vim-enhanced neovim tmux bash-completion
	sudo pip3 install neovim

	# for deoplete
	sudo pip3 install jedi
	sudo dnf -y install clang

	sudo dnf copr enable carlwgeorge/ripgrep
	sudo dnf -y install ripgrep
	sudo dnf -y install https://github.com/jhawthorn/fzy/releases/download/0.9/fzy-0.9-1.x86_64.rpm

	mkdir src
	git clone https://github.com/b4b4r07/enhancd.git src/enhancd
else
	echo 'nothing done'
	exit 1
fi
