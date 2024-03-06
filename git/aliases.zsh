# The rest of my fun git aliases
if which fzf >/dev/null 2> /dev/null ; then
  alias fga='git ls-files -m -o --exclude-standard | fzf --height=50% --print0 -m --preview-window right:75%  --preview "git diff --color=always {}" | xargs -0 -t -o git add'
  alias fgco='git ls-files -m -o --exclude-standard | fzf --height=50% --print0 -m --preview-window right:75%  --preview "git diff --color=always {}" | xargs -0 -t -o git checkout'
  #alias fgb="git for-each-ref  refs/heads/ --format='%(HEAD) %(refname:short) - %(contents:subject) - %(authorname) %(committerdate:relative)' | grep -v '^\*' |fzf --height=40% --reverse --info=inline --query=\$1 | awk '{print \$1}' | xargs git checkout"
  fgb(){
    echo $1
    git for-each-ref  refs/heads/ --format='%(HEAD) %(refname:short) - %(contents:subject) - %(authorname) %(committerdate:relative)' | grep -v '^\*' |fzf --height=40% --reverse --info=inline --query=$1 | awk '{print \$1}' | xargs git checkout
  }
fi
alias ga='git add -A'
alias gba='git branch --all --color="always" --sort=authordate --format="%(color:red)%(refname:short);%(color:green)(%(authordate:relative));%(color:white)%(subject) %(color:blue)<%(authorname)>" "$@" | column -s ";" -t | cut -c 1-150'
alias gbm='git branch --all --merged | grep -v master | grep -v develop'
alias gc='git commit'
alias gca='git commit --amend'
alias gco='git checkout'
alias gcd='cd $(git rev-parse --show-cdup)'
alias gd='git diff'
alias gdi='git diff --ignore-space-change'
alias gf='git fetch'
alias gl='git pull --prune'
alias glog="git log --pretty=format:'%C(yellow)%h%Creset - %s %C(red)%d %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative --no-merges"
alias glogg="git log --graph --pretty=format:'%C(yellow)%h%Creset - %s %C(red)%d %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative --no-merges"
alias gp='git push'
alias gpo="git push origin"
alias gpmr="git push -o merge_request.create"
alias gs='git status -sb' # upgrade your git if -sb breaks for you. it's fun.
alias grm="git status | grep deleted | awk '{print \$3}' | xargs git rm"
alias gu="git reset --soft HEAD^"
alias gsa="git stash apply"
alias gss="git stash save"


# Rewrite the default git branch with better branch list
gb(){
  if [ $# -eq 0 ]; then
    git branch --color="always" --sort=authordate --format="%(color:red)%(refname:short);%(color:green)(%(authordate:relative));%(color:white)%(subject);%(color:blue)<%(authorname)> " "$@" | column -s ";" -t | cut -c 1-120
  else 
    git branch $@
  fi
}
