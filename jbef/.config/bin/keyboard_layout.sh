#!/bin/sh

# this reads the current keyboard layout from the macos system settings
# and prints it out in a clean way
# Currently used in the TMUX status bar

defaults read com.apple.HIToolbox | grep Current | sed 's/.*keylayout.\(.*\)";/\1/'
