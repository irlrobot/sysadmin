#
#Aliases
#
alias ll='ls -Glah'
alias vi='vim'
alias webs='ruby -run -e httpd . -p 8888'
alias disk='du -sgcx * | sort -n'
alias cpu='ps -eo pcpu,pid,user,args | sort -k 1 -r | head -6'
alias curltime='curl -w "\n\ntime_namelookup: %{time_namelookup}\ntime_connect: %{time_connect}\ntime_appconnect: %{time_appconnect}\ntime_pretransfer: %{time_pretransfer}\ntime_redirect: %{time_redirect}\ntime_starttransfer: %{time_starttransfer}\n----------\ntime_total:  %{time_total}\n"'

#
# export some stuff
#
export VMSIZE='auto'
export WCOLL=~/Desktop/hosts.txt

# helps if gui text editor is default editor
alias ecron='env EDITOR=vim crontab -e'

# git goodies
alias gl="git log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
alias gh='cd ~/fedora_dev/repos'
alias gb='git branch'
alias gm='git merge --no-ff'
alias gco='git checkout'
alias gs='git status'
alias gp='git pull --rebase'
alias cb='git rev-parse --abbrev-ref HEAD'

#
#history
#
export HISTSIZE=100000
# avoid duplicates..
export HISTCONTROL=ignoredups:erasedups
# append history entries..
shopt -s histappend
# After each command, save and reload history
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

#
# set atom as editor
#
export EDITOR='atom --wait'

#
#generate a random pass
#
randompass() {
  LANG=C
  local l=$1
  [ “$l” == “” ] && l=20
  tr -dc A-Za-z0-9_ < /dev/urandom | head -c ${l} | xargs
}

#
# change OSX bash prompt
#
export PS1="[\\u@\h \\W]\\$ "

#
# path
#
PATH=$HOME/.rvm/bin:/usr/local/bin:~/bin:$PATH
