#!/bin/bash
#
# Usage: Jorisify my fresh Arch install
#
# !!! DO NOT RUN THIS SCRIPT, IT'LL DESTROY YOUR SYSTEM!!!
#
# Script by Joris van Dijk | gitlab.com/jorisvandijk 
#
#          Published under GPL-3.0-or-later

# Set $user and $home
#user=$USER
#home=$HOME

# Check that the script is running as root. If not, then prompt for the sudo
# password and re-execute this script with sudo.
if [ "$(id -nu)" != "root" ]; then
sudo -k
pass=$(whiptail --backtitle "Jorisify" --title "Authentication required" --passwordbox "This script requires administrative privilege. Please authenticate to begin the installation.\n\n[sudo] Password for user $user:" 12 50 3>&2 2>&1 1>&3-)
exec sudo -S -p '' "$0" "$@" <<< "$pass"
exit 1
fi

user=$(dialog --backtitle "Jorisify" --title "Username" --inputbox "What is your username? (LOWERCASE!)" 8 40 \
    3>&1 1>&2 2>&3 3>&- )

home="/home/$user"

 Check directory
if [[ $PWD == $home/jorisify ]]; then
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

# Git
#read -p $'What is your git global username? (e.g. Joris): ' GU
#read -p $'What is your git email address?: ' GE
#read -p $'What name would you like this system to get on GitLab? (e.g. JorisPC): ' GN

# Warn user of dangers
if dialog --stdout --title "Warning!" \
          --backtitle "Jorisify" \
          --yesno "This script does irreversable damage to your system!\
          are you sure you want to continue?" 10 50; then
    
    GU=$(dialog --backtitle "Jorisify" --title "Git username" --inputbox "What is your git global username? (e.g. Joris)" 8 40 \
    3>&1 1>&2 2>&3 3>&- )
    
    GE=$(dialog --backtitle "Jorisify" --title "Git email address" --inputbox "What is your git email address?" 8 40 \
    3>&1 1>&2 2>&3 3>&- )
    
    GN=$(dialog --backtitle "Jorisify" --title "Git system name" --inputbox "What name would you like this system to get on GitLab? (e.g. JorisPC)" 8 40 \
    3>&1 1>&2 2>&3 3>&- )

    # Installing packages and yay
    clear
    echo "Updating system and installing packages"
    pacman -Syyu --noconfirm 
    pacman -S --noconfirm $(cat pkglist.txt|xargs)
    git clone https://aur.archlinux.org/yay.git
    cd yay
    sudo -u $user makepkg -si
    cd ..
    rm -rf yay
    sudo -u $user yay -S --noconfirm $(cat pkglist_aur.txt|xargs)
    
    # Nuking old install files if present
    cd $home || return
    rm -rf $home/.config
    rm $home/.bashrc 

    # Virtualbox fix
    modprobe vboxdrv

    # Optimus switching fix
    mv /etc/X11/xorg.conf xorg.conf_ 

    # Backlight fix
    chmod +s /usr/bin/light
    gpasswd -a $user video

    # Grab GitLab repositories
    git config --global user.name ${GU}
    git config --global user.email ${GE}
    
    # Scripts
    git clone https://gitlab.com/jorisvandijk/scripts.git $home/Scripts
    cd $home/Scripts
    git remote set-url origin git@gitlab.com:jorisvandijk/scripts.git
    git remote -v
    cd $home || return

    # Dotfiles
    git clone https://gitlab.com/jorisvandijk/dotfiles.git $home/Dotfiles
    cd $home/Dotfiles
    git remote set-url origin git@gitlab.com:jorisvandijk/dotfiles.git
    git remote -v
    cd $home || return   

    # Wallpapers
    git clone https://gitlab.com/jorisvandijk/wallpapers.git $home/Pictures/wallpapers
    cd $home/Pictures/wallpapers
    git remote set-url origin git@gitlab.com:jorisvandijk/wallpapers.git
    git remote -v
    cd $home || return

    #Notes
    git clone https://gitlab.com/jorisvandijk/notes.git $home/Documents/Notes
    cd $home/Documents/Notes
    git remote set-url origin git@gitlab.com:jorisvandijk/notes.git
    git remote -v
    cd $home || return
    
    # FreeTube
    git clone https://gitlab.com/jorisvandijk/freetube.git $home/.config/FreeTube
    cd $home/.config/FreeTube
    git remote set-url origin git@gitlab.com:jorisvandijk/freetube.git
    git remote -v
    cd $home || return
    
    # Firefox
    git clone https://gitlab.com/jorisvandijk/firefox.git $home/.mozilla/firefox
    cd $home/.mozilla/firefox/
    git remote set-url origin git@gitlab.com:jorisvandijk/firefox.git
    git remote -v
    cd $home || return
    
    # Kee
    git clone https://gitlab.com/jorisvandijk/kee.git $home/Documents/Kee
    cd $home/Documents/Kee
    git remote set-url origin git@gitlab.com:jorisvandijk/kee.git
    git remote -v
    cd $home || return

    # Stow magic
    cd $home/Dotfiles/ || return
    for d in *; do stow -v -t ~ "$d" ;done
    cd $home || return

    # Setting up Vundle for Vim
    git clone https://github.com/VundleVim/Vundle.vim.git $home/.vim/bundle/Vundle.vim
    vim +PluginInstall +qall

    # SSH keygen
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
    rm -rf $home/jorisify_install
    exit
fi
#clear
echo -e "Installation is done!"
echo
echo -e "For Optimus to function correctly, please reboot!"
rm -rf $home/jorisify_install