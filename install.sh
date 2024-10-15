#!/bin/bash
sudo apt update;

# Install neovim, git, curl, vim-plug
echo -e "\nINSTALL neovim, git, curl, vim-plug...\n";
sudo apt install -y neovim;
sudo apt install -y git;
sudo apt install -y curl;
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim';

# Install python2, 3, pip
echo -e "\nINSTALL python2, 3, pip...\n";
sudo apt update;
sudo apt-get install -y software-properties-common;
echo "\n" | sudo add-apt-repository ppa:deadsnakes/ppa;
sudo apt-get update; 
sudo apt-get install -y python3.11;
sudo apt-get install -y python2.7;
sudo apt-get install -y python3-pip python3-dev;

# Install nodejs
echo -e "\nGET GPGKEY...\n";
sudo apt-get update;
sudo apt-get install -y ca-certificates curl gnupg;
sudo mkdir -p /etc/apt/keyrings;
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg;
NODE_MAJOR=20;
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list;
echo -e "\nINSTALL nodejs, npm...\n";
sudo apt-get update;
sudo apt-get install nodejs -y;
sudo apt install -y npm;

# Install pynvim & node nvim
echo -e "\nINSTALL pynvim & node nvim...\n";
sudo pip install pynvim;
sudo npm install -y neovim -g;

# Add config to nvim
echo -e "\nADDING CONFIG TO ~/.config/nvim/ ...\n";

rm init.vim;
rm coc-settings.json;
mv config.vim init.vim

if [! -d "~/.config/" ]; then
	mkdir ~/.config/;
	mkdir ~/.config/nvim;
fi

mv init.vim ~/.config/nvim/;
echo -e "\nOPEN NVIM AND TYPE :PlugInstall THEN EXIT TO APPLY THE PLUGIN\n";

