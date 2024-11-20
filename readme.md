# Installation
```bash
loadkeys hu
sudo pacman -Sy git
git clone https://github.com/Simon-Manasse/archinstall
chmod +x archinstall/installArch.sh
./archinstall/installArch.sh
```


After getting into 
Add password when asked

in visudo

search for %wheel and uncomment it
At the end of the file add

`Defaults rootpw`