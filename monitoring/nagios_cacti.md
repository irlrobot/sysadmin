Add epel repo

=Nagios
yum -y install nagios nagios-plugins-all nagios-plugins-nrpe nrpe php httpd 
htpasswd -c /etc/nagios/passwd nagiosadmin

=Cacti
yum -y install httpd httpd-devel mysql mysql-server php-mysql php-pear php-common php-gd php-devel php php-mbstring php-cli php-mysql php-snmp net-snmp-utils p net-snmp-libs php-pear-Net-SMTP rrdtool unzip cacti

Setup mysql
mysql -u root -p
mysql> create database cactiuser;
mysql> GRANT ALL ON cacti.* TO cacti@localhost IDENTIFIED BY ‘cactiuser’;
mysql> FLUSH privileges;
mysql> quit;

Start mysql, apache, snmpd
mysql -u cacti -p cacti < rpm -ql cacti | grep cacti.sql
vi /etc/cacti/db.php (edit info near top)
$database_type = "mysql";
$database_default = "cacti";
$database_hostname = "localhost";
$database_username = "cacti";
$database_password = "your-password-here";
$database_port = "3306";
$database_ssl = false;

vi /etc/httpd/conf.d/cacti.conf
Change Allow from localhost to Allow from all

service httpd restart

vi /etc/cron.d/cacti
Uncomment

setup iptables

default cacti creds are admin/password

=Cacti check_http.pl
vi /usr/share/cacti/scripts/check_http.pl

#!/usr/bin/env perl
$response = `/usr/lib64/nagios/plugins/check_http -H $ARGV[0] -f follow -t 60`;
chomp $response;
($load) = ($response =~ /time=(\d+\.\d+|\d+\.|\.\d+|\d+)/);
print "$load\n";

chmod +x

Import template 

In cacti goto Graph Templates, Choose HTTP Reponse Time (nrpe)
Click on Item # 1, change Consolidation Function from LAST to AVERAGE

Add a device/host

Goto Data Sources add for this template and new host
Under Custom Data add the hostname/IP in the IP Address box
