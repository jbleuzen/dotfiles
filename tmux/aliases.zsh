alias t="tmux && tmux rename-window zsh;"
#alias ta="tmux attach -t $0 && wezterm cli set-tab-title $0"
alias tk="tmux kill-session -t"
alias tl="tmux ls"
alias tn="tmux new -s "
alias ts="tmux switch -t "
ta() {
  SESSION_NAME=$(tmux ls -F '#S' | grep "$1" | head -1)
  [[ "$TERM_PROGRAM" == "wezterm" ]] && wezterm cli set-tab-title $SESSION_NAME
  [[ "$TERM_PROGRAM" == "ghostty" ]] &&  echo -ne "\e]0;$SESSION_NAME\a"
  tmux attach -t $SESSION_NAME
}
