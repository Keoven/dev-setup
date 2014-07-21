# Ubuntu 14.04
#
# VM Setup:
# 2 Cores & 4 GB RAM
#
# Requirements:
# sudo apt-get install curl -y
#
# Run this script by doing the command below:
# > curl https://gist.githubusercontent.com/Keoven/4434598/raw/c88fab8d08177ac1a37d3db48f6ab9d866312fbe/ubuntu_setup.sh | sh
#

# Add all third party repositories
sudo add-apt-repository "deb http://archive.canonical.com/ $(lsb_release -sc) partner" -y
sudo add-apt-repository ppa:git-core/ppa -y
sudo apt-get update -y
sudo apt-get upgrade -y

# Install Environment Tools
sudo apt-get install git -y
sudo apt-get install tmux -y
sudo apt-get install autossh -y
sudo apt-get install silversearcher-ag -y

# Install Terminal Programs
sudo apt-get install highlight atool xpdf mediainfo -y
sudo apt-get install weechat -y
sudo apt-get install ranger -y

# Install Applications
sudo apt-get install electrum -y

# Setup dot files
cd ~
git clone --no-checkout git://github.com/Keoven/dotfiles.git dotfiles.tmp
mv dotfiles.tmp/.git .
git reset --hard HEAD
rm -rf dotfiles.tmp/

# Install ZSh
sudo apt-get install build-essential -y
sudo apt-get install ncurses-dev -y
cd ~
wget ftp://ftp.zsh.org/zsh/zsh-5.0.5.tar.gz
tar -xvzf zsh-5.0.5.tar.gz
cd zsh-5.0.5/
./configure --prefix=/usr/local
make
sudo make install
cd ~
rm -rf zsh-5.0.5*
cp /etc/shells .
echo $(which zsh) >> shells
sudo mv shells /etc/shells
chsh -s $(which zsh)
chsh -s $(which zsh) $USER

# Install Oh-My-ZSh
cd ~
rm -rf .oh-my-zsh
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
git checkout .

# Install Janus
sudo apt-get install vim-gtk ruby-dev rake -y
curl -Lo- https://bit.ly/janus-bootstrap | bash

# Setup Syntastic
sudo pip install flake8

# Powerline for Vim Ubuntu and additional vim plugins
cd ~
git clone https://github.com/pdf/ubuntu-mono-powerline-ttf.git ~/.fonts/ubuntu-mono-powerline-ttf
fc-cache -vf
mkdir .janus
cd .janus
git clone git://github.com/Lokaltog/vim-powerline.git
git clone git@github.com:editorconfig/editorconfig-vim.git
cd ~
git clone git://github.com/erikw/tmux-powerline.git
mv tmux-powerline .tmux-powerline

# Setup Window Manager
sudo apt-get install i3 -y
sudo apt-get install lxappearance -y

# Settings for gnome session with i3
gsettings set com.canonical.desktop.interface scrollbar-mode normal
gsettings set org.gnome.desktop.background show-desktop-icons false

# Install Docker
sudo apt-get install python-pip -y
sudo apt-get install docker.io -y
sudo ln -sf /usr/bin/docker.io /usr/local/bin/docker
sudo sed -i '$acomplete -F _docker docker' /etc/bash_completion.d/docker.io
sudo pip install -U fig
sudo groupadd docker
sudo gpasswd -a ${USERNAME} docker
sudo chmod o+rw /var/run/docker.sock
sudo service docker.io restart

# Install FASD
cd ~
wget https://github.com/clvv/fasd/tarball/1.0.1
tar -xvzf 1.0.1
cd clvv-fasd-4822024
sudo make install
cd ~
rm -rf 1.0.1 clvv-fasd-4822024

echo
echo Additional steps:
echo - Change font to "Ubuntu Mono Powerline"
echo - Under "Profile > Title and Command" set "Command"
echo   to "Run a custom command instead of my shell": `/usr/local/bin/zsh`
echo - Customize `.tmux-powerline/themes/default.sh`
echo - Install Google Chrome
echo - Setup Theme using `lxappearance`
echo - Reboot your computer: `sudo reboot`
