#!/usr/bin/bash
echo '--- Execute shell ---'
upload_directory=$1
current_job_name=$2
current_build_number=$3
package_name=$4
local_path=$upload_directory/$package_name
remote_name=$current_job_name-$current_build_number
remote_latest_name=$current_job_name-latest

echo "$local_path"
echo "$remote_name"
echo "python /usr/local/archive/insert_file.py $local_path $remote_name"
echo "python /usr/local/archive/insert_file.py $local_path $remote_latest_name"
echo '---MongoDB Upload Start ---'

cd /usr/local/archive
python /usr/local/archive/insert_file.py $local_path $remote_name

echo '---MongoDB Upload End---'

echo '--- Execute shell finished ---'
