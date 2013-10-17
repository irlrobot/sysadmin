#!/usr/local/bin/ruby
#
# Expects hosts.txt and commands.txt in same directory
# gem net-ssh should be installed
#
# hosts.txt
# On each line put the username with access followed by a space and then the hostname
# You should have public key authentication already setup on the host for the user specified
# For example "josh splunk01.domain"
#
# commands.txt
# Each command should be on one line, commands are run sequentially not in parrallel
# For example "sudo yum update -y"
#

require 'rubygems'
require 'net/ssh'

def ssh_exec(hostname, username, command)
  ssh = Net::SSH.start(hostname, username)
  ssh.open_channel do |channel|
      channel.request_pty do |c, success|
        if success
          c.exec(command)
          c.on_data do |ch, data|
            puts data
          end
        else
          puts "Failed to connect!"
        end
      end
    end
  ssh.close()
end

File.open("hosts.txt").each_line do |host|
  username = host.split[0]
  hostname = host.split[1]
  puts "--------------------------------------------------"
  puts "--------------------------------------------------"
  puts "Deploying to #{hostname}"

  File.open("commands.txt").each_line do |command|
    puts "--------------------------------------------------"
    puts command  
    puts "--------------------------------------------------"
    ssh_exec(hostname, username, command)
  end 
end
