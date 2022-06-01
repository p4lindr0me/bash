#!/usr/bin/env bash

# Contact: pal1ndr0me@riseup.net || DepSecGroup@lavabit.com #

# Source Necessary Files #

. functions.sh
. vars.sh

# Main Variables #

unsaved="(unsaved)"
sett=1

#while [ $sett -eq 1 ]; do
while true; do

clear
echo -e "\e[4m\e[1mConfiguration Options\e[0m\n"

echo -e "	- \e[4mRemote Server Settings\e[0m\n"
echo -e "		[1] IP Address						$status1"
echo -e "		[2] Username							$status2"
echo -e "		[3] Port Number						$status3"
echo -e "		[4] Snapshot Directory		$status4"

echo -e "\n 	- \e[4mLocal Settings\e[0m\n"
echo -e "		[5] Transfer-Directory		$status5"
echo -e "		[6] Compression Format		$status6"
echo -e "				[z: gzip | j: bzip2 | J: xz]\n"

read -p "[Number] -> Configuration | [q] -> Quit | [w] -> Write Out: " opt_set

case $opt_set in
	q)
		exit 0;;
	1)
		echo ; read -p "IP-Address: " opt_ip
		status1="$unsaved"
		;;
	2)
		echo ; read -p "Username: " opt_user
		status2="$unsaved"
		;;
	3)
		echo ; read -p "Port Number: " opt_port
		status3="$unsaved"
		;;
	4)
		echo ; read -p "Snapshot Directory: " opt_snap_dir
		status4="$unsaved"
		;;
	5)
		echo ; read -p "Transfer Directory: " opt_tmp_dir
		status5="$unsaved"
		;;
	6)
		echo ; read -p "Compression Format: " opt_compression
		if [ $opt_compression == z ] || [ $opt_compression == j ] || [ $opt_compression == J ]; then
			status6="$unsaved"
		else
			status6=""
		fi
		;;
	w)
		rm vars.sh 2> /dev/null
		echo "#!/usr/bin/env bash" >> vars.sh
		echo
		echo "opt_ip='$opt_ip'" >> vars.sh
		echo "opt_user='$opt_user'" >> vars.sh
		echo "opt_port='$opt_port'" >> vars.sh
		echo "opt_snap_dir='$opt_snap_dir'" >> vars.sh
		echo "opt_tmp_dir='$opt_tmp_dir'" >> vars.sh
		echo "opt_compression='$opt_compression'" >> vars.sh

		if [ $opt_compression == z ]; then
			echo "comp_append='gz'" >> vars.sh
		else if [ $opt_compression == j ]; then
			echo "comp_append='bz2'" >> vars.sh
		else if [ $opt_compression == J ]; then
			echo "comp_append='xz'" >> vars.sh
		fi
		fi
		fi
		break
		;;
esac
done
