# Set user and home
user=$SUDO_USER
home="/home/$user" 
GN="test"
sudo su
sudo -u $user ssh-keygen -t rsa -q -f "$home/.ssh/id_rsa" -N "" -C "$GN" && cat $home/.ssh/id_rsa.pub | xclip -sel clip