#!/usr/bin/env bash

# Sourcing Necessary Files #

. vars.sh

# Main Functions #

Help() {
	clear
	echo -e "Syntax: ats-backup [-h|-v|-c|-t]\n"
	echo "Options:"
	echo "	-h		Print this help menu"
	echo "	-v		Verbose mode"
	echo "	-c		Configuration"
	echo -e "	-t		Test mode (verbose)\n"
}

Test_run() {
	clear
	tar -czvf /dev/null /home/admin
	  if [[ $? -eq 0 ]]; then
			echo -e "\n\e[4m\e[1mTest run completed. No errors reported.\e[0m\n"
		else
			echo -e "\n\e[4m\e[1mTest run failed. Script exited with error code $?.\e[0m\n"
		fi						
}

Verbose_run() {
	clear
	read -p "Directory to back up: " opt_input_dir
	if [ ! -d $opt_input_dir ]; then
		echo "Invalid directory"
		exit 1
	else
		echo
	fi
	mkdir $opt_tmp_dir
	tar -c"$opt_compression"vf $opt_tmp_dir/$(date '+%Y-%m-%d-%H--%M').tar.$comp_append $opt_input_dir
	scp -P$opt_port $opt_tmp_dir/*.tar.* $opt_user@$opt_ip:$opt_snap_dir
	rm -r $opt_tmp_dir
}

Quiet_run() {
	Verbose_run 2> /dev/null
}
