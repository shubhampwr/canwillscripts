#!/bin/bash
DATE=$(date "+%D")
STATUS=$(systemctl is-active nginx)

echo $STATUS

if [[ $STATUS == "failed"   ]]
then
	echo "nginx is failed"
	tail  -n 20 /var/log/nginx/error.log >> /var/log/nginx/nginx_cron_log.txt
	sudo service php7.4-fpm restart
	rm -rf /var/cache/nginx/fastcgi_temp/cache/*
	sudo service nginx restart

else
	echo "ok"
fi
