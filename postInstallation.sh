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
yay -S neofetch konsole base-devel cmake visual-studio-code-bin obsidian npm optimus-manager optimus-manager-qt brave-bin teams-for-linux --noconfirm
sudo systemctl enable optimus-manager
git config --global credential.helper store
git config --global --add --bool push.autoSetupRemote true
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sudo git clone https://github.com/zsh-users/zsh-autosuggestions.git /home/simon/.oh-my-zsh/custom/plugins/zsh-autosuggestions
sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /home/simon/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/' ~/.zshrc
sudo rm -f /home/simon/.config/autostart/secondPart.desktop
source ~/.zshrc
code --install-extension christian-kohler.path-intellisense
code --install-extension eamodio.gitlens
code --install-extension james-yu.latex-workshop
code --install-extension mads-hartmann.bash-ide-vscode
code --install-extension mathematic.vscode-latex
code --install-extension mechatroner.rainbow-csv
code --install-extension mhutchie.git-graph
code --install-extension ms-azuretools.azure-dev
code --install-extension ms-azuretools.vscode-azureappservice
code --install-extension ms-azuretools.vscode-azurecontainerapps
code --install-extension ms-azuretools.vscode-azurefunctions
code --install-extension ms-azuretools.vscode-azureresourcegroups
code --install-extension ms-azuretools.vscode-azurestaticwebapps
code --install-extension ms-azuretools.vscode-azurestorage
code --install-extension ms-azuretools.vscode-azurevirtualmachines
code --install-extension ms-azuretools.vscode-cosmosdb
code --install-extension ms-python.debugpy
code --install-extension ms-python.python
code --install-extension ms-python.vscode-pylance
code --install-extension ms-toolsai.jupyter
code --install-extension ms-toolsai.jupyter-keymap
code --install-extension ms-toolsai.jupyter-renderers
code --install-extension ms-toolsai.vscode-jupyter-cell-tags
code --install-extension ms-toolsai.vscode-jupyter-slideshow
code --install-extension ms-vscode.azure-account
code --install-extension ms-vscode.cpptools
code --install-extension ms-vscode.vscode-node-azure-pack
code --install-extension pkief.material-icon-theme
code --install-extension robbowen.synthwave-vscode
code --install-extension rocketseat.theme-omni
code --install-extension rogalmic.bash-debug
code --install-extension shakram02.bash-beautify
code --install-extension torn4dom4n.latex-support

cat << "CODE" > $HOME/.config/Code/User/settings.json
{
    "workbench.colorTheme": "SynthWave '84",
    "workbench.iconTheme": "material-icon-theme"
}

CODE

git clone https://github.com/nareshv/kde-konsole-colorschemes.git
cd kde-konsole-colorschemes
cp *.colorscheme ~/.local/share/konsole

# Set variables
PROFILE_NAME="test"
COLOR_SCHEME="bl1nk"
PROFILE_DIR="$HOME/.local/share/konsole"
PROFILE_FILE="$PROFILE_DIR/$PROFILE_NAME.profile"
KONSOLE_CONFIG_FILE="$HOME/.config/konsolerc"

# Check if Konsole profile directory exists
if [ ! -d "$PROFILE_DIR" ]; then
    mkdir -p "$PROFILE_DIR"
fi

# Create a new profile
cat <<EOL > "$PROFILE_FILE"
[Appearance]
ColorScheme=$COLOR_SCHEME

[General]
Name=$PROFILE_NAME
Command=/bin/zsh
EOL

# Update the konsolerc configuration file to set the new profile as default
if [ -f "$KONSOLE_CONFIG_FILE" ]; then
    # Check if DefaultProfile already exists in konsolerc
    if grep -q "DefaultProfile" "$KONSOLE_CONFIG_FILE"; then
        sed -i "s/^DefaultProfile=.*/DefaultProfile=$PROFILE_NAME.profile/" "$KONSOLE_CONFIG_FILE"
    else
        echo "[Desktop Entry]" > "$KONSOLE_CONFIG_FILE"
        echo "DefaultProfile=$PROFILE_NAME.profile" >> "$KONSOLE_CONFIG_FILE"
    fi
fi

# Output the result
echo "Profile '$PROFILE_NAME' created and set as default with color scheme '$COLOR_SCHEME'."

sed -i '/\[Favorite Profiles\]/,/^$/ s/^Favorites=.*/Favorites='$PROFILE_NAME'.profile/' ~/.config/konsolerc || echo -e "[Favorite Profiles]\nFavorites=$PROFILE_NAME.profile" >> ~/.config/konsolerc

sed -i 's/Opacity=.*/Opacity=0.79/' ~/.local/share/konsole/bl1nk.colorscheme


reboot