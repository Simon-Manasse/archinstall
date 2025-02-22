# adding basic packages
sudo pacman -S nano bash-completion --noconfirm

# generating locales
sed -i '/#en_US.UTF-8 UTF-8/s/^#//' /etc/locale.gen
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
export LANG=en_US.UTF-8

# updating timezones
ln -s /usr/share/zoneinfo/Europe/Amsterdam > /etc/localtime
hwclock --systohc --utc

# 32bit support
echo simon > /etc/hostname
systemctl enable fstrim.timer
sed -i -e 's/^#\[\(multilib\)\]/\[\1\]/' -e '/\[multilib\]/,/^$/s/^#Include = \/etc\/pacman.d\/mirrorlist/Include = \/etc\/pacman.d\/mirrorlist/' /etc/pacman.conf
sudo pacman -Sy
# creating users
passwd
useradd -m -g users -G wheel,storage,power -s /bin/bash simon
passwd simon
EDITOR=nano visudo

# boot
mkdir /boot/loader /boot/loader/entries
mount -t efivarfs efivarfs /sys/firmware/efi/efivars
bootctl install
cat <<'EOF' > /boot/loader/entries/arch.conf
title Arch
linux /vmlinuz-linux
initrd /initramfs-linux.img
EOF
echo "options root=PARTUUID=$(blkid -s PARTUUID -o value /dev/nvme0n1p3) rw nvidia-drm.modeset=1" >> /boot/loader/entries/arch.conf

# network setup
# sudo pacman -S dhcpcd --noconfirm
# sudo systemctl enable dhcpcd@enp1s0.service
sudo pacman -S networkmanager --noconfirm
sudo systemctl enable NetworkManager.service

# GPU
sudo pacman -Sy linux-headers nvidia-dkms libglvnd nvidia-utils opencl-nvidia lib32-libglvnd lib32-nvidia-utils lib32-opencl-nvidia nvidia-settings --noconfirm
sed -i 's/^MODULES=()/MODULES=(nvidia nvidia_modeset nvidia_urm nvidia_drm)/' /etc/mkinitcpio.conf
sudo mkdir /etc/pacman.d/hooks

cat << 'EOF' > /etc/pacman.d/hooks/nvidia.hook
[Trigger]
Operation=Install
Operation=Upgrade
Operation=Remove
Type=Package
Target=nvidia

[Action]
Depends=mkinitcpio
When=PostTransaction
Exec=/usr/bin/mkinitcpio -P
EOF

echo "you can run the finishinstall script"