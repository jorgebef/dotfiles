#!/bin/bash

# Rewrite with fd to respect fd/ignore and git/ignore

dirs=$(find -L ~/Developer ~ ~/.config -mindepth 1 -maxdepth 1 -type d)
nice_dirs=$(echo "$dirs" | sed -r 's/\/Users\/jbef/~/g')

prev_dirs=$(echo "$nice_dirs" | xargs dirname | xargs basename)
cur_dirs=$(echo "$nice_dirs" | xargs basename)

# NOTE: $ shouldn't be in any paths name

workspaces=$(/opt/homebrew/bin/parallel --link echo ::: "$dirs" ::: "\$" ::: "$prev_dirs" ::: " 󰳠  " ::: "$cur_dirs")

workspaces="/Users/jbef \$ Home
$workspaces"

echo "$workspaces"
