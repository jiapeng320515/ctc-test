# !/usr/bin/bash
env=$1
package_name=$2
service_name=$3
deploy_root_path=$4
upload_directory=$5
config_directory=$6
outlog_directory=$7
jmxremote_port=$8
Xms=$9
Xmx=${10}

jparam="-Duser.timezone=Asia/Shanghai -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false -jar"
echo "$env"
echo "$package_name"
echo "$service_name"
echo "$deploy_root_path"
echo "$upload_directory"
echo "$config_directory"
echo "$jmxremote_port"
echo "$Xms"
echo "$Xmx"

cd ${deploy_root_path}
source /etc/profile
echo "nohup java -Dcom.sun.management.jmxremote.port=$jmxremote_port -$Xms -$Xmx $jparam $upload_directory/$package_name --spring.config.location=$config_directory/$service_name-$env.yml > $outlog_directory/$service_name.out 2>&1 &"
nohup java -Dcom.sun.management.jmxremote.port=$jmxremote_port -$Xms -$Xmx $jparam $upload_directory/$package_name --spring.config.location=$config_directory/$service_name-$env.yml > $outlog_directory/$service_name.out 2>&1 &