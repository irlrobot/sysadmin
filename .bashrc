#
#Aliases
#
alias ll='ls -lah'
alias vi='vim'
alias gh='cd ~/Documents/github/'
alias notes='subl ~/Dropbox/NOTES/'
alias webs='ruby -run -e httpd . -p 8888'
alias disk='du -sgcx * | sort -n'
alias cpu='ps -eo pcpu,pid,user,args | sort -k 1 -r | head -6'
alias gl="git log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
alias ecron='env EDITOR=vim crontab -e'

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
# screen tomfoolery
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

# bash completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

#
# path junk
#
PATH=$HOME/.rvm/bin:/usr/local/bin:~/bin:$PATH
