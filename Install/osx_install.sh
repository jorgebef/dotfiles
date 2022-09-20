#==============
# Remove old dot flies
#==============
sudo rm -rf ~/.tmux.conf > /dev/null 2>&1
sudo rm -rf ~/.zshrc > /dev/null 2>&1
sudo rm -rf ~/.config/kitty > /dev/null 2>&1
sudo rm -rf ~/.config/nvim > /dev/null 2>&1
sudo rm -rf ~/Brewfile > /dev/null 2>&1
sudo rm -rf ~/wezterm > /dev/null 2>&1

#==============
# Create symlinks in the home folder
# Allow overriding with files of matching names in the custom-configs dir
#==============
SYMLINKS=()
ln -sf ~/Developer/dotfiles/nvim ~/.config/nvim
SYMLINKS+=('nvim')
ln -sf ~/Developer/dotfiles/kitty ~/.config/kitty
SYMLINKS+=('Kitty')
ln -sf ~/Developer/dotfiles/custom-scripts ~/.custom-scripts
SYMLINKS+=('custom-scripts')
ln -sf ~/Developer/dotfiles/.tmux.conf ~/.tmux.conf
SYMLINKS+=('.tmux.conf')
ln -sf ~/Developer/dotfiles/starship.toml ~/.config/starship.toml
SYMLINKS+=('starship')
ln -sf ~/Developer/dotfiles/fish ~/.config/fish
SYMLINKS+=('Fish')
ln -sf ~/Developer/dotfiles/.zshrc ~/.zshrc
SYMLINKS+=('.zshrc')
ln -sf ~/Developer/dotfiles/wezterm ~/.config/wezterm
SYMLINKS+=('wezterm')
ln -sf ~/Developer/dotfiles/Brewfile ~/Brewfile
SYMLINKS+=('Brewfile')

echo ${SYMLINKS[@]}

#==============
# Set fish as the default shell
#==============
brew install fish
chsh -s /opt/homebrew/bin/fish

#==============
# And we are done
#==============
echo -e "\n====== All Done!! ======\n"
echo
