#!/bin/bash
# Jorisvandijk.com - Post install script.

me="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"

menu()
	{
		clear
		title="!!!!!! DO NOT RUN ANY OF THESE COMMANDS ON AN ACTIVE SYSTEM !!!!!!"
		subtitle="ONLY FOR USE ON A FRESHLY INSTALLED ARCH SYSTEM"
		echo "  "
		echo "  "
		printf "%*s\n" $(((${#title}+$COLUMNS)/2)) "$title"
		echo "  "
		printf "%*s\n" $(((${#subtitle}+$COLUMNS)/2)) "$subtitle"
		echo "  "
		echo "  "
		sleep 5
		echo "usage:    $me    [OPTION]"
		echo " "
		echo "OPTIONS"
		echo "init:     Install the basic system needs."
		echo "git:      Grab the repositories."
		echo "stow:     Sort dotfiles."
		echo "ssh:      Set up the .ssh keys."
		echo "prog:     Install applications."
		echo " "

	}

init() #the basics
	{
		sudo pacman -Syyu  &
		sudo pacman -S  --noconfirm git stow firefox
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

prog() #time for toys
	{
		cd ~/ && mkdir temp && cd temp || return
		echo "Updating before installing..."
		sudo pacman -Syyu --noconfirm
		echo "Installing applications..."
		curl https://gitlab.com/jorisvandijk/scripts/-/raw/master/bash/install_system_pkglist.txt --output install_system_pkglist.txt 
		sudo pacman -S --no-confirm "$(awk '{print $1}' install_system_pkglist.txt)"
		echo "Installing AUR applications..."
		curl https://gitlab.com/jorisvandijk/scripts/-/raw/master/bash/install_system_pkglist_aur.txt --output install_system_pkglist_aur.txt
		yay -S "$(awk '{print $1}' install_system_pkglist_aur.txt)"
		echo "Cleaning up..."
		cd ~/ && rm -rf temp
		echo "Done!"
	}

if [ -n "$1" ]; then
  $1
else
  menu
fi
