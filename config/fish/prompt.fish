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

function fish_prompt_short_pwd --description 'Print the current working directory, shortened to fit the prompt'
  set -l args_pre -e 's|^/private/|/|'
  set -l realhome ~
  echo $PWD | sed -e "s|^$realhome|~|" $args_pre -e 's-\([^/.]\)[^/]*/-\1/-g' 
end

function fish_right_prompt --description lil
  set -l time ( set_color 6B6B6B)(date "+%_H:%M:%S")
	set -l branch (git rev-parse --abbrev-ref HEAD ^/dev/null)
	set_color magenta
	set -l index (git status --porcelain ^/dev/null|cut -c 1-2|sort -u)
  printf '%s %s' $branch $time
end

