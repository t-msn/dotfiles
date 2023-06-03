#!/bin/bash

if [ -e /etc/fedora-release ]; then
	sudo dnf -y install git vim-enhanced neovim python3-neovim tmux bash-completion cmake
	sudo dnf -y install ripgrep fzf fd-find

elif [ -e /etc/SUSE-brand ]; then
	# needs update
	sudo zypper install -y tmux neovim cmake
	sudo pip3 install jedi
	sudo zypper install -y clang
else
	echo 'nothing specific done for this architecture'
fi

echo 'clone some git directories'
mkdir ~/src
git clone https://github.com/b4b4r07/enhancd.git ~/src/enhancd

git clone https://github.com/thewtex/tmux-mem-cpu-load ~/src/tmux-mem-cpu-load
pwd=$PWD
cd ~/src/tmux-mem-cpu-load
cmake .
make
sudo make install
cd $pwd
