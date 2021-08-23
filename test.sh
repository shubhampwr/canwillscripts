#!/bin/bash
abc="echo 'SHOW VARIABLES WHERE VARIABLE_NAME = 'event_scheduler'; ' | mysql"
ssh -i local.pem root@$1 $abc
