# set fish_greeting "🐟"
# set fish_greeting ""

fish_add_path /usr/local/bin/
fish_add_path ~/Dropbox/JORGE/Webdev/_bin/

function fish_greeting
  pokemon-colorscripts -r --no-title
end

fish_vi_key_bindings

# Aliases
# NO NEED TO SOURCE SINCE IT IT SOURCED BY DEFAULT
# source $HOME/.config/fish/conf.d/abbr.fish

# ~/.config/fish/config.fish
starship init fish | source
