function __show_status () {
	ret=$?
	if [ $ret -eq 0 ]; then
		return;
	fi
	printf "(exit status: $ret)"
}

source /usr/share/doc/git/contrib/completion/git-prompt.sh
source /usr/share/doc/git/contrib/completion/git-completion.bash
GIT_PS1_SHOWDIRTYSTATE=true
export PS1='\[\033[32m\]\u@\h\[\033[00m\]:\[\033[34m\]\w\[\033[31m\]$(__git_ps1)\[\033[00m\]\[\033[31m\]$(__show_status)\[\033[00m\]\$ '

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
 		export PROMPT_COMMAND='update_title'   
 		# Update title before executing a command: set it to the command 
		trap 'update_title "$BASH_COMMAND"' DEBUG 
 		;;
esac
