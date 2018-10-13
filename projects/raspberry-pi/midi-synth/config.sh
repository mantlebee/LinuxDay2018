#!/bin/bash

. ../../../common/bash_utils.sh

PROJECT="MIDI SYNTH"

function usage {
	echo "Usage: "
	echo "- for non root users only:"
	echo "    ./config.sh"
    exit
}

function main {
	MIDICLIENT=""
    FLUIDCLIENT=""
	echo $PROJECT
	# sudo_check usage exit
	show_audio_devices
    get_audio_devices
    check_audio_devices
	update_profile
	echo "done!"
}

function show_audio_devices {
	echo "Audio devices:"
	aconnect -o
}

function get_audio_devices {
	echo "Input the midi client:"
	read MIDICLIENT
	echo "Input the Fluidsynth client:"
	read FLUIDCLIENT
}

function check_audio_devices {
    if [ -z $MIDICLIENT ] || [ -z $FLUIDCLIENT ]; then
        echo "Error: one or more bad audio devices set."
        exit
    fi
}

function update_profile {
	file="$HOME/.profile"
	if [ ! -e $file ]; then
		touch $file
	fi
	if [ -z `cat $file | grep "$PROJECT"` ]; then
		echo "# $PROJECT (start)
		# Run fluidsynth, but this time as a non-interactive server
		fluidsynth -is --audio-driver=alsa --gain 3 /usr/share/sounds/sf2/FluidR3_GM.sf2 &
		# give it time to boot up
		sleep 10
		# connect the controller to fluidsynth
		# Don't forget to replace these with the client numbers!
		aconnect $MIDICLIENT:0 $FLUIDCLIENT:0
		# Give fluidsynth a nice high priority so it gets as much CPU as possible!
		sudo renice -n -18 -u pi
		# $PROJECT (end)" >> $file
	fi
}

main
