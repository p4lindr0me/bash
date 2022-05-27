#!/usr/bin/env bash

script_dir=$0
exec_dir=${script_dir::-8}

clear
echo "#-----REMOTE-SETTINGS-----#"
read -p "IP: " input_IP
read -p "user: " input_user
read -p "backup directory: " input_dir
read -p "port: " input_port
clear
echo "#-----LOCAL-SETTINGS-----#"
read -p "temp directory (stores backups before transfer): " input_tmp_dir
clear
echo -e "#----OVERVIEW----#\n-\nremote server: $input_user@$input_IP\n-\nbackup directory: $input_dir\n-\nlocal tmp directory: $input_tmp_dir\n-"

rm $exec_dir/SOURCE/vars.sh 2> /dev/null
echo "remote_IP=$input_IP" >> $exec_dir/SOURCE/vars.sh
echo "remote_user=$input_user" >> $exec_dir/SOURCE/vars.sh
echo "remote_port=$input_port" >> $exec_dir/SOURCE/vars.sh
echo "remote_dir=$input_dir" >> $exec_dir/SOURCE/vars.sh
echo "tmp_dir=$input_tmp_dir" >> $exec_dir/SOURCE/vars.sh

path="PATH"
dqt='"'
global_path=`realpath $0`
real_path="`dirname $global_path`:$"

sed -i '/backup:$PATH/d' /home/$(whoami)/.bashrc

echo "export PATH=${dqt}$real_path$path${dqt}" >> /home/$(whoami)/.bashrc
source /home/$(whoami)/.bashrc

echo "An entry in .bashrc has been created. You can now run these scripts from every location."
echo "Please restart your terminal for the changes to take effect."
