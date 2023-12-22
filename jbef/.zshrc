export EDITOR="nvim"
export VISUAL="nvim"

setopt promptsubst

# Vi Mode for ZSH
bindkey -v

export DISABLE_AUTO_TITLE="true"

# ALIAS ================================================================================================
# aliases defined for zsh to recognize =================================================================
alias dev='cd ~/Developer'
alias kekw='cd ~/Developer'
alias la="ls -laG"
alias ta='tmux attach'
#=======================================================================================================

export FZF_DEFAULT_OPTS="\
--reverse \
--border rounded \
--no-info \
--pointer=' ' \
--marker=' ' \
--ansi \
--color='16,bg+:-1,gutter:-1,prompt:5,pointer:5,marker:6,border:4,label:4,header:italic'"

export FZF_TMUX_OPTS="-p 55%,60%"

export FZF_CTRL_R_OPTS="--border-label=' history ' \
--prompt='  '"

export ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# PATH ==================================================================================================
# additions or midifications of PATH variable ===========================================================
if type brew &>/dev/null; then
	FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
	autoload -Uz compinit
	compinit
fi
path+=('/Users/jbef/.bun/bin') # adds the packages installed as --global via bun
export PATH
# =======================================================================================================

source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# bun completions
[ -s "/Users/jbef/.bun/_bun" ] && source "/Users/jbef/.bun/_bun"

# EVAL ==================================================================================================
# run just before dropping into the shell ===============================================================
eval "$(fnm env --use-on-cd)"
eval "$(starship init zsh)"
eval "pokemon-colorscripts -r --no-title"
# =======================================================================================================
