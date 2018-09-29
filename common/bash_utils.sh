#!/bin/bash

function print {
	for i in $@; do echo $i; done
}

function sudo_check {
	if [ `id -u` -ne 0 ]; then
		for i in $@; do $i; done
	fi
}

function install_sources {
	x=/etc/apt/sources.list
	for i in "$@"; do
		echo $i
#		if [ -z "`cat $x | grep $i`" ]; then
#			echo "$i" >> $x
#		fi
	done
}

function update_sources {
	apt-get update
}

function install_gpg_keys {
	x="/tmp/gpg_key"
	for i in $@; do
		wget $i -o $x
		apt-key add $x
		rm $x
	done
}

function install_packages {
	apt-get install $@
}

function update_packages {
	apt-get upgrade
}

