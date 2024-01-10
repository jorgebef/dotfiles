# PATH ==================================================================================================
# additions or midifications of PATH variable ===========================================================
if type brew &>/dev/null; then
	FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
	autoload -Uz compinit
	compinit
fi

path+=("/Users/jbef/.bun/bin") # adds the packages installed as --global via bun
export PATH

fpath+="/opt/homebrew/share/zsh/site-functions"

autoload -Uz compinit
compinit
# =======================================================================================================
