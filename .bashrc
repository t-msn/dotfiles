#! /bin/bash
# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# show exit status at PS1
function __show_status () {
	ret=$?
	if [ $ret -eq 0 ]; then
		return;
	fi
	printf "(exit status: $ret)"
}

# show git branch name at PS1
if [ -e /usr/share/doc/git/contrib/completion/git-prompt.sh ]; then # linux (fedora)
	source /usr/share/doc/git/contrib/completion/git-prompt.sh
	source /usr/share/doc/git/contrib/completion/git-completion.bash

	GIT_PS1_SHOWDIRTYSTATE=true
	export PS1='\[\033[32m\]\u@\h\[\033[00m\]:\[\033[34m\]\w\[\033[31m\]$(__git_ps1)\[\033[00m\]\[\033[31m\]$(__show_status)\[\033[00m\]\$ '
elif [ -e /etc/bash_completion.d/git-prompt.sh ]; then # linux (open suse)
	source /etc/bash_completion.d/git-prompt.sh
	source /etc/bash_completion.d/git.sh

	GIT_PS1_SHOWDIRTYSTATE=true
	export PS1='\[\033[32m\]\u@\h\[\033[00m\]:\[\033[34m\]\w\[\033[31m\]$(__git_ps1)\[\033[00m\]\[\033[31m\]$(__show_status)\[\033[00m\]\$ '

elif [ -e /usr/local/etc/bash_completion.d/git-prompt.sh ]; then # mac (brew)
	source /usr/local/etc/bash_completion.d/git-prompt.sh
	source /usr/local/etc/bash_completion.d/git-completion.bash

	GIT_PS1_SHOWDIRTYSTATE=true
	export PS1='\[\033[32m\]\u@\h\[\033[00m\]:\[\033[34m\]\w\[\033[31m\]$(__git_ps1)\[\033[00m\]\[\033[31m\]$(__show_status)\[\033[00m\]\$ '
else
	export PS1='\[\033[32m\]\u@\h\[\033[00m\]:\[\033[34m\]\w\[\033[31m\]$(__show_status)\[\033[00m\]\$ '
fi

# change tmux window name to it's runnning command name
case "${TERM}" in
	screen*)
		# export PROMPT_COMMAND='printf "\033k$PWD\033\\"'
		# ;;

		## automatically rename tmux pane to current command
		# function that performs the title update (invoked as PROMPT_COMMAND)
    function update_title { printf "\033]2;%s\033\\" "{1:-$TMUX_PANE_TITLE}"; } 
 		# default pane title is the name of the current process (i.e. 'bash')
 		TMUX_PANE_TITLE=$(ps -o comm $$ | tail -1)
 		# Reset title to the default before displaying the command prompt
 		export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND;}update_title"
 		# Update title before executing a command: set it to the command 
		trap 'update_title "$BASH_COMMAND"' DEBUG 
 		;;
esac

## history settings
# Avoid duplicates
export HISTCONTROL=ignoredups:erasedups  
# When the shell exits, append to the history file instead of overwriting it
shopt -s histappend
# After each command, append to the history file and reread it
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"
# use filter command (fzy) for C-r
if [ `which fzf` ]; then 
	function select-history() {
	  # declare l=$(HISTTIMEFORMAT= history | sort -k1,1nr | perl -ne 'BEGIN { my @lines = (); } s/^\s*\d+\s*//; $in=$_; if (!(grep {$in eq $_} @lines)) { push(@lines, $in); print $in; }' | peco --layout=bottom-up --query "$READLINE_LINE")
	  # declare l=$(HISTTIMEFORMAT= history | sort -k1,1nr | perl -ne 'BEGIN { my @lines = (); } s/^\s*\d+\s*//; $in=$_; if (!(grep {$in eq $_} @lines)) { push(@lines, $in); print $in; }' | fzy --query "$READLINE_LINE")
	  declare l=$(HISTTIMEFORMAT= history | sort -k1,1nr | perl -ne 'BEGIN { my @lines = (); } s/^\s*\d+\s*//; $in=$_; if (!(grep {$in eq $_} @lines)) { push(@lines, $in); print $in; }' | fzf --reverse --tiebreak=index --height=15 --query "$READLINE_LINE")
		READLINE_LINE="$l"
		READLINE_POINT=${#l}
	}
	bind -x '"\C-r": select-history'

	# select git local branch
	fbr() {
		local branches branch
	  branches=$(git branch --all | grep -v HEAD) &&
	  branch=$(echo "$branches" |
			fzf-tmux --ansi --reverse -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
		git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
	}

	# create local branch from tag
	fbt() {
		local tags tag 
		tags=$(git tag) &&
	  tag=$(echo "$tags" | sort -t . -k1,1 -k2,2n | # sort by version
			fzf-tmux --ansi --reverse --tac -d $(( 2 + $(wc -l <<< "$tags") )) +m)

		ret=$(git branch | grep -q "$tag-local")
		if [ $? -eq 0 ]; then
			git checkout $tag-local
		else 
			echo 'create new local branch'
			git checkout -B $tag-local $tag
		fi
	}

fi

## enable bash options
shopt -s autocd
shopt -s direxpand
shopt -s dirspell
shopt -s dotglob
shopt -s globstar
shopt -s nocaseglob
stty stop undef
stty werase undef
bind '\C-w:unix-filename-rubout'

## use enhancd if available
export ENHANCD_FILTER="fzf --reverse --height=15:fzy:peco"
if [ -e ~/src/enhancd/init.sh ];then
	source ~/src/enhancd/init.sh
fi

## PATH
export GOPATH=$HOME/go

## alias
alias vi=vim
alias nv=nvim
alias c='cd ~'

alias ga='git add'
alias gc='git commit'
alias gd='git diff'
alias gs='git status'
alias gl='git log'
__git_complete ga _git_add
__git_complete gc _git_commit
__git_complete gd _git_diff
__git_complete gs _git_status
__git_complete gl _git_log

source ~/.bashrc-func

if [ $(uname) == 'Darwin' ]; then
	alias ls='ls -axFG' # mac
	alias ll='ls -axlh'
else
	# alias ls='ls -axF --color=always'
	alias ls=ls-btrfs
	alias ll=ll-btrfs
	alias tree=tree-btrfs
	alias lll=exa-btrfs-ll
	alias treee=exa-btrfs-tree
fi

alias df='df -h'

alias less='less -R'
export LESSOPEN='| /usr/bin/src-hilite-lesspipe.sh %s'
alias grep='grep --with-filename --line-number --color=always'

alias ..='$cd ..'
alias ...='$cd ../..'
alias cdp='cd $(git rev-parse --show-toplevel)'

alias fzf='fzf --reverse'

## completion
if [ -e /usr/share/bash-completion/bash_completion ]; then
	source /usr/share/bash-completion/bash_completion
fi

## load local config
if [ -e ~/.bashrc_local ]; then
	source ~/.bashrc_local
fi
