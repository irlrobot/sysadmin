#Intro
This is a collection of howto's, tips, tricks, and tools for troubleshooting Linux issues.  Some of it is from personal experience, but most of it is found from other blogs, forums, and the like.  Credit and citations are given at the bottom of each section where information may have come from.  If I didn't thank you personally when I found your tip/trick/tool then I'll say it here.  Thanks!

#Tools
Make sure these are available<br>
sysstat (this package will include iostat and vmstat)<br>
strace<br>
tcpdump<br>

#CPU
nproc = see number of processors<br>
lscpu = see more CPU info<br>
cat /proc/cpuinfo = see even more CPU info<br>

sar -u 1 = check CPU usage<br>
top = duh

##Load Average
uptime = check

3 sets of numbers represent one, five and fifteen minute averages.

Check number of processors first.  Under N means you're under capacity, at N you're at capacity, over N you've got backup.  Pay most attention to 5 and 15 minute averages.  If you're like 3xN load average for 15 minutes you have a problem to fix for sure because you're likely seeing really bad slowdown.

##CPU-Credits
http://blog.scoutapp.com/articles/2009/07/31/understanding-load-averages<br>
http://www.thegeekstuff.com/2011/03/sar-examples/

#Memory

free = see memory info (can use -m or -g for MB and GB respectively)<br>
cat /proc/meminfo = see even more memory info

ps -aux 
RSS column is the RAM consumed by each process.  Higher RSS = using more RAM.

##Swapping
Swapping is not caused by any particular process.  A process that is swapping is simply swapping because there is no free RAM left, whether it is responsible or not for running the system out of memory.  So a swapping process can either be the bloated problem child or the tiniest process on the system that just happened to get swapped.  When you run out of memory you swap, simple as that.

Use free -m and check the used column on the Swap row

Use vmstat 1 and look at the si and so columns.  si is memory swapped into RAM from disk and so is to disk from RAM (per second for both when using vmstat 1).  This lets you verify you're swapping.

##Memory-Credits
http://www.quora.com/How-can-I-determine-which-process-is-contributing-to-paging-on-Linux - 1st Answer by Robert Love

#Networking
netstat -puntl = see all TCP and UDP ports listening<br>
netstat -at = all TCP ports<br>
netstat -au = all UDP ports<br>
netstat -c = print info continuously

##Networking-Credits
http://www.thegeekstuff.com/2010/03/netstat-command-examples/ 

#Storage
iostat<br>
dd if=/dev/zero of=test bs=1G count=1 = measure performance by writing a 1GB file<br>
dd if=/dev/zero of=test bs=1G count=1 oflag=dsync = using dsync skips cache

##Storage-Credits
http://www.thomas-krenn.com/en/wiki/Linux_I/O_Performance_Tests_using_dd

#Strace
strace -p PID = what is that process doing right now<br>
strace -c -p PID = what is the process spending time on?<br>
strace -ttT command/program/script = prefix line with time including microseconds and show the time spent in system calls

##Strace-Credits
http://www.hokstad.com/5-simple-ways-to-troubleshoot-using-strace<br>
https://blogs.oracle.com/ksplice/entry/strace_the_sysadmin_s_microscope
