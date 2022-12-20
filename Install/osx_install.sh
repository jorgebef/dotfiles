#!/bin/sh

cd ~ && mkdir Developer && cd Developer
git clone https://github.com/jorgebef/dotfiles.git dotfiles

brew install fish
brew install neovim
brew install fd
brew install fish
brew install fzf
brew install gh
brew install git
brew install lazygit
brew install mackup
brew install neofetch
brew install neovim
brew install ripgrep
brew install starship
brew install tmux
brew install zoxide

#==============
# Remove old dot flies
#==============
sudo rm -rf $HOME/.tmux.conf > /dev/null 2>&1
sudo rm -rf $HOME/.zshrc > /dev/null 2>&1
sudo rm -rf $HOME/.config/kitty > /dev/null 2>&1
sudo rm -rf $HOME/.config/nvim > /dev/null 2>&1
sudo rm -rf $HOME/Brewfile > /dev/null 2>&1
sudo rm -rf $HOME/wezterm > /dev/null 2>&1

#==============
# Create symlinks in the home folder
# Allow overriding with files of matching names in the custom-configs dir
#==============
SYMLINKS=()
ln -sf $HOME/Developer/dotfiles/nvim $HOME/.config/nvim
SYMLINKS+=('nvim')
ln -sf $HOME/Developer/dotfiles/kitty $HOME/.config/kitty
SYMLINKS+=('Kitty')
ln -sf $HOME/Developer/dotfiles/custom-scripts $HOME/.custom-scripts
SYMLINKS+=('custom-scripts')
mkdir $HOME/.config/tmux
ln -sf $HOME/Developer/dotfiles/tmux/tmux.conf $HOME/.config/tmux/tmux.conf
SYMLINKS+=('tmux')
ln -sf $HOME/Developer/dotfiles/starship.toml $HOME/.config/starship.toml
SYMLINKS+=('starship')
ln -sf $HOME/Developer/dotfiles/fish $HOME/.config/fish
SYMLINKS+=('Fish')
ln -sf $HOME/Developer/dotfiles/.zshrc $HOME/.zshrc
SYMLINKS+=('.zshrc')
ln -sf $HOME/Developer/dotfiles/alacritty $HOME/.config/alacritty
SYMLINKS+=('Alacritty')
ln -sf $HOME/Developer/dotfiles/wezterm $HOME/.config/wezterm
SYMLINKS+=('wezterm')
ln -sf $HOME/Developer/dotfiles/Brewfile $HOME/Brewfile
SYMLINKS+=('Brewfile')

echo ${SYMLINKS[@]}

#==============
# Set fish as the default shell
#==============
chsh -s /opt/homebrew/bin/fish

#==============
# And we are done
#==============
echo -e "\n====== All Done!! ======\n"
echo
