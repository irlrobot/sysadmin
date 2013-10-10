#!/usr/bin/ruby
#
# Expects hosts.txt and commands.txt in same directory
# hosts.txt = list of hosts to run commands on (one per line)
# commands.txt = commands to run on each host (one per line)
# For sudo, requiretty must be disabled in visudo, or try deploy_channel.rb
#

require 'rubygems'
require 'net/ssh'

File.open("hosts.txt").each_line do |host|
  puts "Deploying to #{host}"

# chanage jocampbell to your username
  ssh = Net::SSH.start(host.chomp, "jocampbell")

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
