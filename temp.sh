#!/bin/bash

for i in `cat sites`
do
	ssh -i local.pem root@$i cat /etc/os-release 
done
