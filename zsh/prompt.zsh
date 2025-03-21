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
  local ahead behind remote unstaged modified main gitstatus

  main=$(git status -sb)
  (( $(echo $main | grep " M " | wc -l) )) && gitstatus+=("%F{blue}●") # modified files
  (( $(echo $main | grep "?" | wc -l) )) && gitstatus+=("%F{208}✚") # untracked files

  # Are we on a remote-tracking branch?
  remote=$(git rev-parse --verify ${hook_com[branch]}@{upstream} --symbolic-full-name 2>/dev/null)

  if [[ -n ${remote} ]] ; then
		ahead=$(git rev-list ${hook_com[branch]}@{upstream}..HEAD 2>/dev/null | wc -l)
		(( $ahead )) && gitstatus+=("%F{green}󰁞")

		behind=$(git rev-list HEAD..${hook_com[branch]}@{upstream} 2>/dev/null | wc -l)
		(( $behind )) && gitstatus+=("%F{red}󰁆")

		if [[ -n ${gitstatus} ]]; then
			echo "${gitstatus}"
		fi
	fi
} 

# get the name of the branch we are on
git_prompt_info() {
  ref=$(git rev-parse --abbrev-ref HEAD 2> /dev/null) || return
  echo "$(git_dirty)${ref}$(git_status)%f"
}

# Customers named folders :D
CUSTOMERS_FOLDER=~/BLZN/Code/
if [ -d $CUSTOMERS_FOLDER ]; then
  for CUSTOMER in $(/bin/ls $CUSTOMERS_FOLDER | grep -v Icon  2> /dev/null); 
  do
    hash -d $CUSTOMER=${CUSTOMERS_FOLDER}${CUSTOMER}; 
  done
fi

# Display hostname if $SSH_TTY
HOSTNAME="%(!.%F{red}%n.%F{blue}%n)%f@%F{red}%m%f "
PATHNAME="%(!.%F{red}.%F{green})%~ %f"

PROMPT='${SSH_TTY:+$HOSTNAME}%(?.%F{green}.%F{red})❯ $PATHNAME'
RPROMPT='$(git_prompt_info) %F{240}%*'


if ls --color -d . >/dev/null 2>&1; then
  # GNU `ls`
  eval `dircolors ~/.dircolors`
else 
  # See http://geoff.greer.fm/lscolors/
  export LSCOLORS="exfxcxdxbxbxbxbxbxbxbx"
  export LS_COLORS="di=34;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=31;40:cd=31;40:su=31;40:sg=31;40:tw=31;40:ow=31;40:"
fi
