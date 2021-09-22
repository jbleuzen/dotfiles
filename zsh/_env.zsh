export LANG="en_US.UTF-8"

if type nvim > /dev/null 2>&1; then
  export EDITOR='nvim'
  export GIT_EDITOR='nvim'
else
  export EDITOR='vim'
  export GIT_EDITOR='vim'
fi

# Less configuration for manpages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
export PAGER='less'

export PATH=$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin
export PATH=$PATH:$HOMEBREW_PREFIX/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/sbin
export PATH=$PATH:$HOME/.dotfiles/bin # Add dotfiles bin to path
export PATH=$PATH:$HOMEBREW_PREFIX/share/npm/bin # Add npm binaries

export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

# Brew options
eval "$(/opt/homebrew/bin/brew shellenv)"
# Don't display emoji after brew install
export HOMEBREW_NO_EMOJI=1

# Disable tmux queuing for macOS Sierra
export EVENT_NOKQUEUE=1

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git,dist,__snapshots__'

# rbenv if exists
[[ -s "${HOMEBREW_PREFIX}/bin/rbenv" ]] && eval "$(rbenv init -)"

# Load z if exists
[[ -s "${HOMEBREW_PREFIX}/etc/profile.d/z.sh" ]] && . "${HOMEBREW_PREFIX}/etc/profile.d/z.sh"

# Load fnm if exists
[[ -s `which fnm` ]] && eval "$(fnm env)"

# Load dircolors if exists
[[ -s `which dircolor` ]] && eval "$(dircolors ~/.dircolors)"

[[ -f ./.secrets.zsh ]] && source .secrets.zsh
