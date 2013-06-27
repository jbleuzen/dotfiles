autoload colors && colors
# cheers, @ehrenmurdick
# http://github.com/ehrenmurdick/config/blob/master/zsh/prompt.zsh

# Git prompt configuration
GIT_PROMPT_DIRTY="%F{red}"
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

	# Are we on a remote-tracking branch?
	remote=${$(git rev-parse --verify ${hook_com[branch]}@{upstream} \
		--symbolic-full-name 2>/dev/null)/refs\/remotes\/}

	if [[ -n ${remote} ]] ; then

		modified=$(git diff --name-only 2> /dev/null | wc -l | sed -e 's/^[ \t]*//')
		(( $modified )) && gitstatus+=("%F{blue}•${modified}")

		unstaged=$(git status -sb 2> /dev/null | grep "?" | wc -l | sed -e 's/^[ \t]*//')
		(( $unstaged )) && gitstatus+=("%F{yellow}+${unstaged}")

		# for git prior to 1.7
		# ahead=$(git rev-list origin/${hook_com[branch]}..HEAD | wc -l)
		ahead=$(git rev-list ${hook_com[branch]}@{upstream}..HEAD 2>/dev/null | wc -l | sed -e 's/^[ \t]*//')
		(( $ahead )) && gitstatus+=("%F{cyan}⬆ ${ahead}")

		# for git prior to 1.7
		# behind=$(git rev-list HEAD..origin/${hook_com[branch]} | wc -l)
		behind=$(git rev-list HEAD..${hook_com[branch]}@{upstream} 2>/dev/null | wc -l | sed -e 's/^[ \t]*//')
		(( $behind )) && gitstatus+=("%F{magenta}⬇ ${behind}")

		if [[ -n ${gitstatus} ]]; then
			echo " "${(j:%f|:)gitstatus}
		fi
	fi
} 

# get the name of the branch we are on
git_prompt_info() {
	ref=$(git symbolic-ref HEAD 2> /dev/null) || return
	echo " $(git_dirty)${ref#refs/heads/}$(git_status)%f"
}

# If root then the user is red in prompt
if [ $UID -eq 0 ]; then 
	USERNAMECOLOR="red"
	PATHCOLOR="%F{red}"
else 
	USERNAMECOLOR="blue"
	PATHCOLOR="%F{green}"
fi

SSH="%F{$USERNAMECOLOR}%n%f@%F{red}%m%f "

PROMPT='${SSH_TTY:+$SSH}%(?.%F{green}.%F{red})❯ $PATHCOLOR%~ %f'
RPROMPT='$(git_prompt_info) %F{245}%*'

# See http://geoff.greer.fm/lscolors/
export LSCOLORS="exfxcxdxbxbxbxbxbxbxbx"
export LS_COLORS="di=34;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=31;40:cd=31;40:su=31;40:sg=31;40:tw=31;40:ow=31;40:"
