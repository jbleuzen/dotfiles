function fish_prompt
# Clear the line because fish seems to emit the prompt twice. The initial
# display, then when you press enter.
  set -l rc $status

  if test -n "$SSH_CONNECTION"
    set_color 2266FF
    printf '%s' (whoami)
    set_color white
    printf '@'
    set_color red
    printf '%s ' (hostname -s)
  end

  if test $rc = 0
    set_color green
  else 
    set_color red
  end
  printf "❯ "

  if test $USER = "root"
    set_color red
    printf "%s " (pwd)
  else 
    set_color green
    printf "%s " (fish_prompt_short_pwd)
  end
  set_color normal
end

function parse_git_branch
  set fish_git_dirty_color magenta
  set fish_git_clean_color green
  set -l branch (git branch 2> /dev/null | grep -e '\* ' | sed 's/^..\(.*\)/\1/')
  set -l git_status (git status -s 2> /dev/null)

  if test -n "$git_status"
    printf '%s' (set_color $fish_git_dirty_color)$branch(set_color normal)
  else
    printf "%s" (set_color $fish_git_clean_color)$branch(set_color normal)
  end
end

function fish_prompt_short_pwd --description 'Print the current working directory, shortened to fit the prompt'
  set -l args_pre -e 's|^/private/|/|'
  set -l realhome ~
  echo $PWD | sed -e "s|^$realhome|~|" $args_pre -e 's-\([^/.]\)[^/]*/-\1/-g' 
end

function fish_right_prompt --description lil
  set -l time ( set_color 6B6B6B)(date "+%_H:%M:%S")
	set -l branch (git rev-parse --abbrev-ref HEAD ^/dev/null)
	set_color magenta
  printf '%s %s' (parse_git_branch) $time
end

