#!/usr/bin/ruby
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
# For sudo, requiretty must be disabled in visudo, or try deploy.rb
#

require 'rubygems'
require 'net/ssh'

File.open("hosts.txt").each_line do |host|
  username = host.split[0]
  hostname = host.split[1]

  puts "Deploying to #{hostname}"

  ssh = Net::SSH.start(hostname, username)

  File.open("commands.txt").each_line do |command|
    puts "--------------------------------------------------"
    puts command
    puts "--------------------------------------------------"
    ssh.exec!(command.chomp) do |ch, stream, cmd|
      puts cmd
    end
  end

  puts "--------------------------------------------------"

  ssh.close()
end
