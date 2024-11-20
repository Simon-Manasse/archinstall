# Installation
```bash
loadkeys hu
sudo pacman -Sy git
git clone https://github.com/Simon-Manasse/archinstall
cp archinstall/installArch.sh ./
chmod +x installArch.sh
./installArch.sh
```

Add password when asked

in visudo

search for %wheel and uncomment it
At the end of the file add

`Defaults rootpw`