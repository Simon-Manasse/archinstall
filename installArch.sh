#!/bin/zsh

# create partitions
sgdisk -n 1:0:+1G -t 1:ef00 -c 1:"boot" -n 2:0:+8G -t 2:8200 -c 2:"swap" -n 3:0:+70G -t 3:8300 -c 3:"root" -n 4:0:0 -t 4:8300 -c 4:"home" /dev/nvme0n1

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

# updating mirrorlist
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
sudo pacman -Sy  pacman-contrib --noconfirm
rankmirrors -n 6 /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist

# entering mount
pacstrap -K /mnt base linux linux-firmware base-devel --noconfirm
genfstab -U -p /mnt >> /mnt/etc/fstab
arch-chroot /mnt
