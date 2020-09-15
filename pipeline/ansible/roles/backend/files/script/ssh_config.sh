#!/usr/bin/bash
upload_directory=$1
package_name=$2
env=$3
echo "$upload_directory"
echo "$package_name"
echo "$env"
cd ${upload_directory}
source /etc/profile
jar xf ${package_name} application-${env}.yml template
