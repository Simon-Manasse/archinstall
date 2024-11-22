#!/bin/bash
sudo localectl set-x11-keymap hu
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
yay -S alacritty alsa-utils aylurs-gtk-shell base base-devel bash-completion bibata-cursor-theme bluedevil blueman bluez-utils bmake brave-bin breeze breeze-gtk breeze-plymouth bridge-utils brightnessctl btop certbot certbot-nginx cli-visualizer cliphist cmus cuda cudnn dhcpcd discord discord-screenaudio discover dnslookup dnsmasq docker dolphin drkonqi dunst espeak eza fastfetch fbida feh figlet firefox flatpak-kcm fzf git git-filter-repo gnome-calculator gnome-terminal go gobject-introspection gparted grim grimblast-git gum guvcview gvfs hdparm htop hypridle hyprland hyprlock hyprpaper hyprshade iptables-nft jack-example-tools jack2-dbus jdk-openjdk jq kactivitymanagerd kde-cli-tools kde-gtk-config kdeconnect kdecoration kdeplasma-addons kgamma kglobalacceld kinfocenter kmenuedit konsave konsole kpipewire krdp krita kscreen kscreenlocker ksshaskpass ksystemstats kwallet-pam kwayland kwin kwrited layer-shell-qt lib32-libglvnd lib32-nvidia-utils lib32-opencl-nvidia libglvnd libkscreen libksysguard libplasma libreoffice-fresh linux linux-firmware linux-headers logmein-hamachi lolcat lutris man-pages maxautoclicker milou minecraft-launcher mission-center mkcert ml4w-hyprland mpv nano nautilus nautilus-open-any-terminal ncdu neofetch neovim net-tools netctl network-manager-applet networkmanager nginx-mainline nm-connection-editor nmap noto-fonts-cjk nvidia-container-toolkit nvidia-dkms nvidia-settings nvidia-utils nvm nwg-look obsidian ocean-sound-theme ocs-url openbsd-netcat opencl-nvidia openrazer-daemon optimus-manager-git optimus-manager-qt otf-font-awesome oxygen oxygen-sounds pacman-contrib pacseek papirus-icon-theme pavucontrol pinta plantuml plasma-activities plasma-activities-stats plasma-browser-integration plasma-desktop plasma-disks plasma-firewall plasma-integration plasma-nm plasma-pa plasma-sdk plasma-systemmonitor plasma-thunderbolt plasma-vault plasma-welcome plasma-workspace plasma-workspace-wallpapers plasma5support plymouth-kcm polkit-gnome polkit-kde-agent polychromatic powerdevil print-manager python-pip python-pywal python-virtualenv qbittorrent qemu-base qjackctl qqc2-breeze-style qt5-graphicaleffects qt5-quickcontrols qt5-quickcontrols2 qt6ct quamachi remmina-git rofi-wayland rpcsvc-proto sddm sddm-kcm simplescreenrecorder slurp smile spectacle starship steam stow systemsettings teams-for-linux thunar ttf-fira-code ttf-fira-sans ttf-firacode-nerd ttf-font-awesome ttf-joypixels tumbler ufw viewnior virt-manager virt-viewer visual-studio-code-bin vkd3d vkd3d-proton-bin vulkan-amdgpu-pro wacomtablet waybar waypaper whatsapp-for-linux wine-gecko wine-staging winetricks wlogout xarchiver xclip xdg-desktop-portal-gtk xdg-desktop-portal-hyprland xdg-desktop-portal-kde xorg-bdftopcf xorg-iceauth xorg-mkfontscale xorg-server xorg-sessreg xorg-setxkbmap xorg-smproxy xorg-twm xorg-x11perf xorg-xauth xorg-xbacklight xorg-xclock xorg-xcmsdb xorg-xcursorgen xorg-xdpyinfo xorg-xdriinfo xorg-xev xorg-xgamma xorg-xhost xorg-xinit xorg-xinput xorg-xkbcomp xorg-xkbevd xorg-xkbprint xorg-xkbutils xorg-xkill xorg-xlsatoms xorg-xlsclients xorg-xmodmap xorg-xpr xorg-xrandr xorg-xrdb xorg-xrefresh xorg-xset xorg-xsetroot xorg-xvinfo xorg-xwd xorg-xwininfo xterm yay zsh zsh-completions
