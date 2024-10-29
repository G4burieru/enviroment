#!/bin/bash

# Install necessary packages
sudo apt update
sudo apt install -y curl python3-venv git build-essential lua5.4 liblua5.4-dev fd-find tmux tmuxinator ranger gcc unzip

# Create a temporary installation directory
mkdir -p temp_install
cd temp_install/

# Install ripgrep
if ! command -v rg &> /dev/null; then
    curl -LO https://github.com/BurntSushi/ripgrep/releases/download/14.1.0/ripgrep_14.1.0-1_amd64.deb
    sudo dpkg -i ripgrep_14.1.0-1_amd64.deb
fi

# Install luarocks and luasocket
if ! command -v luarocks &> /dev/null; then
    wget https://luarocks.org/releases/luarocks-3.11.1.tar.gz
    tar zxpf luarocks-3.11.1.tar.gz
    cd luarocks-3.11.1
    ./configure && make && sudo make install
    cd ..
fi

if ! luarocks list | grep -q luasocket; then
    sudo luarocks install luasocket
fi

# Install Node.js via NodeSource
if ! command -v node &> /dev/null; then
    curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash -
    sudo apt install -y nodejs
fi

# Install NVM and Node v20
if ! command -v nvm &> /dev/null; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
    source ~/.bashrc
    nvm install 20
fi

# Install Neovim
if ! command -v nvim &> /dev/null; then
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
    sudo rm -rf /opt/nvim
    sudo tar -C /opt -xzf nvim-linux64.tar.gz
    if ! grep -q 'export PATH="$PATH:/opt/nvim-linux64/bin"' ~/.bashrc; then
        echo 'export PATH="$PATH:/opt/nvim-linux64/bin"' >> ~/.bashrc
    fi
fi

# Install Nerd Fonts
if [ ! -f ~/.fonts/0xProto-Regular.ttf ]; then
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/0xProto.zip
    unzip -o 0xProto.zip -d ~/.fonts
    fc-cache -fv
fi

# Install Catppuccin theme for gnome-terminal
curl -L https://raw.githubusercontent.com/catppuccin/gnome-terminal/v0.3.0/install.py | python3 -

# Install LazyGit
if ! command -v lazygit &> /dev/null; then
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar xf lazygit.tar.gz lazygit
    sudo install lazygit /usr/local/bin
fi

cd ..

# Configure tmux and install plugins
if [ ! -d ~/.tmux/plugins/tpm ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

cp .tmux.conf ~/.tmux.conf

~/.tmux/plugins/tpm/bin/install_plugins

# Ranger configuration with ranger_cd alias
if ! grep -q 'alias ranger=ranger_cd' ~/.bashrc; then
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
fi

# Copy Neovim configuration
mkdir -p ~/.config/nvim
cp -rf nvim ~/.config/nvim

# Clean up temporary directory
rm -rf temp_install/

