#!/bin/bash
#
# Usage: Will create my instance of i3 complete with all
#        settings and dotfiles as they should be. It's
#        my post-install script.
#
# Script by Joris van Dijk | gitlab.com/jorisvandijk 
#
#          Published under GPL-3.0-or-later

C='\033[1;35m' # Color
NC='\033[0m'   # No Color

cd $HOME || return
echo
echo
echo -e "${C}Welcome back! Let's get this puppy rollin'!${NC}"
echo
echo -e "${C}>> WARNING: THIS WILL DO HARM TO YOUR SYSTEM <<${NC}"
echo -e "${C}>>>>>> ONLY USE ON A FRESH ARCH INSTALL! <<<<<<${NC}"
echo
while true; do
    read -p $'\e[35mGet going? (yes/no) \e[0m: ' yn
    case $yn in
        [Yy]* ) echo
                echo -e "${C}Running updates and such...${NC}"
                echo
                sudo pacman -Syyu --noconfirm 
                echo
                echo -e "${C}Installing the pacman packages...${NC}"
                sudo pacman -S --noconfirm $(cat pkglist.txt|xargs)
                echo
                echo -e "${C}Installing yay...${NC}"
                git clone https://aur.archlinux.org/yay.git
                cd yay
                makepkg -si
                rm -rf ~/yay
                echo 
                echo -e "${C}Installing AUR packages...${NC}"
                yay -S $(cat pkglist_aur.txt|xargs)
                echo ; break;;
        [Nn]* ) exit;;
        * ) echo 
            echo -e "${C}Yes or no, please...${NC} "
            echo
    esac
done
echo
while true; do
    echo -e "${C}Time to nuke any pre-existing configs!${NC}"
    read -p $'\e[35mAre you sure about this? Last chance... (yes/no) \e[0m: ' yn
    case $yn in
        [Yy]* ) echo
                echo -e "${C}Removing old files..${NC}"
                echo
                cd $HOME || return
                rm -rf $HOME/.config
                rm $HOME/.bashrc  ; break;;
        [Nn]* ) exit;;
        * ) echo 
            echo -e "${C}Yes or no, please...${NC} "
            echo
    esac
done
echo
echo -e "${C}Setting up Virtualbox...${NC}"
modprobe vboxdrv
echo
echo -e "${C}For the Intel/Nvidia Optimus switching to function,${NC}"
echo -e "${C}We need to 'sudo mv /etc/X11/xorg.conf xorg.conf_',${NC}"
echo -e "${C}if present.${NC}"
echo
sudo mv /etc/X11/xorg.conf xorg.conf_ 
echo 
read -p $'\e[35mWhat is your username? \e[0m: ' USER
echo
echo -e "${C}We need to add $USER to the video group for${NC}"
echo -e "${C}backlight setting to work properly.${NC}"
sudo chmod +s /usr/bin/light
echo
sudo gpasswd -a $USER video
echo -e "${C}Cool. Let's now grab our essential repositories...${NC}"
echo
echo -e "${C}Grabbing Scripts...${NC}"
git clone https://gitlab.com/jorisvandijk/scripts.git $HOME/Scripts
cd $HOME/Scripts
git remote set-url origin git@gitlab.com:jorisvandijk/scripts.git
git remote -v
cd $HOME || return
echo

echo -e "${C}Grabbing Dotfiles...${NC}"
git clone https://gitlab.com/jorisvandijk/dotfiles.git $HOME/Dotfiles
cd $HOME/Dotfiles
git remote set-url origin git@gitlab.com:jorisvandijk/dotfiles.git
git remote -v
cd $HOME || return
echo
while true; do
    echo -e "${C}Moar repos!${NC}"
    read -p $'\e[35mWould you like to grab non essential repos as well? (yes/no) \e[0m: ' yn
    case $yn in
        [Yy]* ) 
        echo -e "${C}Grabbing Wallpapers...${NC}"
        git clone https://gitlab.com/jorisvandijk/wallpapers.git $HOME/Pictures/wallpapers
        cd $HOME/Pictures/wallpapers
        git remote set-url origin git@gitlab.com:jorisvandijk/wallpapers.git
        git remote -v
        cd $HOME || return
        echo -e "${C}Grabbing Notes...${NC}"
        git clone https://gitlab.com/jorisvandijk/notes.git $HOME/Documents/Notes
        cd $HOME/Documents/Notes
        git remote set-url origin git@gitlab.com:jorisvandijk/notes.git
        git remote -v
        cd $HOME || return
        echo
        echo -e "${C}Grabbing FreeTube...${NC}"
        git clone https://gitlab.com/jorisvandijk/freetube.git $HOME/.config/FreeTube
        cd $HOME/.config/FreeTube
        git remote set-url origin git@gitlab.com:jorisvandijk/freetube.git
        git remote -v
        cd $HOME || return
        echo
        echo -e "${C}Grabbing Firefox settings...${NC}"
        git clone https://gitlab.com/jorisvandijk/firefox.git $HOME/.mozilla/firefox
        cd $HOME/.mozilla/firefox/
        git remote set-url origin git@gitlab.com:jorisvandijk/firefox.git
        git remote -v
        cd $HOME || return
        echo
        echo -e "${C}Grabbing Kee settings...${NC}"
        git clone https://gitlab.com/jorisvandijk/kee.git $HOME/Documents/Kee
        cd $HOME/Documents/Kee
        git remote set-url origin git@gitlab.com:jorisvandijk/kee.git
        git remote -v
        cd $HOME || return
        echo
        echo; break;;
        [Nn]* ) exit;;
        * ) echo 
            echo -e "${C}Yes or no, please...${NC} "
            echo
    esac
done
echo -e "${C}Next up, some Stow magic!${NC}"
echo
cd $HOME/Dotfiles/ || return
for d in *; do stow -v -t ~ "$d" ;done
echo -e "${C}Setting up Git${NC}"
echo
read -p $'\e[35mWhat is your git email username? (Capitalize!)\e[0m: ' GU
git config --global user.name ${GU}
read -p $'\e[35mWhat is your git email address? \e[0m: ' GE
git config --global user.email ${GE}
echo
echo -e "${C}Creating SSH keys...${NC}"
echo
echo -e "${C}DO NOT ENTER A PASSPHRASE!${NC}"
echo
ssh-keygen -t ed25519 -C "JorisPC"
echo 
echo -e "${C}Now copy the following key and head to https://gitlab.com/-/profile/keys and fill out the form.${NC}"
echo
cat ~/.ssh/id_ed25519.pub 
echo	
echo -e "${C}Done!${NC}"