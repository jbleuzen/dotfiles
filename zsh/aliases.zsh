alias reload!='. ~/.zshrc'
alias dotfiles='cd ~/.dotfiles'

alias grep='grep --color'

# Find the option for using colors in ls, depending on the version: Linux or BSD
if ls --color > /dev/null 2>&1; then 
  # GNU `ls`
  colorflag="--color=auto --group-directories-first"
else 
  # OS X `ls`
  colorflag="-G"
fi
alias ls="ls -lFh ${colorflag}"

alias l='ll'
alias ll='ls -l'
alias la='ls -la'

# Navigation
alias cd..="cd .."
alias cd-="cd -"
alias ..="cd .."
alias ...="cd ../.."

alias json="python -m json.tool"

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

local_ip() { ifconfig en0 | grep inet | grep -v inet6 | awk '{print $2}' }

local_server() { dns-sd -P $1 _http._tcp local 80 $1.local `local_ip` path=/ }

# Open Finder in current working folder
alias finder="open ."
# CD to Finder's current folder
cdf() {
  target=`osascript -e 'tell application "Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)'`
  if [ "$target" != "" ]; then
    cd "$target"; pwd
  else
    echo 'No Finder windows are opened' >&2
  fi
}
