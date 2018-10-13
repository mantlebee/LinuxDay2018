#!/bin/bash

# ADD USER TO GROUPS
# Updates the user, appending the new groups to the existings ones.
# params:
#	user:string
#	groups:string (eg: audio,video)
# usage:
#	add_user_to_groups pi audio,video
#
function add_user_to_groups {
	user="$1"
	groups="$2"
	usermod -a -G $groups $user
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

function install_sources {
	f="/etc/apt/sources.list"
	for i in "$@"; do
		if [ -z `cat $f | grep $i` ]; then
			echo $i >> $f
		fi
	done
}

# KILL IF RUNNING
# Kills the processes if running
# params:
#	processes:string[]
# usage:
#	kill_if_running fluidsynth omxplayer
#
function kill_if_running {
	for i in "$@"; do
		if [ ! -z `ps | grep $i` ]; then
			killall $i
		fi
	done
}

# SET AUDIO OUTPUT
# Set the audio output between available modes: auto, hdmi, jack.
# params:
#	device:string (eg: auto | jack | hdmi)
# usage:
#	aset_audio_output jack
#
function set_audio_output {
	device="$1"
	device_id=0
	if [ "$device" == "jack" ]; then
		device_id=1
	elif [ "$device" == "hdmi" ]; then
		device_id=2
	fi
	amixer cset numid=3 $device_id
}

# SUDO CHECK
# Checks for sudo/root permissions, if missing, executes the given commands.
# params:
#	commands:string[]
# usage:
#	sudo_check 'echo not authorized' exit
#	# authorized execution here
#
function sudo_check {
	if [ `id -u` -ne 0 ]; then
		for i in "$@"; do $i; done
	fi
}

function update_packages {
	apt-get upgrade
}

function update_sources {
	apt-get update
}
