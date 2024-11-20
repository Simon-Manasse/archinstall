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