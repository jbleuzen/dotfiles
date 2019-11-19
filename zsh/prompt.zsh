autoload colors && colors
# cheers, @ehrenmurdick
# *ttp://github.com/ehrenmurdick/config/blob/master/zsh/prompt.zsh

# Git prompt configuration
GIT_PROMPT_DIRTY="%F{magenta}"
GIT_PROMPT_CLEAN="%F{green}"

# Checks if working tree is dirty
git_dirty() {
  if [[ -n $(git status -s --ignore-submodules=dirty 2> /dev/null) ]]; then
    echo "$GIT_PROMPT_DIRTY"
  else
    echo "$GIT_PROMPT_CLEAN"
  fi
}

git_status() {
  local ahead behind remote unstaged
  local -a gitstatus

  modified=$(git diff --name-only 2> /dev/null | wc -l) 
  (( $modified )) && gitstatus+=("%F{blue}•")

  unstaged=$(git status -sb 2> /dev/null | grep "?" | wc -l) 
  (( $unstaged )) && gitstatus+=("%F{yellow}✚")

  # Are we on a remote-tracking branch?
  remote=${$(git rev-parse --verify ${hook_com[branch]}@{upstream} \
    --symbolic-full-name 2>/dev/null)/refs\/remotes\/}

  if [[ -n ${remote} ]] ; then
		# for git prior to 1.7
		# ahead=$(git rev-list origin/${hook_com[branch]}..HEAD | wc -l)
		ahead=$(git rev-list ${hook_com[branch]}@{upstream}..HEAD 2>/dev/null | wc -l)
		(( $ahead )) && gitstatus+=("%F{cyan}⬆")

		# for git prior to 1.7
		# behind=$(git rev-list HEAD..origin/${hook_com[branch]} | wc -l)
		behind=$(git rev-list HEAD..${hook_com[branch]}@{upstream} 2>/dev/null | wc -l)
		(( $behind )) && gitstatus+=("%F{magenta}⬇")

		if [[ -n ${gitstatus} ]]; then
			echo " "${gitstatus}
		fi
	fi
} 

# get the name of the branch we are on
git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo " $(git_dirty)${ref#refs/heads/}$(git_status)%f"
}

contains() {
    string="$1"
    substring="$2"
    if test "${string#*$substring}" != "$string"
    then
        return 0    # $substring is in $string
    else
        return 1    # $substring is not in $string
    fi
}


# If root then the user is red in prompt
if [ $UID -eq 0 ]; then 
  USERNAMECOLOR="red"
else 
  USERNAMECOLOR="blue"
fi

#SSH="%F{$USERNAMECOLOR}%n%f@%F{red}%m%f "
SSH="%(!.%F{red}%n.%F{blue}%n)%f@%F{red%m%f}"

#PROMPT='${SSH_TTY:+$SSH}%(?.%F{green}.%F{red})❯ $PATHCOLOR%~ %f'
PROMPT='${SSH_TTY:+$SSH}%(?.%F{green}.%F{red})❯ %(!.%F{red}%~.%F{green}%(4~|…/%2~|%~)) %f'
RPROMPT='$(git_prompt_info) %F{245}%*'


if ls --color > /dev/null 2>&1; then 
  # GNU `ls`
  eval `dircolors ~/.dircolors`
else 
  # See http://geoff.greer.fm/lscolors/
  export LSCOLORS="exfxcxdxbxbxbxbxbxbxbx"
  export LS_COLORS="di=34;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=31;40:cd=31;40:su=31;40:sg=31;40:tw=31;40:ow=31;40:"
fi
