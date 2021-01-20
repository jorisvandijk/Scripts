#!/bin/bash
# Jorisvandijk.com - Post install script. based on a script by HexDSL.

me="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"

menu()
	{
		echo "usage:   ' $me ' '[OPTION]'"
		echo " "
		echo "init:     Install the basic system needs."
		echo "git:      Grab the repositories."
		echo "stow:     Sort dotfiles."
		echo "ssh:      Set up the .ssh keys."
		echo " "

	}

init() #the basics
	{
		sudo pacman -Syyu  &
		sudo pacman -S git stow
		echo "Done!"
	}

git() #grab some repos
	{
		cd ~/ || return
		echo "Grabbing repositories..."
		git clone git@gitlab.com:jorisvandijk/scripts.git &
		git clone git@gitlab.com:jorisvandijk/freetube.git &
		git clone git@gitlab.com:jorisvandijk/wallpapers.git &
		git clone git@gitlab.com:jorisvandijk/dotfiles.git &
		git clone git@gitlab.com:jorisvandijk/notes.git
		echo "Moving stuff around..."
		mv scripts Scripts &
		mv freetube ~/.config/FreeTube &
		mv wallpapers Pictures/wallpapers &
		mv dotfiles Dotfiles &
		mv notes ~/Documents/Notes &
		echo "Done!"
	}

stow() #fling around some dotfiles
	{
	echo "Moving dotfiles around..."
	cd ~/Dotfiles/ || return
	for d in *; do stow -t ~ "$d" ;done
	echo "Done!"
	}

ssh() #get me them sweet keys
	{
		echo "Creating ssh keys. Do not add a passphrase..."
		ssh-keygen -t ed25519 -C "JorisPC"
		echo "Now copy the following key and head to https://gitlab.com/-/profile/keys and fill out the form."
		echo "Done!"
	}

if [ -n "$1" ]; then
  $1
else
  menu
fi
