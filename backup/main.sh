#!/usr/bin/env bash

# Sourcing Necessary Files #

. functions.sh
. vars.sh

# Parsing Options #

while getopts ":h :t :v :c" option; do
	case $option in
		h)
			Help
			exit 0;;
		v)
			Verbose_run
			exit 0;;
		c)
			. conf.sh
			exit 0;;
		t)
			Test_run
			exit 0;;
		\?)
			echo "Invalid argument"
			exit 1;;
	esac
done

Quiet_run

