autoload colors && colors
# cheers, @ehrenmurdick
# http://github.com/ehrenmurdick/config/blob/master/zsh/prompt.zsh

# Git prompt configuration
ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}("
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%})"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[red]%}✗ "
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}✔ "

# Checks if working tree is dirty
parse_git_dirty() {
  if [[ -n $(git status -s --ignore-submodules=dirty 2> /dev/null) ]]; then
    echo "$ZSH_THEME_GIT_PROMPT_DIRTY"
  else
	  echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
  fi
}

# get the name of the branch we are on
git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    echo " $ZSH_THEME_GIT_PROMPT_PREFIX$(parse_git_dirty)${ref#refs/heads/}$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

# All kudos for precmd goes to Phil : http://aperiodic.net/phil/prompt/
function precmd {

  local TERMWIDTH
  (( TERMWIDTH = ${COLUMNS} - 1 ))

  local promptsize=${#${(%):-(%n@%m:%~)}}
  local datesize=${#${(%):-[%*–]}}

  # Handle the prompt size
  if [[ "$promptsize + $datesize" -gt $TERMWIDTH ]]; then
    ((PR_PWDLEN=$TERMWIDTH - $promptsize))
  else
    PR_FILLBAR="\${(l.(($TERMWIDTH - ($promptsize + $datesize - 3)))..${PR_HBAR}.)}"
  fi
}

if [ $UID -eq 0 ]; then NCOLOR="red"; else NCOLOR="blue"; fi

PROMPT=$'%{$fg_bold[$NCOLOR]%}%n%{$reset_color%}@%{$fg_bold[red]%}%m%{$reset_color%}:%~$ %{$fg_bold[white]%}'
RPROMPT='%{$reset_color%}$(git_prompt_info) %*%{$reset_color%}'

# See http://geoff.greer.fm/lscolors/
export LSCOLORS="exfxcxdxbxbxbxbxbxbxbx"
export LS_COLORS="di=34;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=31;40:cd=31;40:su=31;40:sg=31;40:tw=31;40:ow=31;40:"
