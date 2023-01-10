# !!!!!!!!!!!!!!!!!!!!!!!!!!!
# !!!!!!!!! WARNING !!!!!!!!!
# !!!!!!!!!!!!!!!!!!!!!!!!!!!
# CHECK FILES INSIDE FOLDER conf.d/ since they are loaded first
# AS PER DOCUMENTATION:
# https://fishshell.com/docs/current/language.html#configuration:~:text=Configuration%20files%C2%B6

set -gx EDITOR (which nvim)
set -gx VISUAL $EDITOR
set -gx SUDO_EDITOR $EDITOR

fish_add_path /usr/local/bin/
fish_add_path $HOME/Dropbox/JORGE/Webdev/bin/
fish_add_path $HOME/.config/bin/
fish_add_path $HOME/.cargo/bin/

function fish_greeting
  pokemon-colorscripts -r --no-title
end

fish_vi_key_bindings

# ~/.config/fish/config.fish
starship init fish | source
