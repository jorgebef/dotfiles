# # PATH ==================================================================================================
# # additions or midifications of PATH variable ===========================================================
# if type brew &>/dev/null; then
# 	FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
# 	autoload -Uz compinit
# 	compinit
# fi

export XDG_CONFIG_HOME="/Users/jbef/.config"

path+=("/opt/homebrew/bin") # adds the packages installed via Homebrew
path+=("/Users/jbef/.bun/bin") # adds the packages installed as --global via bun
export PATH

fpath+="/opt/homebrew/share/zsh/site-functions"

fpath=(~/.zsh/completion $fpath)

# pnpm
export PNPM_HOME="/Users/jbef/Library/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# =======================================================================================================

# fpath+="$HOME/.config/zsh/completion/_docker"
# EOT
