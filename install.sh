#!/bin/bash

if [ -e /etc/fedora-release ]; then
	sudo dnf install -y git vim-enhanced neovim tmux bash-completion
	sudo dnf copr enable carlwgeorge/ripgrep
	sudo dnf install -y ripgrep
	sudo dnf install -y https://github.com/jhawthorn/fzy/releases/download/0.9/fzy-0.9-1.x86_64.rpm

	mkdir src
	git clone https://github.com/b4b4r07/enhancd.git src/enhancd
else
	echo 'nothing done'
	exit 1
fi
