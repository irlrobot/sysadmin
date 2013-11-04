#
#Aliases
#
alias ll='ls -lah'
alias vi='vim'
alias gh='cd ~/Documents/github/'

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

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

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
