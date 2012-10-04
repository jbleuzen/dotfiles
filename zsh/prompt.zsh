autoload colors && colors
# cheers, @ehrenmurdick
# http://github.com/ehrenmurdick/config/blob/master/zsh/prompt.zsh

# Git prompt configuration
GIT_PROMPT_PREFIX="%{$reset_color%}("
GIT_PROMPT_SUFFIX="%{$reset_color%})"
GIT_PROMPT_DIRTY="%{$fg_bold[red]%}✗ "
GIT_PROMPT_CLEAN="%{$fg_bold[green]%}✔ "

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

	# Are we on a remote-tracking branch?
	remote=${$(git rev-parse --verify ${hook_com[branch]}@{upstream} \
		--symbolic-full-name 2>/dev/null)/refs\/remotes\/}

	if [[ -n ${remote} ]] ; then

		unstaged=$(git status -sb 2> /dev/null 2> /dev/null | grep "?" | wc -l | tr -s " ")
		(( $unstaged )) && gitstatus+=( "%F{yellow}✚${unstaged}" )

		# for git prior to 1.7
		# ahead=$(git rev-list origin/${hook_com[branch]}..HEAD | wc -l)
		ahead=$(git rev-list ${hook_com[branch]}@{upstream}..HEAD 2>/dev/null | wc -l | tr -s " ")
		(( $ahead )) && gitstatus+=( "%F{cyan}⬆${ahead}%{$reset_color%}" )

		# for git prior to 1.7
		# behind=$(git rev-list HEAD..origin/${hook_com[branch]} | wc -l)
		behind=$(git rev-list HEAD..${hook_com[branch]}@{upstream} 2>/dev/null | wc -l | tr -s " ")
		(( $behind )) && gitstatus+=( "%F{magenta}⬇${behind}%{$reset_color%}" )

		if [[ -n ${gitstatus} ]]; then
			echo " "${(j:|:)gitstatus}
		fi
	fi
} 

# get the name of the branch we are on
git_prompt_info() {
	ref=$(git symbolic-ref HEAD 2> /dev/null) || return
	echo " $GIT_PROMPT_PREFIX$(git_dirty)${ref#refs/heads/}$(git_status)$GIT_PROMPT_SUFFIX"
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

PROMPT=$'%{$fg_bold[$NCOLOR]%}%n%{$reset_color%}@%{$fg_bold[red]%}%m%{$reset_color%}:%{$fg_bold[green]%}%~ %{$reset_color%}'
RPROMPT='%{$reset_color%}$(git_prompt_info) %*%{$reset_color%}'

# See http://geoff.greer.fm/lscolors/
export LSCOLORS="exfxcxdxbxbxbxbxbxbxbx"
export LS_COLORS="di=34;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=31;40:cd=31;40:su=31;40:sg=31;40:tw=31;40:ow=31;40:"
