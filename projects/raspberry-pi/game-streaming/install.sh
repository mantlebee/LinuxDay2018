#!/bin/bash

. ../../../common/bash_utils.sh

PROJECT="GAME STREAM"

function usage {
	echo "Usage: "
	echo "- for root user:"
	echo "    ./install.sh"
	echo "- for non root user:"
	echo "    sudo ./install.sh"
}

function main {
	echo $PROJECT
	sudo_check usage exit
	install_sources "deb http://archive.itimmer.nl/raspbian/moonlight stretch main"
	install_gpg_keys "http://archive.itimmer.nl/itimmer.gpg"
	update_sources
	install_packages "moonlight-embedded"
	echo "done!"
}

main
