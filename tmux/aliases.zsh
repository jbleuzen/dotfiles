alias t="tmux && tmux rename-window zsh;"
#alias ta="tmux attach -t $0 && wezterm cli set-tab-title $0"
alias tk="tmux kill-session -t"
alias tl="tmux ls"
alias tn="tmux new -s "
alias ts="tmux switch -t "
ta() {
  [[ -s `which wezterm` ]] && wezterm cli set-tab-title $1
  tmux attach -t $1
}
