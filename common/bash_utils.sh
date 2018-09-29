#!/bin/bash

function print {
	for i in "$@"; do echo $i; done
}

function sudo_check {
	if [ `id -u` -ne 0 ]; then
		for i in "$@"; do $i; done
	fi
}

function install_sources {
	f="/etc/apt/sources.list"
	for i in "$@"; do
		if [ -z `cat $f | grep $i` ]; then
			echo $i >> $f
		fi
	done
}

function update_sources {
	apt-get update
}

function install_gpg_keys {
	f="/tmp/gpg_key"
	for i in "$@"; do
		wget $i -O $f
		apt-key add $f
		rm $f
	done
}

function install_packages {
	apt-get install $@
}

function update_packages {
	apt-get upgrade
}

