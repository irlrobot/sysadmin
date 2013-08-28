#!/bin/bash
#
#grab some quick diagnostics
#
#ping -o may not work on all systems
#but seems to work ok on OSX
#
#Josh C 
#https://github.com/irlrobot
#

function doPing {
  if ping -o $1 > /dev/null; then
    echo "System is up" 
  else
    echo "System is down!"
  fi
}

function doLookup {
  nslookup -type=ANY $1
}

#add some common ports
#in your environment
function doPortScan {
  nmap -p T:22,25,80,443,4443,8000,8080 $1
}

echo "DNS info:"
doLookup $1
echo "=========="
doPing $1
echo "=========="
doPortScan $1
echo "=========="
