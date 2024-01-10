# !!!!!!!!!!!!!!!!!!!!!!!!!!!
# !!!!!!!!! WARNING !!!!!!!!!
# !!!!!!!!!!!!!!!!!!!!!!!!!!!
# CHECK FILES INSIDE FOLDER conf.d/ since they are loaded first
# AS PER DOCUMENTATION:
# https://fishshell.com/docs/current/language.html#configuration:~:text=Configuration%20files%C2%B6

set -gx EDITOR (which nvim)
set -gx VISUAL $EDITOR
set -gx SUDO_EDITOR $EDITOR
set -gx PNPM_HOME $HOME/Library/pnpm
set -gx XDG_CONFIG_HOME $HOME/.config

fish_add_path "/usr/local/bin/" # Add local bin to $PATH
fish_add_path "$HOME/.config/bin/" # Add custom bin to $PATH
fish_add_path "$HOME/.cargo/bin/" # Add cargo bin to $PATH
fish_add_path "$PNPM_HOME" # Add pnpm path to $PATH
fish_add_path "$HOME/Library/CloudStorage/Dropbox/JORGE/Peninsula Studio/01 Documents & info/bin" # Add custom bin folder path to $PATH
# ~/.tmux/plugins
fish_add_path "$HOME/.config/tmux/plugins/t-smart-tmux-session-manager/bin"

function fish_greeting
  pokemon-colorscripts -r --no-title
  # ===========THIS ADDS TMUX AT INITIALIZATION=============
  if not set -q TMUX
    tmux a || tmux
  end
end

fish_vi_key_bindings
# fish_default_key_bindings

starship init fish | source
zoxide init fish | source
