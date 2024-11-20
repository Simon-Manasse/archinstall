#!/bin/zsh

# create partitions
sgdisk -n 1:0:+1G -t 1:ef00 -c 1:"boot" -n 2:0:+2G -t 2:8200 -c 2:"swap" -n 3:0:+5G -t 3:8300 -c 3:"root" -n 4:0:0 -t 4:8300 -c 4:"home" /dev/vda

# formating partitions
mkfs.fat -F32 /dev/nvme0n1p1
mkswap /dev/nvmen1p2
swapon /dev/nvmen1p2
mkfs.ext4 /dev/nvmen1p3
mkfs.ext4 /dev/nvmen1p4

# mounting partitions
mount /dev/nvmen1p3 /mnt
mkdir /mnt/boot /mnt/home
mount /dev/nvmen1p1 /mnt/boot
mount /dev/nvmen1p4 /mnt/home
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
sudo pacman -Sy  pacman-contrib --noconfirm
rankmirrors -n 6 /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist
pacstrap -K /mnt base linux linux-firmware base-devel --noconfirm
genfstab -U -p /mnt >> /mnt/etc/fstab
arch-chroot /mnt
sudo pacman -S nano bash-completion --noconfirm
sed '/#hu_Hu.UTF-8/s/^#//' /etc/locale.gen
locale-gen
echo LANG=hu_HU.UTF-8 > /etc/locale.conf
export LANG=hu_HU.UTF-8
ln -s /usr/share/zoneinfo/Europe/Amsterdam > /etc/localtime
hwclock --systohc --utc
echo simon > /etc/hostname
systemctl enable fstrim.timer
sed -i 's/^#\[multilib\]/\[multilib\]/; s/^#Include = \/etc\/pacman.d\/mirrorlist/Include = \/etc\/pacman.d\/mirrorlist/' /etc/pacman.conf
