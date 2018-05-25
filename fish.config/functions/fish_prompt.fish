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
