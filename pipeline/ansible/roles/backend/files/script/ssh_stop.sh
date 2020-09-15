#!/bin/bash
deploy_port=$1
echo "$deploy_port"

intid=`/usr/bin/lsof -n -P -t -i:${deploy_port}`
#[ -n "${intid}" ] && kill -9 ${intid}

if [ ! -n "${intid}" ]; then
   echo "No process is started, the port is free!"
else
   echo "Kill the process!"
   [ -n "${intid}" ] && kill -9 ${intid}
fi