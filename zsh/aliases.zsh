alias reload!='. ~/.zshrc'
alias dotfiles='cd ~/.dotfiles'

alias grep='grep --color'

# Find the option for using colors in ls, depending on the version: Linux or BSD
ls --color -d . &>/dev/null 2>&1 && alias ls='ls --color=tty -h' || alias ls='ls -Gh'
alias l='ll'
alias ll='ls -l'
alias la='ls -la'

[[ -s /usr/local/Cellar/vim/7.3.923/bin/vim ]] && alias vi='/usr/local/Cellar/vim/7.3.923/bin/vim'
[[ -s /usr/local/Cellar/vim/7.3.923/bin/vim ]] && alias vim='/usr/local/Cellar/vim/7.3.923/bin/vim'

# Navigation
alias cd..="cd .."
alias ..="cd .."
alias ...="cd ../.."

# I am huma 
alias df='df -h'
alias du='du -h'

# for rake task with argument
alias rake='noglob rake'

# Get current public IP
alias ip='dig +short myip.opendns.com @resolver1.opendns.com'

# alias for launchctl to work in tmux
# you'll need to execute "brew install reattach-to-user-namespace"
alias launchctl='reattach-to-user-namespace -l launchctl'

alias sniff="sudo ngrep -W byline -d 'en0' -t '^(GET|POST) ' 'tcp and port 80'"


# not aliases but works like an alias
md() { mkdir -p $1 && cd $1}

gen_file() { dd if=/dev/zero of=file.bin bs=1024 count=0 seek=$[1024 * $1] }
