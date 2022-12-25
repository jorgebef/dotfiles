#!/bin/sh

rm -rf "$HOME/Developer/dotfiles/Brewfile"
STEPS=()
if (
  brew bundle dump --file "$HOME/Developer/dotfiles/Brewfile"
  ); then
  STEPS+=('GOOD Brewfile created')
else
  printf "ERROR while creating brew bundle"
fi

echo "${STEPS[@]}"

printf "\n====== All Done!! ======\n"
