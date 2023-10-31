#!/bin/bash

USERNAME=$(whoami)

mkdir ~/tmp
cd ~/tmp

wget https://tuna.moe/oh-my-tuna/oh-my-tuna.py

sudo python3 oh-my-tuna.py --global

sudo apt update

sudo apt install build-essential pkg-config cmake git screen net-tools wget curl gcc g++ -y
sudo apt install python3-pip -y

# 使mkfontscale和mkfontdir命令正常运行
sudo apt-get install ttf-mscorefonts-installer
# 使fc-cache命令正常运行
sudo apt-get install fontconfig

# set python3 default python

sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 150

#Download fonts
mkdir -p ~/Downloads/fonts_MesloLGS
cd ~/Downloads/fonts_MesloLGS
#wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
#wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
#wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
#wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf

wget https://gitee.com/keyboardkiller/MesloLGS_NF/raw/master/MesloLGS%20NF%20Regular.ttf
wget https://gitee.com/keyboardkiller/MesloLGS_NF/raw/master/MesloLGS%20NF%20Bold.ttf
wget https://gitee.com/keyboardkiller/MesloLGS_NF/raw/master/MesloLGS%20NF%20Italic.ttf
wget https://gitee.com/keyboardkiller/MesloLGS_NF/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf

sudo chmod 777 *
cd ..
#Install fonts
sudo mv fonts_MesloLGS /usr/share/fonts/
sudo mkfontscale
sudo mkfontdir
sudo fc-cache -fv

# zsh

# install
sudo apt install zsh -y
sh -c "$(curl -fsSL https://git.io/zinit-install)"
echo "To change default shell to zsh, use: "
echo "chsh -s $(which zsh)"
