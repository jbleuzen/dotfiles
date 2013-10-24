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

export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/sbin
export PATH=$PATH:$HOME/.dotfiles/bin # Add dotfiles bin to path
export PATH=$HOME/.rbenv/bin:$PATH # Add RVM to PATH for scripting
export PATH=$PATH:/usr/local/share/npm/bin # Add npm binaries

# rbenv
if which rbenv > /dev/null; then eval "$(rbenv init - --no-rehash)"; fi

# Load z if exist
[[ -s "/usr/local/etc/profile.d/z.sh" ]] && . "/usr/local/etc/profile.d/z.sh"
