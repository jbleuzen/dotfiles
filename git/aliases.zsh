# The rest of my fun git aliases
if which fzf >/dev/null 2> /dev/null ; then
  alias fga='git ls-files -m -o --exclude-standard | fzf --height=50% --print0 -m --preview-window right:75%  --preview "git diff --color=always {}" | xargs -0 -t -o git add'
  alias fgco='git ls-files -m -o --exclude-standard | fzf --height=50% --print0 -m --preview-window right:75%  --preview "git diff --color=always {}" | xargs -0 -t -o git checkout'
  alias fgb='git branch | grep -v "^\*" | fzf --height=40% --reverse --info=inline | xargs git checkout'
else 
fi
alias ga='git add -A'
alias gb='git branch'
alias gc='git commit'
alias gca='git commit --amend'
alias gco='git checkout'
alias gd='git diff'
alias gdi='git diff --ignore-space-change'
alias gf='git fetch'
alias gl='git pull --prune'
alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"
alias gp='git push'
alias gpo="git push origin"
alias gpmr="git push -o merge_request.create"
alias gs='git status -sb' # upgrade your git if -sb breaks for you. it's fun.
alias grm="git status | grep deleted | awk '{print \$3}' | xargs git rm"
alias gu="git reset --soft HEAD^"
alias gsa="git stash apply"
alias gss="git stash save"

