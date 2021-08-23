#!/bin/bash
scp -i local.pem local.pem root@$1:/root

echo "Copied == Done"
ssh -i local.pem root@$1 chmod 400 /root/local.pem

echo "Changing permission == Done"

echo -i "taking access:\n"
ssh -i local.pem $1

