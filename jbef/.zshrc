# PLUGINS ===============================================================================================
source "/opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "/opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# COMPLETIONS ===========================================================================================
[ -s "/Users/jbef/.bun/_bun" ] && source "/Users/jbef/.bun/_bun" # bun javascript runtime

# CONFIG FILES ==========================================================================================
source "$HOME/.config/zsh/options.zsh"
source "$HOME/.config/zsh/alias.zsh"
source "$HOME/.config/zsh/path.zsh"

# eval is run just before dropping into the shell =======================================================
eval "$(fnm env --use-on-cd)"
eval "$(starship init zsh)"
eval "pokemon-colorscripts -r --no-title"
