#
#Aliases
#
alias ll='ls -Glah'
alias vi='vim'
alias webs='ruby -run -e httpd . -p 8888'
alias disk='du -sgcx * | sort -n'
alias cpu='ps -eo pcpu,pid,user,args | sort -k 1 -r | head -6'
alias curltime='curl -w "\n\ntime_namelookup: %{time_namelookup}\ntime_connect: %{time_connect}\ntime_appconnect: %{time_appconnect}\ntime_pretransfer: %{time_pretransfer}\ntime_redirect: %{time_redirect}\ntime_starttransfer: %{time_starttransfer}\n----------\ntime_total:  %{time_total}\n"'

# helps if sublime is default editor
alias ecron='env EDITOR=vim crontab -e'

# git goodies
alias gl="git log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
alias gh='cd ~/Documents/github/'
alias gb='git branch'
alias gm='git merge --no-ff'
alias gco='git checkout'
alias gs='git status'

#
#history
#
export HISTSIZE=10000

#
# set sublime as editor
#
export EDITOR='subl -w'

#
#generate a random pass
#
randompass() {
  LANG=C
  local l=$1
  [ “$l” == “” ] && l=12
  tr -dc A-Za-z0-9_ < /dev/urandom | head -c ${l} | xargs
}

#
# screen tomfoolery for osx
#
setscreentitletohost() {
  if [ "$TERM" == "screen" ]
    then
      echo -ne "\033k$HOSTNAME$\033\\"
  fi                
}                                                                                                       
setscreentitletohost

ssh() {                           
  inargs="$@"                  
  if [ "$TERM" == "screen" ]
    then                
      host="${inargs#*@}"
      host="${host% *}"
      user="${inargs%@*}"
      user="${user#* }"
    if [ "$user" == "root" ]                             
      then       
        host="$host#"
    else
      host="$host$"
    fi
  echo -ne "\033k$host\033\\"                     
  fi

  /usr/bin/ssh -A $inargs
  setscreentitletohost
}

#
# path
#
PATH=$HOME/.rvm/bin:/usr/local/bin:~/bin:$PATH
