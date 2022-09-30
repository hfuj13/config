umask 002

## If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

stty -ixon -ixoff
set bell-style none

export HISTSIZE=10000

## history にコマンド実行時刻を記録する
HISTTIMEFORMAT='%Y-%m-%dT%T '

## 空白文字で始まる行を保存しないかつひとつ前の履歴エントリと一致する行を保存しない
HISTCONTROL=ignoreboth

### コマンド履歴を複数端末で共有。e.g. screen等
#function share_history {
#    history -a
#    history -c
#    history -r
#}
#export PROMPT_COMMAND="share_history"
#shopt -u histappend

## コマンドを実行した際に、端末画面の大きさをチェックしてシェル変数LINESとCOLUMNSの値を更新する
shopt -s checkwinsize

## 対話シェルが終了する前に、停止中や実行中のジョブの状態を表示する
shopt -s checkjobs 

export LOCKPRG='/bin/true'
case "$TERM" in
  screen*)
    if [[ -z "$STY" ]]; then
      __SCREEN_TITLE='\[\033k\h:\W\033\134\]'
#      __SCREEN_TITLE='\[\033k\W\033\134\]'
    else
#      __SCREEN_TITLE='\[\033k\W\033\134\]'
      __SCREEN_TITLE='\[\033k\h:\W\033\134\]'
    fi
  ;;
esac

PS1="\u@\h:\w\$ $__SCREEN_TITLE"

## enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

## enable programmable completion features (you don't need to enable
## this, if it's already enabled in /etc/bash.bashrc and /etc/profile
## sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export GOPATH=~/go
export GOBIN=~/go/bin

PATH=~/bin
PATH=$PATH:/usr/local/bin
PATH=$PATH:$GOBIN
PATH=$PATH:/opt/rust/bin
PATH=$PATH:/opt/vim9/bin
PATH=$PATH:/opt/nim/bin
PATH=$PATH:/opt/eclipse/java-2020-06/eclipse:/var/lib/flatpak/exports/bin
PATH=$PATH:/snap/bin
PATH=$PATH:/usr/lib/go-1.19/bin
PATH=$PATH:/usr/bin
PATH=$PATH:/usr/local/sbin:/usr/sbin

export USER_ID=`id -u`
export GROUP_ID=`id -g`
export USER_NAME=`whoami`
