#!/bin/bash

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

echo "DNS info:"
doLookup $1
echo "=========="
doPing $1
echo "=========="
