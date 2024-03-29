#!/bin/bash

## ###############################################################
## First steps here to clone the repo
## ###############################################################
# cd ~ || mkdir Developer || cd Developer || return
# git clone https://github.com/jorgebef/dotfiles.git dotfiles
# cd dotfiles || return
# brew bundle install --file "$HOME/Developer/dotfiles/Brewfile"
## ###############################################################

CONFIG_DIR="$(realpath "$0" | xargs dirname | xargs dirname)"

echo "Creating symlinks"

# Only files directly inside jbef folder (eg. .tmux.conf, .zshrc, etc...)
files=$( find -H "$CONFIG_DIR/jbef" -maxdepth 1 -mindepth 1 -type f )
# All direct children inside .config folder (eg. nvim, yabai, etc...)
folders=$( find -H "$CONFIG_DIR/jbef/.config" -maxdepth 1 -mindepth 1 )

check_if_exists() {
  passed=$1
  target=$2
  #check if $passed is a file o a directory or not valid
  if [[ -d $passed ]]; then
    my_type="Directory"
elif [[ -f $passed ]]; then
    my_type="File"
else
    echo "$passed is not valid"
    exit 1
fi

  # Check whether the symlink already exists
  if [  -e "$target"  ] || [ -L "$target" ]; then
    echo "$my_type ~${passed#"$HOME"} already exists..."
    # echo "Replace? y/n"
    # read -r response
    # if [ "$response" = 'y' ]; then
    #   rm "$2"
    # else
      return
    # fi
  fi
  echo "Creating new symlink for $passed"
  ln -s "$passed" "$target"
}

# If file
for file in $files ; do
  target="$HOME/$( basename "$file" )"
  check_if_exists "$file" "$target"
done

# If directory
for folder in $folders ; do
  target="$HOME/.config/$( basename "$folder" )"
  check_if_exists "$folder" "$target"
done

## ###############################################################
# # Set fish as the default shell
# chsh -s /opt/homebrew/bin/fish
## ###############################################################

echo "====== All Done!! ======"
