# Wrap ssh commmand to allow smart pane behavior in tmux.
#
# Lifted from https://github.com/moonboots/tmux-ssh/blob/master/tmux-sshrc
#
# After opening a tmux window and ssh-ing into another server, new panes will
# open already ssh-ed to the server.
function ssh() {
  if [ -n "$TMUX" ] # set only if within running tmux
  then
    window_index=$(tmux display-message -p '#I')

    # arbitrary environment variable name to remember ssh args like server
    # hostname so we can connect again.
    session_variable_name="window_${window_index}_ssh_args"

    # save in tmux session variable
    tmux setenv $session_variable_name "$*"

    # set window title
    tmux rename-window $*

    # run ssh
    /usr/bin/ssh $*

    # unset variable so new panes don't continue ssh-ing to this server
	tmux setenv -u $session_variable_name
  else
    /usr/bin/ssh $*
  fi

  # rename title back
  tmux rename-window zsh
}


# 2011-10-19: tmux shortcut for creating/attaching named sessions
tm() {
    [[ -z "$1" ]] && { echo "usage: tm <session>" >&2; return 1; }
    tmux has -t $1 
	if [ $? -eq "0" ] ;then
		tmux switch -t $1
	else 
		TMUX="" # To prevent message with 
		tmux new-session -s $1 -d
		tmux switch -t $1
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
