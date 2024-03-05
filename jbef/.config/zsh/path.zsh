# # PATH ==================================================================================================
# # additions or midifications of PATH variable ===========================================================
# if type brew &>/dev/null; then
# 	FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
# 	autoload -Uz compinit
# 	compinit
# fi

# autoload -Uz compinit
# for dump in ~/.zcompdump(N.mh+24); do
#   compinit
# done
# compinit -C

path+=("/Users/jbef/.bun/bin") # adds the packages installed as --global via bun
export PATH

fpath+="/opt/homebrew/share/zsh/site-functions"


# pnpm
export PNPM_HOME="/Users/jbef/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# =======================================================================================================
