#Intro
This is a collection of howto's, tips, tricks, and tools for troubleshooting Linux issues.  Some of it is from personal experience, but most of it is found from other blogs, forums, and the like.  Credit and citations are given at the bottom of each section where information may have come from.  If I didn't thank you personally when I found your tip/trick/tool then I'll say it here.  Thanks!

#Tools
Make sure these are available:<br>
sysstat (this package will include iostat and vmstat)<br>
strace<br>
tcpdump<br>

#CPU
nproc<br>
See number of processors

lscpu<br>
See more CPU info

cat /proc/cpuinfo<br>
See even more CPU info

sar -u 1<br>
Check CPU usage every second

top

##Load Average
uptime<br>
The 3 sets of numbers represent one, five and fifteen minute averages (in that order).

Check number of processors first.  Under N means you're under capacity, at N you're at capacity, over N you've got backup occurring.  Pay most attention to 5 and 15 minute averages.  If you're like 3xN load average for 15 minutes you have a problem to fix for sure because you're likely seeing really bad slowdown.

##CPU-Credits
http://blog.scoutapp.com/articles/2009/07/31/understanding-load-averages<br>
http://www.thegeekstuff.com/2011/03/sar-examples/

#Memory

free<br>
See memory info (can use -m or -g for MB and GB respectively)

cat /proc/meminfo<br>
See even more memory info

ps -aux <br>
RSS column is the RAM consumed by each process.  Higher RSS = using more RAM.

##Swapping
Swapping is not caused by any particular process.  A process that is swapping is simply swapping because there is no free RAM left, whether it is responsible or not for running the system out of memory.  So a swapping process can either be the bloated problem child or the tiniest process on the system that just happened to get swapped.  When you run out of memory you swap, simple as that.

Use free -m and check the used column on the Swap row

Use vmstat 1 and look at the si and so columns.  si is memory swapped into RAM from disk and so is to disk from RAM (per second for both when using vmstat 1).  This lets you verify you're swapping.

##Memory-Credits
http://www.quora.com/How-can-I-determine-which-process-is-contributing-to-paging-on-Linux - 1st Answer by Robert Love

#Networking
netstat -puntl<br>
See all TCP and UDP ports listening

netstat -at<br>
All TCP ports

netstat -au<br>
All UDP ports

netstat -c<br>
Print info continuously

lsof | grep LISTEN <br>
Also find things that may be listening...

tcpdump icmp <br>
Who's pinging me?

tcpdump tcp <br>
TCP traffic

tcpdump port 443 <br>
Monitor a specific port

tcpdump portrange 20-25<br>
Monitor a range of ports

tcpdump port 443 -w captureFileName <br>
Record the capture to a file

tcpdump -i eth1 icmp <br>
Specify a certain interface

##Networking-Credits
http://www.thegeekstuff.com/2010/03/netstat-command-examples/ 

#Storage
iostat -mdx 1 <br>
Show extended disk info in MB/s every second

dd if=/dev/zero of=test bs=1G count=1 <br>
Measure performance by writing a 1GB file

dd if=/dev/zero of=test bs=1G count=1 oflag=dsync <br>
Same as above but using dsync skips cache

##Storage-Credits
http://www.thomas-krenn.com/en/wiki/Linux_I/O_Performance_Tests_using_dd

#Strace
strace -p PID <br>
Where PID is the process ID in question (ps aux | grep name).  What is that process doing right now?

strace -c -p PID <br>
Where PID is the process ID in question (ps aux | grep name).  What is the process spending time on?

strace -ttT program/script <br>
Run a trace on the program/script and output to the screen (redirect to a file is usually desired here).  Prefix line with time including microseconds and show the time spent in system calls.

##Strace-Credits
http://www.hokstad.com/5-simple-ways-to-troubleshoot-using-strace<br>
https://blogs.oracle.com/ksplice/entry/strace_the_sysadmin_s_microscope

#MySQL
create user that can only connect lcoally and give full perms on a DB<br>
````grant ALL PRIVILEGES on databasename.* to user@localhost;````
		
just a table <br>
````grant ALL PRIVILEGES on database.table to user@localhost;````
		
set password <br>
````set password for user = password('thePassowrd');````
		
cleanup <br>
````flush privileges;````
		
create superuser that can connect from anywhere <br>
````grant ALL PRIVILEGES on *.* TO 'user'@'%' IDENTIFIED BY 'password' WITH GRANT OPTION;````
