bindkey -v # Vi Mode for ZSH

setopt promptsubst

export EDITOR="nvim"
export VISUAL="nvim"

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

export DISABLE_AUTO_TITLE="true"

export ZSH_AUTOSUGGEST_STRATEGY=(history completion)

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
