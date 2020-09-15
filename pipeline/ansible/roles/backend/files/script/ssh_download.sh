#!/usr/bin/bash
echo '--- Execute shell ---'
job_name=$1
service_name=$2
build_number=$3
package_name=$4
upload_directory=$5
local_path=$upload_directory/$package_name
remote_name=$job_name-$service_name-$build_number

echo "$job_name"
echo "$service_name"
echo "$build_number"
echo "$package_name"
echo "$upload_directory"

echo "$local_path"
echo "$remote_name"
echo "python /usr/local/archive/get_file.py $local_path $remote_name"

echo '---MongoDB Download Start ---'

cd /usr/local/archive
python /usr/local/archive/get_file.py $local_path $remote_name

echo '---MongoDB Download End---'

echo '--- Execute shell finished ---'