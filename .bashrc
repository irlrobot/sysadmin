#
#Aliases
#
alias ll='ls -lah'
alias vi='vim'
alias gh='cd ~/Documents/github/'
alias notes='cd ~/Dropbox/NOTES/'
alias webs='ruby -run -e httpd . -p 8888'
alias disk='du -sgcx * | sort -n'
alias cpu='ps -eo pcpu,pid,user,args | sort -k 1 -r | head -6'

#
#history
#
export HISTSIZE=10000

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

#
# path junk
#

#PATH="/Applications/Postgres93.app/Contents/MacOS/bin:$PATH"
#export PATH="/usr/local/heroku/bin:$PATH"
#PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

PATH=$HOME/.rvm/bin:/usr/local/bin:/usr/local/heroku/bin:/Applications/Postgres93.app/Contents/MacOS/bin:~/bin/:$PATH
