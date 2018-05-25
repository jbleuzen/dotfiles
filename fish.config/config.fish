##
# Enable vim mode
fish_vi_key_bindings

# Don't show message on shell startup
set --erase fish_greeting

set -x PATH /usr/bin $PATH
set -x PATH /bin $PATH
set -x PATH /usr/sbin $PATH
set -x PATH /sbin $PATH
set -x PATH /usr/local/opt/coreutils/libexec/gnubin $PATH
set -x PATH /usr/local/bin $PATH
set -x PATH /usr/local/sbin $PATH
set -x PATH ./node_modules/.bin $PATH

set -g -x EDITOR vim

set PATH $HOME/.rbenv/bin $PATH
set PATH $HOME/.rbenv/shims $PATH
rbenv rehash >/dev/null ^&1

##
# Import other files
. $HOME/.config/fish/functions.fish
. $HOME/.config/fish/prompt.fish

