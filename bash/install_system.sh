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
		echo " "
		echo " "

	}

init() #the basics
	{
		sudo pacman -Syyu  # Issues about locking db
		sudo pacman -S  --noconfirm git stow firefox
		echo "Done!"
	}

git() #grab some repos
	{
		cd ~/ || return
		echo "Grabbing repos..." #repeats endlessly

		git clone https://gitlab.com/jorisvandijk/scripts.git
		#sudo git clone git@gitlab.com:jorisvandijk/scripts.git 
		git clone https://gitlab.com/jorisvandijk/freetube.git
		#sudo git clone git@gitlab.com:jorisvandijk/freetube.git 
		git clone https://gitlab.com/jorisvandijk/wallpapers.git
		#sudo git clone git@gitlab.com:jorisvandijk/wallpapers.git 
		git clone https://gitlab.com/jorisvandijk/dotfiles.git
		#sudo git clone git@gitlab.com:jorisvandijk/dotfiles.git 
		git clone https://gitlab.com/jorisvandijk/notes.git
		#sudo git clone git@gitlab.com:jorisvandijk/notes.git

		echo "Moving stuff around..."
		mv scripts Scripts && cd Scripts 
		#change from http to ssh
		git remote set-url origin git@github.com:jorisvandijk/scripts.git 
		cd ~/ || return
		mv freetube ~/.config/FreeTube 
		mv wallpapers Pictures/wallpapers 
		mv dotfiles Dotfiles 
		mv notes ~/Documents/Notes 
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
		echo " "
		echo "Now copy the following key and head to https://gitlab.com/-/profile/keys and fill out the form."
		cat ~/.ssh/id_ed25519.pub # To grab the key. Also add whitespace!		
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
