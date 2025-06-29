#!/bin/bash

# Check if Script is Run as Root
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script, please run sudo ./install.sh" 2>&1
  exit 1
fi

# Update packages list and update system
apt update
apt full-upgrade -y


cp -r dotconfig/* /home/$username/.config/
cp background.jpg /home/$username/Pictures/background.jpg
mv user-dirs.dirs /home/$username/.config
chown -R $username:$username /home/$username

# Installing Essential Programs 
apt install feh bspwm betterlockscreen sxhkd kitty rofi polybar picom thunar lxpolkit x11-xserver-utils unzip wget curl build-essential pulseaudio pavucontrol -y
# Installing Other less important Programs
apt install neofetch flameshot psmisc lxappearance papirus-icon-theme fonts-noto-color-emoji lightdm -y
apt install autoconf imagemagick bc pkg-config libpam0g-dev libcairo2-dev libxss1 libappindicator1 libindicator7 libfontconfig1-dev libxcb-composite0-dev libev-dev libx11-xcb-dev libxcb-xkb-dev libxcb-xinerama0-dev libxcb-randr0-dev libxcb-image0-dev libxcb-util0-dev libxcb-xrm-dev libxkbcommon-dev libxkbcommon-x11-dev libjpeg-dev libgif-dev -y
# Install Chrome browser
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
apt install ./google-chrome-stable_current_amd64.deb -y

# Set up betterlockscreen for a lock screen
git clone https://github.com/Raymo111/i3lock-color.git
cd i3lock-color
./install-i3lock-color.sh
cd $builddir
rm -rf i3lock-color
wget https://raw.githubusercontent.com/betterlockscreen/betterlockscreen/main/install.sh -O - -q | sudo bash -s system
betterlockscreen -u ~/Pictures/background.jpg

# Download Nordic Theme and Nordzy cursor
cd /usr/share/themes/
git clone https://github.com/EliverLara/Nordic.git
cd $builddir
git clone https://github.com/alvatip/Nordzy-cursors
cd Nordzy-cursors
./install.sh
cd $builddir
rm -rf Nordzy-cursors

# Installing and setting up fonts
cd $builddir 
apt install fonts-font-awesome -y
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip
unzip FiraCode.zip -d /home/$username/.fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip
unzip Meslo.zip -d /home/$username/.fonts
mv dotfonts/fontawesome/otfs/*.otf /home/$username/.fonts/
chown $username:$username /home/$username/.fonts/*
fc-cache -vf
rm ./FiraCode.zip ./Meslo.zip


# Enable graphical login and change target from CLI to GUI
systemctl enable lightdm
systemctl set-default graphical.target

# Polybar configuration
cd $builddir
bash scripts/changeinterface


reboot