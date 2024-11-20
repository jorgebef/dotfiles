#!/bin/bash

cur_window="$(yabai -m query --windows --window | jq '.id')"
if [[ $(yabai -m query --spaces --display | jq '.[-1]."has-focus"') == "false" ]]; then
  yabai -m window --space next && yabai -m window --focus "$cur_window"
fi
