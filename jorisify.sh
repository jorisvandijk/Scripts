#!/bin/bash
#
# Usage: Jorisify my fresh Arch install
#
# !!! DO NOT RUN THIS SCRIPT, IT'LL DESTROY YOUR SYSTEM!!!
#
# Script by Joris van Dijk | gitlab.com/jorisvandijk 
#
#          Published under GPL-3.0-or-later

# Go home
cd $HOME || return

# Get username
USER=$USER

# Create an install directory and grab needed files
clear;echo
mkdir $HOME/jorisify_install
cd $HOME/jorisify_install
wget https://gitlab.com/jorisvandijk/jorisify/-/blob/master/pkglist.txt
wget https://gitlab.com/jorisvandijk/jorisify/-/blob/master/pkglist_aur.txt

# Check for pkglist.txt
FILE=pkglist.txt
if [[ -f "$FILE" ]]; then
    echo "$FILE present."; echo
    else clear; echo "pkglist.txt is missing. Aborting!"; exit
fi

# Check for pkglist_aur.txt
FILE=pkglist_aur.txt
if [[ -f "$FILE" ]]; then
    echo "$FILE present."; echo
    else clear; echo "pkglist_aur.txt is missing. Aborting!"; exit
fi

# Git
read -p $'What is your git global username? (e.g. Joris): ' GU
read -p $'What is your git email address?: ' GE
read -p $'What name would you like this system to get on GitLab? (e.g. JorisPC): ' GN

# Get sudo priveleges
echo "This script requires root priveleges!"
if [ $EUID != 0 ]; then
    sudo "$0" "$@"
    exit $?
fi

# Warn user of dangers
if dialog --stdout --title "Warning!" \
          --backtitle "This script is dangerous!" \
          --yesno "This script does irreversable damage to your system!\
          are you sure you want to continue?" 10 50; then

            # Installing packages and yay
            echo "Updating system and installing packages"
            sudo pacman -Syyu --noconfirm 
            sudo pacman -S --noconfirm $(cat pkglist.txt|xargs)
            git clone https://aur.archlinux.org/yay.git
            cd yay
            makepkg -si
            rm -rf yay
            cd $HOME/jorisify_install
            yay -S --noconfirm $(cat pkglist_aur.txt|xargs)
            
            # Nuking old install files if present
            cd $HOME || return
            rm -rf $HOME/.config
            rm $HOME/.bashrc 

            # Virtualbox fix
            modprobe vboxdrv

            # Optimus switching fix
            sudo mv /etc/X11/xorg.conf xorg.conf_ 

            # Backlight fix
            sudo chmod +s /usr/bin/light
            sudo gpasswd -a $USER video

            # Grab GitLab repositories

            # Scripts
            git clone https://gitlab.com/jorisvandijk/scripts.git $HOME/Scripts
            cd $HOME/Scripts
            git remote set-url origin git@gitlab.com:jorisvandijk/scripts.git
            git remote -v
            cd $HOME || return

            # Dotfiles
            git clone https://gitlab.com/jorisvandijk/dotfiles.git $HOME/Dotfiles
            cd $HOME/Dotfiles
            git remote set-url origin git@gitlab.com:jorisvandijk/dotfiles.git
            git remote -v
            cd $HOME || return   

            # Wallpapers
            git clone https://gitlab.com/jorisvandijk/wallpapers.git $HOME/Pictures/wallpapers
            cd $HOME/Pictures/wallpapers
            git remote set-url origin git@gitlab.com:jorisvandijk/wallpapers.git
            git remote -v
            cd $HOME || return
        
            #Notes
            git clone https://gitlab.com/jorisvandijk/notes.git $HOME/Documents/Notes
            cd $HOME/Documents/Notes
            git remote set-url origin git@gitlab.com:jorisvandijk/notes.git
            git remote -v
            cd $HOME || return
            
            # FreeTube
            git clone https://gitlab.com/jorisvandijk/freetube.git $HOME/.config/FreeTube
            cd $HOME/.config/FreeTube
            git remote set-url origin git@gitlab.com:jorisvandijk/freetube.git
            git remote -v
            cd $HOME || return
           
            # Firefox
            git clone https://gitlab.com/jorisvandijk/firefox.git $HOME/.mozilla/firefox
            cd $HOME/.mozilla/firefox/
            git remote set-url origin git@gitlab.com:jorisvandijk/firefox.git
            git remote -v
            cd $HOME || return
            
            # Kee
            git clone https://gitlab.com/jorisvandijk/kee.git $HOME/Documents/Kee
            cd $HOME/Documents/Kee
            git remote set-url origin git@gitlab.com:jorisvandijk/kee.git
            git remote -v
            cd $HOME || return

            # Stow magic
            cd $HOME/Dotfiles/ || return
            for d in *; do stow -v -t ~ "$d" ;done
            cd $HOME || return

            # Setting up Vundle for Vim
            git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
            vim +PluginInstall +qall

            # Git
            git config --global user.name ${GU}
            git config --global user.email ${GE}
            ssh-keygen -t ed25519 -C "$GN"
            echo 
            echo -e "Now copy the following key and head to https://gitlab.com/-/profile/keys and fill out the form."
            echo
            cat ~/.ssh/id_ed25519.pub 
            echo	

    break
else
    clear
    echo "Installation aborted."
    exit
fi
clear
echo -e "Installation is done!"
echo
echo -e "For Optimus to function correctly, please reboot!"