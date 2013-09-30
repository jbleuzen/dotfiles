# 2011-10-19: tmux shortcut for creating/attaching named sessions
tm() {
    [[ -z "$1" ]] && { echo "usage: tm <session>" >&2; return 1; }

    tmux has -t $1 
	if [ $? -eq "0" ] ;then
		if [ -z $TMUX ] ;then
			tmux attach -t $1
		else
			tmux switch -t $1
		fi
	else 
		if [ -z $TMUX ] ;then
			tmux new-session -s $1
			tmux attach -t $1
		else
			TMUX="" # To prevent message with 
			tmux new-session -s $1 -d
			tmux switch -t $1
		fi
	fi
}

# 2011-10-19
# stolen from completion function _tmux
function __tmux-sessions() {
	local expl
	local -a sessions
	sessions=( ${${(f)"$(command tmux list-sessions)"}/:[ $'\t']##/:} )
	_describe -t sessions 'sessions' sessions "$@"
}
compdef __tmux-sessions tm
compdef __tmux-sessions tk
