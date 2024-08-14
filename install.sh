#!/bin/bash

sudo apt install curl -y
sudo apt install python3-venv -y
sudo apt install git -y
sudo apt-get install build-essential -y

mkdir ~/temp_install
cd ~/temp_install
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/14.1.0/ripgrep_14.1.0-1_amd64.deb
sudo dpkg -i ripgrep_14.1.0-1_amd64.deb

sudo apt install lua5.4
sudo apt install liblua5.4-dev

wget https://luarocks.org/releases/luarocks-3.11.1.tar.gz
tar zxpf luarocks-3.11.1.tar.gz
cd luarocks-3.11.1
./configure && make && sudo make install
sudo luarocks install luasocket

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux64.tar.gz

echo 'export PATH="$PATH:/opt/nvim-linux64/bin"' >> ~/.bashrc

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
source ~/.bashrc
nvm install 20

sudo apt install gcc

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/0xProto.zip

unzip 0xProto.zip -d ~/.fonts

fc-cache -fv

curl -L https://raw.githubusercontent.com/catppuccin/gnome-terminal/v0.3.0/install.py | python3 -

sudo apt install fd-find

LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin

sudo apt install tmux

echo '[ -z "$TMUX"  ] && { tmux attach || exec tmux new-session && exit;}' >> ~/.bashrc

cp .tmux.conf ~/

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

~/.tmux/plugins/tpm/bin/install_plugins

sudo apt install tmuxinator

sudo apt install ranger

echo 'ranger_cd() {
    tempfile=$(mktemp)
    ranger --choosedir="$tempfile" -- "${@:-$PWD}"
    if [ -f "$tempfile" ]; then
        dest=$(cat "$tempfile")
        if [ -d "$dest" ]; then
            cd "$dest"
        fi
        rm -f "$tempfile"
    fi
}
alias ranger=ranger_cd
' >> ~/.bashrc

cd ~/
rm -rf ~/temp_install

cp -rf nvim/ ~/.config/
