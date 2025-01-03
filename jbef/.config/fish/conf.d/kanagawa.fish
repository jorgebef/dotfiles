#!/usr/bin/fish

# Kanagawa Groove Fish shell theme
set -l foreground c5c9c5 normal
set -l selection 658594 brcyan
set -l comment 606071 brblack
set -l red c4746e red
set -l orange E46876 brred
set -l yellow DCA561 yellow
set -l green 76946A green
set -l purple b35b79 magenta
set -l blue 8ba4b0 blue
set -l cyan 2D4F67 cyan
set -l pink D27E99 brmagenta

# Syntax Highlighting Colors
set -g fish_color_normal $foreground
set -g fish_color_command $green
set -g fish_color_keyword $pink
set -g fish_color_quote $yellow
set -g fish_color_redirection $foreground
set -g fish_color_end $orange
set -g fish_color_error $red
set -g fish_color_param $blue
set -g fish_color_option $selection
set -g fish_color_comment $comment
set -g fish_color_selection --background=$selection
set -g fish_color_search_match --background=$selection
set -g fish_color_operator $green
set -g fish_color_escape $pink
set -g fish_color_autosuggestion $comment

# Completion Pager Colors
set -g fish_pager_color_progress $comment
set -g fish_pager_color_prefix $cyan
set -g fish_pager_color_completion $foreground
set -g fish_pager_color_description $comment
