# Installation
```bash
loadkeys hu
sudo pacman -Sy git
git clone https://github.com/Simon-Manasse/archinstall
chmod +x archinstall/installArch.sh
mount -o remount,size=2G /run/archiso/cowspace
./archinstall/installArch.sh
```


After getting into the mount:

```
sudo pacman -Sy git
cd home
git clone https://github.com/Simon-Manasse/archinstall
chmod +x archinstall/archroot-install.sh
./archinstall/archroot-install
```

Add password when asked

in visudo

search for %wheel and uncomment it
At the end of the file add

`Defaults rootpw`