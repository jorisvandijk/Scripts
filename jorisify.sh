#!/bin/bash
#
# Usage: Jorisify my fresh Arch install
#
# !!! DO NOT RUN THIS SCRIPT, IT'LL DESTROY YOUR SYSTEM!!!
#
# Script by Joris van Dijk | gitlab.com/jorisvandijk 
#
#          Published under GPL-3.0-or-later

# Check that the script is running as root. If not, then prompt for the sudo
# password and re-execute this script with sudo.
if [ "$(id -nu)" != "root" ]; then
sudo -k
pass=$(whiptail --backtitle "Jorisify" --title "Authentication required" --passwordbox \
"This script requires administrative privilege. Please authenticate to begin the installation.\n\n[sudo] Password for user $user:" 12 50 3>&2 2>&1 1>&3-)
exec sudo -S -p '' "$0" "$@" <<< "$pass"
exit 1
fi

# Set user and home
user=$SUDO_USER
home="/home/$user"
#
## Check directory
#if [[ $PWD == $home/jorisify ]]; then
#    echo "In correct directory."; echo
#    else clear; echo "Please run this script from within the Jorisify repository directory. Aborting!"; exit
#fi
#
## Check for pkglist.txt
#FILE=pkglist.txt
#if [[ -f "$FILE" ]]; then
#    echo "$FILE present."; echo
#    else clear; echo "pkglist.txt is missing. Aborting!"; exit
#fi
#
## Check for pkglist_aur.txt
#FILE=pkglist_aur.txt
#if [[ -f "$FILE" ]]; then
#    echo "$FILE present."; echo
#    else clear; echo "pkglist_aur.txt is missing. Aborting!"; exit
#fi
#
## Warn user of dangers
if whiptail --title "Warning!" \
--backtitle "Jorisify" --yesno "This script does irreversable damage to your system! \
are you sure you want to continue?" 10 50 3>&1 1>&2 2>&3; then

## Install needed applications
#echo "Updating and installing needed applications..."
#pacman -Syyu --noconfirm firefox xclip
#
## Git setup
#GU=$(whiptail --backtitle "Jorisify" --title "Git username" --inputbox "What is your git global username? (e.g. Joris)" 8 40 \
#3>&1 1>&2 2>&3 3>&- )
#
#GE=$(whiptail --backtitle "Jorisify" --title "Git email address" --inputbox "What is your git email address?" 8 40 \
#3>&1 1>&2 2>&3 3>&- )
#
#GN=$(whiptail --backtitle "Jorisify" --title "Git system name" --inputbox "What name would you like this system to get on GitLab? (e.g. JorisPC)" 8 40 \
#3>&1 1>&2 2>&3 3>&- )
#
#sudo -u $user git config --global user.name ${GU}
#sudo -u $user git config --global user.email ${GE}
#
## SSH keygen
#sudo -u $user ssh-keygen -t rsa -q -f "$home/.ssh/id_rsa" -N "" -C "$GN"
#cat $home/.ssh/id_rsa.pub | xclip -sel clip
#
#whiptail --backtitle "Jorisify" --title "SSH key for GitLab" --msgbox "\
#Now we have to add this new system's SSH key to your GitLab account. \
#The key has already been copied to your clipboard!\n\n\
#CTRL+click this link: https://gitlab.com/-/profile/keys\n\n\
#Please do not skip this step in order for Git to clone private repositories!\n\n\n\n\
#If the key is not copied successfully, you can find it in \$HOME/.ssh/rsa.pub" 20 100
#
## Installing pacman packages
#clear
#pacman -S --noconfirm $(cat pkglist.txt|xargs)
su - $user
## Install yay
#sudo -u $user git clone https://aur.archlinux.org/yay.git
#cd yay
#sudo -u $user makepkg -si
#cd ..
#rm -rf yay
#sudo -u $user yay -S --noconfirm --removemake $(cat pkglist_aur.txt|xargs)
#
## Nuking old install files if present
#cd $home || return
#rm -rf $home/.config
#rm $home/.bashrc 
#
## Virtualbox fix
#modprobe vboxdrv
#
## Optimus switching fix
#mv /etc/X11/xorg.conf xorg.conf_ 
#
## Backlight fix
#chmod +s /usr/bin/light
#gpasswd -a $user video
echo $USER
# Grab GitLab repositories
git clone git@gitlab.com:jorisvandijk/scripts.git $home/Scripts
git clone git@gitlab.com:jorisvandijk/dotfiles.git $home/Dotfiles
git clone git@gitlab.com:jorisvandijk/wallpapers.git $home/Pictures/wallpapers
git clone git@gitlab.com:jorisvandijk/notes.git $home/Documents/Notes
git clone git@gitlab.com:jorisvandijk/freetube.git $home/.config/FreeTube
git clone git@gitlab.com:jorisvandijk/firefox.git $home/.mozilla/firefox
git clone git@gitlab.com:jorisvandijk/kee.git $home/Documents/Kee
git clone git@gitlab.com:jorisvandijk/jorisify.git $home/Jorisify

# Stow magic
cd $home/Dotfiles/ || return
for d in *; do stow -v -t ~ "$d" ;done
cd $home || return

# Setting up Vundle for Vim
git clone https://github.com/VundleVim/Vundle.vim.git $home/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

# Fix permissions
sudo chown -R $user:$user $home

# Remove install directory
rm -rf $home/jorisify

# End of script
else
clear
echo "Installation aborted."
exit
fi
#clear
#whiptail --backtitle "Jorisify" --title "Jorisification complete!" --msgbox "\
#That's all folks!\n\nFor Optimus to function correctly, please reboot!" 20 100
exit