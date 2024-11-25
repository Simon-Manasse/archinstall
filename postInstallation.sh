#!/bin/bash
sudo pacman -S xorg-server xorg-apps xorg-xinit xorg-twm xorg-xclock xterm plasma sddm --noconfirm
sudo systemctl enable sddm.service
sudo localectl set-x11-keymap hu
cd /home/simon
if ! command -v yay &> /dev/null; then
    echo "yay is not installed. Installing yay..."

    # Install git and base-devel if needed
    sudo pacman -S --needed git base-devel

    # Clone the yay repository and build it
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si

    # Clean up
    cd ..
    rm -rf yay

    echo "yay has been installed."
else
    echo "yay is already installed."
fi
sudo pacman -S neofetch
reboot