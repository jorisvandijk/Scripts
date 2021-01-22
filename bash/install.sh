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
echo
while true; do
    read -p $'\e[35mGet going? (yes/no) \e[0m: ' yn
    case $yn in
        [Yy]* ) echo
                echo -e "${C}Running updates and such...${NC}"
                echo
                sudo pacman -Syyu
                echo
                echo -e "${C}Done!${NC}"
                echo
                echo -e "${C}Installing the base packages...${NC}"
                echo # Base packages
                sudo pacman -S --noconfirm git stow yay i3-gaps i3block rofi exa leafpad 
                echo -e "${C}Installing packages for styling...${NC}"
                echo # Styling packages
                sudo pacman -S --noconfirm papirus-icon-theme nordic-theme-git awesome-terminal-fonts ttf-jetbrains-mono
                echo -e "${C}Installing AUR packages...${NC}"
                echo # AUR packages
                yay -S --noconfirm i3exit
                echo
                echo -e "${C}Done!${NC}" ; break;;
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
                cd $HOME || return
                rm -rf $HOME/.config
                rm $HOME/.bashrc  ; break;;
        [Nn]* ) exit;;
        * ) echo 
            echo -e "${C}Yes or no, please...${NC} "
            echo
    esac
done
echo -e "${C}Cool. Let's now grab our repositories...${NC}"
echo
echo -e "${C}Grabbing Scripts...${NC}"
git clone https://gitlab.com/jorisvandijk/scripts.git $HOME/Scripts
echo
echo -e "${C}Grabbing FreeTube...${NC}"
git clone https://gitlab.com/jorisvandijk/freetube.git $HOME/.config/FreeTube
echo
echo -e "${C}Grabbing Wallpapers...${NC}"
git clone https://gitlab.com/jorisvandijk/wallpapers.git $HOME/Pictures/wallpapers
echo
echo -e "${C}Grabbing Dotfiles...${NC}"
git clone https://gitlab.com/jorisvandijk/dotfiles.git $HOME/Dotfiles
echo
echo -e "${C}Grabbing Notes...${NC}"
git clone https://gitlab.com/jorisvandijk/notes.git $HOME/Documents/Notes
echo
echo -e "${C}Next up, some Stow magic!${NC}"
echo
cd $HOME/Dotfiles/ || return
for d in *; do stow -t ~ "$d" ;done
echo -e "${C}Done!${NC}"
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





echo -e "${C} ${NC}"

# Open issues:
# 1. no gtk theme support
# 2. install other applications needed
# 3. ...
#
#