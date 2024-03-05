# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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
# eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "pokemon-colorscripts -r --no-title"

autoload -U compinit
compinit

# # =========== Launch TMUX on shell initialisation ===========
# if [ "$TMUX" = "" ]; then
# 	tmux attach || tmux
# fi

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true
source ~/.config/zsh/plugins/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.config/zsh/p10k.zsh ]] || source ~/.config/zsh/p10k.zsh
