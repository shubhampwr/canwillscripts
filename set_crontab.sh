#!/bin/bash
scp -i local.pem nginx_monitor.sh root@$1:/root  
ssh -i local.pem root@$1 "echo '*/2  *  *  *  *   bash /root/nginx_monitor.sh' >> /var/spool/cron/crontabs/root"
ssh -i local.pem root@$1 crontab -l
