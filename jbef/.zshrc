# PLUGINS ===============================================================================================
source "/opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "/opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# CONFIG FILES ==========================================================================================
source "$HOME/.config/zsh/path.zsh"
source "$HOME/.config/zsh/options.zsh"
source "$HOME/.config/zsh/alias.zsh"

# COMPLETIONS ===========================================================================================
[ -s "/Users/jbef/.bun/_bun" ] && source "/Users/jbef/.bun/_bun" # bun javascript runtime
# op (1Password)
eval "$(op completion zsh)"
compdef _op op

# eval is run just before dropping into the shell =======================================================
eval "$(fnm env --use-on-cd)"
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "pokemon-colorscripts -r --no-title"

autoload -U compinit
compinit

# # =========== Launch TMUX on shell initialisation ===========
# if [ "$TMUX" = "" ]; then
# 	tmux attach || tmux
# fi
