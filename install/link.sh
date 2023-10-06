#!/bin/bash

CONFIG_DIR="$(realpath "$0" | xargs dirname | xargs dirname)"

echo "Creating symlinks"

# Only files directly inside jbef folder (eg. .tmux.conf, .zshrc, etc...)
files=$( find -H "$CONFIG_DIR/jbef" -maxdepth 1 -mindepth 1 -type f )

# All direct children inside .config folder (eg. nvim, yabai, etc...)
folders=$( find -H "$CONFIG_DIR/jbef/.config" -maxdepth 1 -mindepth 1 )

check_if_exists() {
  # Check whether the symlink already exists
  if [  -e "$target"  ] || [ -L "$target" ]; then
    echo "~${target#"$HOME"} already exists..."
    echo "Replace? y/n"
    read -r response
  else
    echo "Creating new symlink for $1"
  fi
}

for file in $files ; do
  target="$HOME/$( basename "$file" )"
  # Check whether the symlink already exists
  if [  -e "$target"  ] || [ -L "$target" ]; then
    echo "FILE: ~${target#"$HOME"} already exists..."
    echo "Replace? y/n"
    read -r response
    if [ "$response" = 'y' ]; then
      rm "$target"
    else
      continue
    fi
  fi
  echo "Creating new symlink for $file"
  ln -s "$file" "$target"
done

# If folder file (eg. .tmux.conf)
for folder in $folders ; do
  target="$HOME/.config/$( basename "$folder" )"
  # Check whether the symlink already exists
  if [  -e "$target"  ] || [ -L "$target" ]; then
    echo "FOLDER: ~${target#"$HOME"} already exists..."
    echo "Replace? y/n"
    read -r response
    if [ "$response" = 'y' ]; then
      rm -rf "$target"
    else
      continue
    fi
  fi
  echo "Creating new symlink for $file"
  ln -s "$folder" "$target"
done
