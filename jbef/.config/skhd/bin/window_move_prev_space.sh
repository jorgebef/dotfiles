#!/bin/bash

cur_window="$(yabai -m query --windows --window | jq '.id')"
if [[ $(yabai -m query --spaces --display | jq '.[0]."has-focus"') == "false" ]]; then
  yabai -m window --space prev --focus
fi
