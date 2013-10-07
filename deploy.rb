#!/usr/bin/ruby
require 'rubygems'
require 'net/ssh'

File.open("hosts.txt").each_line do |host|
  puts "Deploying to #{host}"

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
