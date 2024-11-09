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

[[ -s /opt/homebrew/opt/coreutils/libexec/gnubin ]] && export PATH=/opt/homebrew/opt/coreutils/libexec/gnubin
[[ -s /opt/homebrew/opt/ruby/bin ]] && export PATH=$PATH:/opt/homebrew/opt/ruby/bin
export PATH=$PATH:$HOMEBREW_PREFIX/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/sbin
export PATH=$PATH:$HOME/.dotfiles/bin # Add dotfiles bin to path
export PATH=$PATH:$HOMEBREW_PREFIX/share/npm/bin # Add npm binaries

export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

# Brew options
[[ -s "/opt/homebrew/bin/brew" ]] && eval "$(/opt/homebrew/bin/brew shellenv)" # Mac M1
[[ -s "/usr/local/bin/brew" ]] && eval "$(/usr/local/bin/brew shellenv)" # Mac Intel

export HOMEBREW_NO_EMOJI=1 # Don't display emoji after brew install
export EVENT_NOKQUEUE=1 # Disable tmux queuing for macOS Sierra

# rbenv if exists
[[ -s "${HOMEBREW_PREFIX}/bin/rbenv" ]] && eval "$(rbenv init -)"

# Load z if exists
[[ -s "${HOMEBREW_PREFIX}/etc/profile.d/z.sh" ]] && . "${HOMEBREW_PREFIX}/etc/profile.d/z.sh"

# Load fnm if exists
[[ -s `which fnm` ]] && eval "$(fnm env --use-on-cd --version-file-strategy=recursive)"

# Load dircolors if exists
[[ -s `which dircolor` ]] && eval "$(dircolors ~/.dircolors)"

# Setup FZF
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git,dist,__snapshots__'
[[ -s `which fzf` ]] && source <(fzf --zsh)

# This slow downs considerably shell startup
#[[ -f ~/.dotfiles/zsh/.secrets.zsh ]] && source ~/.dotfiles/zsh/.secrets.zsh
