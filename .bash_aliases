# aliases
alias ll='ls -l'
alias la='ls -a'
#alias l='ls -CF'
alias rm='/bin/rm -i'
alias cp='/bin/cp -i'
alias mv='/bin/mv -i'
alias ..='cd ..'
alias dir='/bin/ls -l | grep ^d'
alias pu=pushd
alias po=popd
alias apti=aptitude
function crontab() {
  local opt
  for opt in "$@"; do
    if [[ $opt == -r ]]; then
      echo 'crontab -r is sealed!'
      return 1
    fi
  done
  command crontab "$@"
}

## manpage's colors
## Black       0;30     Dark Gray     1;30
## Blue        0;34     Light Blue    1;34
## Green       0;32     Light Green   1;32
## Cyan        0;36     Light Cyan    1;36
## Red         0;31     Light Red     1;31
## Purple      0;35     Light Purple  1;35
## Brown       0;33     Yellow        1;33
## Light Gray  0;37     White         1;37
##
#man() {
#  env \
#    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
#    LESS_TERMCAP_md=$(printf "\e[0;36m") \
#    LESS_TERMCAP_me=$(printf "\e[0m") \
#    LESS_TERMCAP_se=$(printf "\e[0m") \
#    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
#    LESS_TERMCAP_ue=$(printf "\e[0m") \
#    LESS_TERMCAP_us=$(printf "\e[1;34m") \
#    man "$@"
#}
