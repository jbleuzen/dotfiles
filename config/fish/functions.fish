# Alias
function r             ; source ~/.config/fish/config.fish ; end
function d             ; cd ~/.dotfiles ; end

function -             ; cd - ; end
function ..            ; cd .. ; end

function ls
  # edit for osx ls
  command ls -lFh --color=auto --group-directories-first --time-style=long-iso --indicator-style=none $argv
end
function l             ; ls $argv ; end

function df            ; df -h  $argv ; end
function du            ; du -h $argv ; end
function grep          ; command grep --color $argv ; end
function ip            ; dig +short myip.opendns.com @resolver1.opendns.com ; end
function rake          ; noglob rake $argv ; end
function mkdir         ; command mkdir -p $argv; cd $argv ; end

function json          ; python -m json.tool ; end

# Git aliases
function gs            ; git status -sb ; end
function ga            ; git add -A ; end
function gco           ; git checkout $argv ; end
function gc            ; git commit -m $argv ; end
function gd            ; git diff ; end
function gp						 ; git push $argv ; end
function gf            ; git fetch ; end
function gl            ; git pull --prune ; end
function glog          ; git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative ; end
function gsl           ; git stash list ; end
function gss           ; git stash save ; end
function gsp           ; git stash pop ; end
function gsa           ; git stash apply ; end

# Tmux aliases
function t             ; tmux ; end
function ta            ; tmux attach -t $argv ; end
function tk            ; tmux kill-session -t $argv ; end
function tl            ; tmux ls ; end
function tn            ; tmux new -s $argv ; end
function ts            ; tmux switch -t $argv ; end
