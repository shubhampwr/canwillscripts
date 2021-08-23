#!/bin/bash
echo "Updating site : $1"
echo "taking backup..."
ssh -i local.pem root@$1  cp /etc/php/7.4/fpm/pool.d/www.conf /etc/php/7.4/fpm/pool.d/www.conf-backup
echo "Done"
echo "changing size ..."
ssh -i local.pem "root@$1"  'sed -i "s/^pm.start_servers = 20/pm.start_servers = 5/g" /etc/php/7.4/fpm/pool.d/www.conf'

ssh -i local.pem "root@$1"  'sed -i "s/^pm.min_spare_servers = 10/pm.min_spare_servers = 5/g" /etc/php/7.4/fpm/pool.d/www.conf'
echo "start server new value: "
ssh -i local.pem root@$1  cat /etc/php/7.4/fpm/pool.d/www.conf | grep -i "^pm.start_servers "
echo "spare server new value: "
ssh -i local.pem root@$1  cat /etc/php/7.4/fpm/pool.d/www.conf | grep -i "^pm.min_spare_servers "

echo "restarting fpm service .."
ssh -i local.pem root@$1  service php7.4-fpm restart
echo "done , clearing cache..."
ssh -i local.pem root@$1  rm -rf /var/cache/nginx/fastcgi_temp/cache/*
echo "done .. restarting nginx"
ssh -i local.pem root@$1  service nginx restart
echo "Done \n"

