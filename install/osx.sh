#!/bin/sh

cd ~ || mkdir Developer || cd Developer || return
git clone https://github.com/jorgebef/dotfiles.git dotfiles
cd dotfiles || return

brew bundle install --file "$HOME/Developer/dotfiles/Brewfile"

# brew install fish
# brew install neovim
# brew install fd
# brew install fish
# brew install fzf
# brew install gh
# brew install git
# brew install karabiner-elements
# brew install lazygit
# brew install mackup
# brew install neofetch
# brew install neovim
# brew install ripgrep
# brew install starship
# brew install tmux
# brew install zoxide

#==============
# Remove old dot flies
#==============
rm -rf "$HOME/.tmux.conf" > /dev/null 2>&1
rm -rf "$HOME/.zshrc" > /dev/null 2>&1
rm -rf "$HOME/.config/kitty" > /dev/null 2>&1
rm -rf "$HOME/.config/nvim" > /dev/null 2>&1
rm -rf "$HOME/Brewfile" > /dev/null 2>&1
rm -rf "$HOME/.config/wezterm" > /dev/null 2>&1
rm -rf "$HOME/.config/karabiner" > /dev/null 2>&1


declare -a TOOL_NAME=()
declare -a ORIGIN=()
declare -a DESTINATION=()

declare -a SUCCESSFUL=()
declare -a UNSUCCESSFUL=()

#==============
# Create symlinks in the home folder
# Allow overriding with files of matching names in the custom-configs dir
#==============

ORIGIN+=("$HOME/Developer/dotfiles/nvim")
DESTINATION+=("$HOME/.config/nvim")
TOOL_NAME+=('nvim')

ORIGIN+=("$HOME/Developer/dotfiles/kitty")
DESTINATION+=("$HOME/.config/kitty")
TOOL_NAME+=('Kitty')

ORIGIN+=("$HOME/Developer/dotfiles/custom-scripts")
DESTINATION+=("$HOME/.custom-scripts")
TOOL_NAME+=('custom-scripts')

ORIGIN+=("$HOME/Developer/dotfiles/tmux/tmux.conf")
DESTINATION+=("$HOME/.config/tmux/tmux.conf")
TOOL_NAME+=('tmux')

ORIGIN+=("$HOME/Developer/dotfiles/starship.toml")
DESTINATION+=("$HOME/.config/starship.toml")
TOOL_NAME+=('starship')

ORIGIN+=("$HOME/Developer/dotfiles/fish")
DESTINATION+=("$HOME/.config/fish")
TOOL_NAME+=('Fish')

ORIGIN+=("$HOME/Developer/dotfiles/.zshrc")
DESTINATION+=("$HOME/.zshrc")
TOOL_NAME+=('.zshrc')

ORIGIN+=("$HOME/Developer/dotfiles/alacritty")
DESTINATION+=("$HOME/.config/alacritty")
TOOL_NAME+=('Alacritty')

ORIGIN+=("$HOME/Developer/dotfiles/wezterm")
DESTINATION+=("$HOME/.config/wezterm")
TOOL_NAME+=('wezterm')

ORIGIN+=("$HOME/Developer/dotfiles/Brewfile")
DESTINATION+=("$HOME/.config/Brewfile")
TOOL_NAME+=('Brewfile')

ORIGIN+=("$HOME/Developer/dotfiles/karabiner")
DESTINATION+=("$HOME/.config/karabiner")
TOOL_NAME+=('karabiner-elements')

for ((i = 0; i < ${#TOOL_NAME[@]}; i++)); do
  if (
  ln -sf "${ORIGIN[$i]}" "${DESTINATION[$i]}"
    ); then
   SUCCESSFUL+=("${TOOL_NAME[$i]}")
 else
   UNSUCCESSFUL+=("${TOOL_NAME[$i]}")
  fi
done




echo "${TOOL_NAME[@]}"

#==============
# Set fish as the default shell
#==============
chsh -s /opt/homebrew/bin/fish

#==============
# And we are done
#==============
echo "====== All Done!! ======"
