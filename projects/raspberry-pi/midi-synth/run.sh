#!/bin/bash

. ../../../common/bash_utils.sh

PROJECT="MIDI SYNTH"

function usage {
	echo "Usage: "
	echo "    ./run.sh path-to-sf2-file"
    exit
}

function main {
	MIDICLIENT="20"
	FLUIDCLIENT="128"
	SOUNDFONT="/usr/share/sounds/sf2/FluidR3_GM.sf2"
	echo $PROJECT
	set_audio_output "jack"
	run_fluidsynth $SOUNDFONT
	show_audio_devices
	get_audio_devices
	check_audio_devices
	connect_audio_devices
	set_high_priority
	echo "done!"
}

function run_fluidsynth {
	kill_if_running fluidsynth
	fluidsynth --server --no-shell --audio-driver=alsa --gain 5 $SOUNDFONT &
	sleep 5
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

function connect_audio_devices {
	aconnect $MIDICLIENT:0 $FLUIDCLIENT:0
}

function set_high_priority {
	sudo renice -n -18 -u pi
}

main
