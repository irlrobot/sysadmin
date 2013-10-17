#
#Aliases
#
alias ll='ls -lah'
alias vi='vim'

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
