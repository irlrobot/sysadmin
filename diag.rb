#!/usr/local/bin/ruby

def doLookup(device)
  puts `nslookup #{device}`  
end

def doPing(device)
  puts `ping -c 2 #{device}`
end

def doPortScan(device)
  puts `nmap -p T:22,25,80,443,4443,8000,8080 #{device}`  
end

input = ARGV[0].chomp

puts "============================="
puts "DNS Info"
puts "============================="
doLookup(input)
puts "============================="
puts "Ping Check"
puts "============================="
doPing(input)
puts "============================="
puts "Port Scan"
puts "============================="
doPortScan(input)
puts "============================="
