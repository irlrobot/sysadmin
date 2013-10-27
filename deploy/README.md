#About
deploy.rb is used to send one or more commands to one or more hosts, both in the order they are specified. You can use any command that would work on the destination hosts; typically this will be a bash command, but could be anything the host(s) can actually run. deploy.rb depends on SSH public key authentication that has already been setup to the host(s) you are running the command(s) on.  

By design, command(s) will be run in order sequentially on the host(s) specified and not in parrallel.  This allows you to establish dependencies (e.g. host2 can't be configured until host1 has been successfuly configured).  If you want commands run in parrallel there are other better solutions out there.
#Usage
To run a single command across one or more hosts, simply run deploy.rb with a command and then a list of hosts.<br>
Example:<br>
./deploy.rb uptime host1 host2 host3<br>
./deploy.rb "sudo yum -y update" host1 host2 host3<br>

Unless specifying arguments from the command line, deploy.rb expects commands and hosts to be specified in two files:  commands.txt and hosts.txt. These files must be in the same directory as deploy.rb.

##commands.txt
Each line in commands.txt should contain one complete command.  See the included example in the repository.

##hosts.txt
Each line in hosts.txt should contain the username the SSH connection will be made under followed by a space and the hostname. See the included example in the repository.
