#!/bin/bash

. ../../../common/bash_utils.sh

PROJECT="MIDI SYNTH"

function usage {
	echo "Usage: "
	echo "- for root user:"
	echo "    ./install.sh"
	echo "- for non root users:"
	echo "    sudo ./install.sh"
}

function main {
	DEVICE=""
	echo $PROJECT
	sudo_check usage exit
	update_sources
	install_packages "fluidsynth"
	echo "done!"
}

main
