#!/bin/bash

echo "-------------------$1-------------"
ssh -i local.pem root@$1 "echo \"SHOW VARIABLES WHERE VARIABLE_NAME = 'event_scheduler'; \" | mysql"
echo "Taking backup.."
ssh -i local.pem root@$1 "cp /etc/mysql/mysql.conf.d/mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf-backup"
echo "Done ... Changing setting.."
ssh -i local.pem root@$1 "echo event_scheduler = off >>  /etc/mysql/mysql.conf.d/mysqld.cnf"
echo "grep ------"\n
ssh -i local.pem root@$1 "cat /etc/mysql/mysql.conf.d/mysqld.cnf | grep event"
#echo "Done....Restarting Mysql"
ssh -i local.pem root@$1 "systemctl restart mysql"
#echo "done , clearing cache..."
ssh -i local.pem root@$1  rm -rf /var/cache/nginx/fastcgi_temp/cache/*
#echo "done .. restarting nginx"
ssh -i local.pem root@$1  service nginx restart
#echo "Done .. Checking mysql service is active ? "
ssh -i local.pem root@$1 "systemctl is-active mysql "
#echo "Done...Confirm"
ssh -i local.pem root@$1 "echo \"SHOW VARIABLES WHERE VARIABLE_NAME = 'event_scheduler'; \" | mysql"
#echo "Done"
echo "--------------------------------------------------"
