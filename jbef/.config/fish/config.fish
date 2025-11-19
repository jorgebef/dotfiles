# !!!!!!!!!!!!!!!!!!!!!!!!!!!
# !!!!!!!!! WARNING !!!!!!!!!
# !!!!!!!!!!!!!!!!!!!!!!!!!!!
# CHECK FILES INSIDE FOLDER conf.d/ since they are loaded first
# AS PER DOCUMENTATION:
# https://fishshell.com/docs/current/language.html#configuration:~:text=Configuration%20files%C2%B6
# fish_config theme save "Chia"

set -gx EDITOR (which nvim)
set -gx VISUAL $EDITOR
set -gx SUDO_EDITOR $EDITOR
set -gx PNPM_HOME $HOME/Library/pnpm
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx SSH_AUTH_SOCK "$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
set -gx NIX_PATH "nixpkgs=flake:nixpkgs:/nix/var/nix/profiles/per-user/root/channels"

set -gx LDFLAGS -L/opt/homebrew/opt/ruby/lib
set -gx CPPFLAGS -I/opt/homebrew/opt/ruby/include
set -gx PKG_CONFIG_PATH /opt/homebrew/opt/ruby/lib/pkgconfig

fish_add_path /opt/homebrew/bin # Add brew to $PATH
fish_add_path /opt/homebrew/opt/ruby/bin
fish_add_path /usr/local/bin/ # Add local bin to $PATH
fish_add_path "$HOME/.config/bin/" # Add custom bin to $PATH
fish_add_path "$HOME/.config/skhd/bin/" # Add custom bin to $PATH
fish_add_path "$HOME/.cargo/bin/" # Add cargo bin to $PATH
fish_add_path "$PNPM_HOME" # Add pnpm path to $PATH
fish_add_path "$HOME/.deno/bin" # Add pnpm path to $PATH
fish_add_path "$HOME/.local/bin" # Add uv path to $PATH
fish_add_path "$HOME/.venv/bin" # Add uv venv path to $PATH
fish_add_path "$HOME/.bun/bin"
fish_add_path "/Applications/Postgres.app/Contents/Versions/latest/bin"
fish_add_path "/run/current-system/sw/bin" # System-wide binaries managed by NixOS
# fish_add_path "$HOME/Library/CloudStorage/Dropbox/JORGE/Peninsula Studio/01 Documents & info/bin" # Add custom bin folder path to $PATH

# function fish_greeting
#   # pokemon-colorscripts -r --no-title
#   # # ===========THIS ADDS TMUX AT INITIALIZATION=============
#   # if not set -q TMUX
#   #   tmux a || tmux
#   # end
# end

set fish_greeting

function fish_user_key_bindings
    bind ctrl-d delete-char
end

set fish_user_key_bindings

fish_vi_key_bindings
set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore
set fish_cursor_visual block
set fish_vi_force_cursor 1

zoxide init fish | source
starship init fish | source
