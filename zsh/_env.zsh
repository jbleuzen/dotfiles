export EDITOR='vim'

# Less configuration for manpages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
export PAGER='less'

export PATH=/usr/local/opt/coreutils/libexec/gnubin
export PATH=$PATH:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/sbin
export PATH=$PATH:$HOME/.dotfiles/bin # Add dotfiles bin to path
#export PATH=$HOME/.rbenv/shims:$PATH # Add RVM to PATH for scripting
export PATH=$PATH:/usr/local/share/npm/bin # Add npm binaries

export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

# Disable tmux queuing for macOS Sierra
export EVENT_NOKQUEUE=1

# rbenv if exists
[[ -s "/usr/local/bin/rbenv" ]] && eval "$(rbenv init -)"

# Load z if exists
[[ -s "/usr/local/etc/profile.d/z.sh" ]] && . "/usr/local/etc/profile.d/z.sh"

# Load dircolors if exists
[[ -s "dircolor" ]] && eval "$(dircolors ~/.dircolors)"

# Load docker-machine if exists
[[ -s "docker-machine" ]] && eval "$(docker-machine env default)"

# added by travis gem
[ -f $HOME/.travis/travis.sh ] && source $HOME/.travis/travis.sh
