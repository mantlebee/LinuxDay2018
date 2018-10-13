#!/bin/bash

. ../../../common/bash_utils.sh

PROJECT="GAME STREAM"

function usage {
	echo "Usage: "
	echo "    ./run.sh"
    exit
}

function main {
	RESOLUTION=""
	IPADDRESS=""
	echo $PROJECT
	get_params
	check_params
	set_audio_output "hdmi"
	start_streaming
	echo "done!"
}

function get_params {
	echo "Input the resolution:"
	read RESOLUTION
	echo "Input the remote ip address:"
	read IPADDRESS
}

function check_params {
	if [ -z $RESOLUTION ]; then
		echo "Error: bad resolution set."
		exit
	fi
	if [ -z $IPADDRESS ]; then
		echo "Error: remote ip address not set."
		exit
	fi
}

function start_streaming {
	kill_if_running moonlight
	moonlight -$RESOLUTION stream $IPADDRESS
}

main
