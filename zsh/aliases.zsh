alias r='. ~/.zshrc'
alias d='cd ~/.dotfiles'

alias grep='grep --color'

# Find the option for using colors in ls, depending on the version: Linux or BSD
if ls --color -d . >/dev/null 2>&1; then
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

if [[ -s /opt/homebrew/bin/gsed ]]; then
  alias sed="gsed"
fi

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

# Dev
alias n="npm"
alias jekyll="bundle exec jekyll"


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

convertMkv() {
  FILE=$1
  MKV_FILE=${FILE%%.*}.mkv
  ffmpeg -i $FILE -c copy $MKV_FILE
}

mergeMkvs() {
  if [ "$#" -lt 2 ]; then
    echo "Please give some files to merge"
    return
  fi
  TEMP_FILE="mkvmerge.txt"
  OUTPUT_FILE="Merge.mkv"
  rm $OUTPUT_FILE 2> /dev/null
  rm $TEMP_FILE 2> /dev/null
  for ARG do
    shift
    echo "file '$ARG'" >> $TEMP_FILE
  done
  echo "File will be merged in this order :"
  cat $TEMP_FILE
  if read -q "choice?Confirm merge: "; then
    ffmpeg -safe 0 -f concat -i $TEMP_FILE -c copy $OUTPUT_FILE
  fi
  rm $TEMP_FILE
}
