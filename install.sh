#!/usr/bin/env bash

if [[ $EUID -ne 0 ]]; then
	echo "This script must be run as root."
	exit 1
fi

case "$(uname -s)" in
	Linux)
		if [[ ! -z "$(which apt 2>/dev/null)" ]]; then
			install="sudo apt install -y"
			commands="sudo apt update -y && sudo apt upgrade -y"
			)
		elif [[ ! -z "$(which pacman 2>/dev/null)" ]]; then
			install="sudo pacman -S --noconfirm"
			commands="sudo pacman -Syu --noconfirm"
			)
		else
			echo "Can't find package manager."
			exit 1
		fi

		commands=$(cat<<-EOT
			$commands
			$install ruby
      			gem install securerandom
		EOT
    )
		;;
	Darwin)
		commands=$(cat<<-EOT
			brew update && brew upgrade
			brew install ruby
			gem install securerandom
		EOT
		)
		;;
	*)
		echo "Your OS is not supported."
		exit 1
		;;
esac
eval "${commands}"
echo "Successfully installed 01."
