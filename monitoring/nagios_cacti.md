Add epel repo

#Nagios
yum -y install nagios nagios-plugins-all nagios-plugins-nrpe nrpe php httpd 
htpasswd -c /etc/nagios/passwd nagiosadmin

Change check_http command in objects/commands.cfg to look like
# 'check_http' command definition
define command{
        command_name    check_http
        command_line    $USER1$/check_http -H $HOSTADDRESS$ -f follow -t 60 $ARG1$
        }

##Sample Nagios config
```
define host{
        use                             generic-host
        host_name                       www.groupon.com
        alias                           www.groupon.com
        address                         www.groupon.com
        max_check_attempts              5
}

define host{
        use                             generic-host
        host_name                       origin.groupon.com
        alias                           origin.groupon.com
        address                         origin.groupon.com
        max_check_attempts              5
}

define host{
        use                             generic-host
        host_name                       api.groupon.com
        alias                           api.groupon.com
        address                         api.groupon.com
        max_check_attempts              5
}

define service{
        use                             generic-service
        host_name                       www.groupon.com
        service_description             HTTP
        check_command                   check_http
        notifications_enabled           0
        }

define service{
        use                             generic-service
        host_name                       origin.groupon.com
        service_description             HTTP
        check_command                   check_http
        notifications_enabled           0
}

define service{
        use                             generic-service
        host_name                       api.groupon.com
        service_description             HTTP
        check_command                   check_http
        notifications_enabled           0
}

define hostgroup{
        hostgroup_name                  websites
        alias                           Web Sites
        members                         www.groupon.com,origin.groupon.com,api.groupon.com
        }

define servicegroup{
        servicegroup_name               websites
        alias                           Web Sites
        members                         www.groupon.com,HTTP,origin.groupon.com,HTTP,api.groupon.com,HTTP
}
```

##Nagios Install Credit
https://www.digitalocean.com/community/articles/how-to-install-nagios-on-centos-6

#Cacti
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

##Cacti check_http.pl
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

###check_http.pl credit
http://blog.tersmitten.nl/cacti-http-response-time.html

##Cacti advanced ping
Install template

Add data source for host/device
###advanced ping credit
http://docs.cacti.net/usertemplate:graph:advanced_ping_alt

##Cacti Install Credit
http://forums.cacti.net/viewtopic.php?f=6&t=49363
