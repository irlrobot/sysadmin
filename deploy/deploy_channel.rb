#!/usr/bin/ruby
require 'rubygems'
require 'net/ssh'

File.open("hosts.txt").each_line do |host|
  puts "Deploying to #{host}"
  puts "--------------------------------------------------"

  ssh = Net::SSH.start(host.chomp, "jocampbell")

#this is currently broken
    File.open("commands.txt").each_line do |command|
      ssh.open_channel do |channel|
        channel.request_pty do |c, success|
          if success
            c.exec(command.chomp)
          end
        end
      end
    end

  puts "--------------------------------------------------"

  ssh.close()
end
