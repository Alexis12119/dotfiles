#!/bin/bash

# Install Zsh and Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Install Tpm for Tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Define package names
packages=(
  stow
  lazygit
  wezterm
  fzf
  fd
  picom
  ripgrep
  jdk-openjdk
  go
  go-tools
  ninja
  cmake
  sshfs
  composer
  rustup
  vlc
  zoom
  gparted
  xfce4-screenshooter
  pipewire
  pipewire-alsa
  pipewire-jack
  pipewire-pulse
  pavucontrol
  wireplumber
  pipewire-zeroconf
  filelight
  xclip
  unzip
  rofi
  tmux
  brightnessctl
  clang
  obs-studio
  sof-firmware
  bat
  alsa-ucm-conf
)

# Install necessary packages
for package in "${packages[@]}"; do
  if ! pacman -Qi "$package" &>/dev/null; then
    sudo pacman -Syu "$package"
  else
    echo "$package is already installed."
  fi
done

# Install bob for neovim-nightly
sudo pacman -Sy bob
bob use nightly

git clone https://github.com/Alexis12119/dotfiles.git ~/dotfiles
cd ~/dotfiles

stow */
