#!/bin/bash
#
# Usage: Jorisify my fresh Arch install
#
# !!! DO NOT RUN THIS SCRIPT, IT'LL DESTROY YOUR SYSTEM!!!
#
# Script by Joris van Dijk | gitlab.com/jorisvandijk 
#
#          Published under GPL-3.0-or-later

# Check directory
if [[ $PWD == $HOME/jorisify ]]; then
    echo "In correct directory."; echo
    else clear; echo "Please run this script from within the Jorisify repository directory. Aborting!"; exit
fi

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

# Warn user of dangers
if dialog --stdout --title "Warning!" \
--backtitle "Jorisify" --yesno "This script does irreversable damage to your system! \
are you sure you want to continue?" 10 50; then clear
else
clear
echo "Installation aborted."
exit
fi

# Get root privileges
printf '%s\n' "$(dialog --title "Root/Sudo password" --backtitle "Jorisify" --output-fd 1 --passwordbox "Please enter root password:" 10 40)" | sudo -Svp ''
clear

# Install needed applications
sudo pacman -Syyu --noconfirm firefox xclip

# Git setup
GU=$(dialog --stdout --backtitle "Jorisify" --title "Git username" --inputbox \
"What is your git global username? (e.g. Joris)" 8 40)

GE=$(dialog --stdout  --backtitle "Jorisify" --title "Git email address" --inputbox \
"What is your git email address?" 8 40)

GN=$(dialog --stdout  --backtitle "Jorisify" --title "Git system name" --inputbox \
"What name would you like this system to get on GitLab? (e.g. JorisPC)" 8 40)

git config --global user.name ${GU}
git config --global user.email ${GE}

# SSH keygen
ssh-keygen -t rsa -q -f "$HOME/.ssh/id_rsa" -N "" -C "$GN"
cat $HOME/.ssh/id_rsa.pub | xclip -sel clip

dialog --backtitle "Jorisify" --title "SSH key for GitLab" --msgbox "\
Now we have to add this new system's SSH key to your GitLab account. \
The key has already been copied to your clipboard!\n\n\
CTRL+click this link: https://gitlab.com/-/profile/keys\n\n\
Please do not skip this step in order for Git to clone private repositories!\n\n\n\n\
If the key is not copied successfully, you can find it in \$HOME/.ssh/rsa.pub" 20 100

# Installing pacman packages
clear
sudo pacman -S --noconfirm $(cat pkglist.txt|xargs)

# Install yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ..
rm -rf yay
yay -S --noconfirm --removemake $(cat pkglist_aur.txt|xargs)

# Nuking old install files if present
$HOME || return
-rf $HOME/.config
$HOME/.bashrc 

# Virtualbox fix
sudo modprobe vboxdrv

# Optimus switching fix
sudo mv /etc/X11/xorg.conf xorg.conf_ 

# Backlight fix
sudo chmod +s /usr/bin/light
sudo gpasswd -a $USER video

# Grab GitLab repositories
ssh-keyscan github.com >> ~/.ssh/known_hosts
git clone git@gitlab.com:jorisvandijk/scripts.git $HOME/Scripts
git clone git@gitlab.com:jorisvandijk/dotfiles.git $HOME/Dotfiles
git clone git@gitlab.com:jorisvandijk/wallpapers.git $HOME/Pictures/wallpapers
git clone git@gitlab.com:jorisvandijk/notes.git $HOME/Documents/Notes
git clone git@gitlab.com:jorisvandijk/freetube.git $HOME/.config/FreeTube
git clone git@gitlab.com:jorisvandijk/firefox.git $HOME/.mozilla/firefox
git clone git@gitlab.com:jorisvandijk/kee.git $HOME/Documents/Kee
git clone git@gitlab.com:jorisvandijk/jorisify.git $HOME/Jorisify

cd $HOME/Dotfiles/ || return
for d in *; do stow -v -t ~ "$d" ;done

# Setting up Vundle for Vim
git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

# Remove install directory
rm -rf $HOME/jorisify

# End of script

#clear
#dialog --backtitle "Jorisify" --title "Jorisification complete!" --msgbox "\
#That's all folks!\n\nFor Optimus to function correctly, please reboot!" 20 100
exit