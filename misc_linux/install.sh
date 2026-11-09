# install
sudo apt install git gcc i3\
 python3 pyenv python3-pip python3-venv uv pipx\
 npm curl wget\
 kitty tmux picom\
 neovim ripgrep\
 xclip scrot feh arandr\
 ncdu mc ranger vifm rsync thunar\
 htop btop\
 pavucontrol playerctl\
 bluez bluez-utils blueman pulseaudio-bluetooth\
 sqlite dunst noto-fonts-emoji pkg-config\
 ffmpeg keepassxc\
 docker docker-compose\
 chromium firefox\
 flatpak snap

# zsh
sudo apt install zsh
sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

# installing fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip 
sudo mkdir -p /usr/share/fonts
sudo mkdir -p /usr/share/fonts/JetBrainsMono
mkdir JetBrainsMono && mv JetBrainsMono.zip JetBrainsMono/ && cd JetBrainsMono
unzip JetBrainsMono.zip && sudo cp *.ttf /usr/share/fonts/JetBrainsMono
cd .. && rm -rf JetBrainsMono
fc-cache
cd ~

# dev
curl -fsSL https://awscli.amazonaws.com/v2/install.sh | zsh

# pipx
pipx install ruff
pipx install jedi-language-server
pipx install clickhouse-cli
pipx install pgcli
pipx install litecli
pipx install mycli
pipx install jiratui

# brew prerequisites
# Debian or Ubuntu
# sudo apt-get install build-essential procps curl file git
# Fedora
# sudo dnf group install development-tools
# sudo dnf install procps-ng curl file
# CentOS Stream or RHEL
# sudo dnf group install 'Development Tools'
# sudo dnf install procps-ng curl file
# Arch Linux
# sudo pacman -S base-devel procps-ng curl file git
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.zshrc
# dev brew
brew install glab gh
# misc brew
brew install abseil bzip2 expat icu4c jira-cli libnghttp2 lua-language-server mongosh ncurses openssl simdutf uv xz ada-url c-ares fmt libedit libuv lz4 mpdecimal node pipx readline sqlite uvwasi zlib-ng-compat brotli ca-certificates hdrhistogram_c ipython libffi llhttp merve nbytes simdjson terraform vagrant zstd

# tg
mkdir ~/src && cd ~/src
wget https://telegram.org/dl/desktop/linux && tar -xvf td-setup*.tar.xz
# TODO: install or cp
cd ~

# flatpak
flatpak install moonlight organicmaps
