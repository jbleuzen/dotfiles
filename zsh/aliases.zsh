alias reload!='. ~/.zshrc'

# Find the option for using colors in ls, depending on the version: Linux or BSD
ls --color -d . &>/dev/null 2>&1 && alias ls='ls --color=tty -h' || alias ls='ls -Gh'
alias ll='ls -l'
alias l='ll'
alias la='ls -la'

# for rake task with argument
alias rake='noglob rake'
