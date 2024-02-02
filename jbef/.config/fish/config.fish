# !!!!!!!!!!!!!!!!!!!!!!!!!!!
# !!!!!!!!! WARNING !!!!!!!!!
# !!!!!!!!!!!!!!!!!!!!!!!!!!!
# CHECK FILES INSIDE FOLDER conf.d/ since they are loaded first
# AS PER DOCUMENTATION:
# https://fishshell.com/docs/current/language.html#configuration:~:text=Configuration%20files%C2%B6
# fish_config theme save "Catppuccin Mocha"

set -gx EDITOR (which nvim)
set -gx VISUAL $EDITOR
set -gx SUDO_EDITOR $EDITOR
set -gx PNPM_HOME $HOME/Library/pnpm
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx SSH_AUTH_SOCK "$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"

fish_add_path "/usr/local/bin/" # Add local bin to $PATH
fish_add_path "$HOME/.config/bin/" # Add custom bin to $PATH
fish_add_path "$HOME/.cargo/bin/" # Add cargo bin to $PATH
fish_add_path "$PNPM_HOME" # Add pnpm path to $PATH
fish_add_path "$HOME/Library/CloudStorage/Dropbox/JORGE/Peninsula Studio/01 Documents & info/bin" # Add custom bin folder path to $PATH

function fish_greeting
  pokemon-colorscripts -r --no-title
  # # ===========THIS ADDS TMUX AT INITIALIZATION=============
  # if not set -q TMUX
  #   tmux a || tmux
  # end
end

fish_vi_key_bindings
# fish_default_key_bindings

starship init fish | source
zoxide init fish | source
