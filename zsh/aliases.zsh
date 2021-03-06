alias r='. ~/.zshrc'
alias d='cd ~/.dotfiles'

alias grep='grep --color'

# Find the option for using colors in ls, depending on the version: Linux or BSD
if ls --color > /dev/null 2>&1; then 
  # GNU `ls`
  colorflag="--color=auto --group-directories-first --time-style=long-iso --indicator-style=none -I 'Icon*'"
else 
  # OS X `ls`
  colorflag="-G --ignore=Icon*"
fi
alias ls="ls -lFh ${colorflag} -v"
if [[ -s "/usr/local/bin/exa" ]]; then
  # color configuration
  export EXA_COLORS="da=37:uu=37:gu=37:sn=37:sb=31"
  exaParams="-l -g --group-directories-first --time-style=long-iso"
  alias l="exa ${exaParams} --git-ignore --git"
  alias ll="exa ${exaParams} --git-ignore --git"
  alias la="exa ${exaParams} -a --git"
else 
  alias l='ls'
  alias ll='ls'
  alias la='ls -lA'
fi

# Navigation
alias cd..="cd .."
alias cd-="cd -"
alias ..="cd .."
alias ...="cd ../.."
alias cdr='if [ "`git rev-parse --show-cdup`" != "" ]; then cd `git rev-parse --show-cdup`; fi'

alias json="python -m json.tool"

# I am huma 
alias df='df -h'
alias du='du -h'

# for rake task with argument
alias rake='noglob rake'

# Get current public IP
alias ip='dig +short myip.opendns.com @resolver1.opendns.com'

alias json='python -m json.tool'
# alias for launchctl to work in tmux
# you'll need to execute "brew install reattach-to-user-namespace"
alias launchctl='reattach-to-user-namespace -l launchctl'

alias sniff="sudo ngrep -W byline -d 'en0' -t '^(GET|POST) ' 'tcp and port 80'"

# neovim 
# /usr/local/bin/nvim => macOS brew
# /usr/bin/nvim => Debian
if [[ -s "/usr/local/bin/nvim" ]] || [[ -s "/usr/bin/nvim" ]]; then
  alias v="nvim"
  alias vi="nvim"
  alias vim="nvim"
else
  alias v="vim"
  alias vi="vim"
fi

alias n="npm"


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

export SYSLOG_PATH='/Volumes/syslog/'
last-log(){
  zparseopts -A table -- -service:=zservice -app:=zapp -date:=zday f=f
  local app=${zapp[2]:-}
  local service=${zservice[2]:-httpd}
  local day=${zday[2]:-`date "+%Y/%m/%d"`}
  if [[ -z "$app" ]]; then
    lista=("${(@f)$(find "${SYSLOG_PATH}" -maxdepth 1 -mindepth 1 -type d)}")
    if [[ ${#lista} -ne 1 ]]; then
      for (( i=1; i<=$#lista; i++ )); do
        >&2 echo "[${i}] ${lista[i]:t}"
      done
      >&2 echo -n "Please, choose an app: "
      read num
      service=${lista[num]:t}
    else
      service=${lista[1]:t}
    fi
  fi
  list=("${(@f)$(find "${SYSLOG_PATH}/$service/$day" -type f -iname "*${app}*")}")
  if [[ ${#list} -ne 1 ]]; then
    for (( i=1; i<=$#list; i++ )); do
      >&2 echo "[${i}] ${list[i]:t}"
    done
    >&2 echo -n "Please, choose a file: "
    read num
    file=${list[num]}
  else
    file=${list[1]}
  fi
  if [[ -n $f ]];then
    tail -n 100 -f $file
  else
    cat ${file:-NotFound}
  fi
}
