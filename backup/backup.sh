#!/usr/bin/env bash

script_dir=$0
exec_dir=${script_dir::-9}

source $exec_dir/SOURCE/vars.sh

confirm=1

clear
while [ $confirm == 1 ]; do
	read -p "directory to back up: " backup_dir
	if [ ! -d $backup_dir ] || [ "$backup_dir" = "" ]; then
		clear
	else
		break
	fi
done
sudo rm -r $tmp_dir 2> /dev/null
mkdir $tmp_dir
sudo tar -czvf $tmp_dir/BACKUP-$(whoami)-$(date '+%Y-%m-%d-%H--%M').tar.gz $backup_dir &> /dev/null
scp -P$remote_port $tmp_dir/*.tar.gz $remote_user@$remote_IP:$remote_dir
sudo rm -r $tmp_dir

remote_size=`ssh $remote_user@$remote_IP -p$remote_port df -Ph $remote_dir | awk 'NR==2 {print $4}'`
remote_size_num=${remote_size::-1}
if [ $remote_size_num -gt 5 ]; then
	exit
else
	echo "Your remote directory has less than 5GB of space available."
	echo "You should delete some snapshots to free up disk space."
fi
