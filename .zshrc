# Using OhMyZSH instead of Antigen

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# # Path to your oh-my-zsh installation.
# export ZSH="$HOME/.oh-my-zsh"
# export PATH=$PATH:$HOME/.local/bin

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"


# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# # Which plugins would you like to load?
# # Standard plugins can be found in $ZSH/plugins/
# # Custom plugins may be added to $ZSH_CUSTOM/plugins/
# # Example format: plugins=(rails git textmate ruby lighthouse)
# # Add wisely, as too many plugins slow down shell startup.
# plugins=(
#   # git
#   # macos
#   zsh-autosuggestions
#   zsh-syntax-highlighting
# )
# source $ZSH/oh-my-zsh.sh

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


export EDITOR="nvim"
export VISUAL="nvim" 

setopt promptsubst

# Vi Mode for ZSH
bindkey -v

# # +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# # ++++++++++++++++++++++ CUSTOM PROMPT ++++++++++++++++++++++++++++++++
# # +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# # Load version control information
# autoload -Uz vcs_info

# # load helper function to manipulate hook arrays
# autoload -Uz add-zsh-hook

# # ++++++++ COLORS ++++++++
# rosewater="#F4DBD6"
# flamingo="#F0C6C6"
# pink="#f5c2e7"
# mauve="#C6A0F6"
# red="#ED8796"
# maroon="#EE99A0"
# peach="#F5A97F"
# yellow="#EED49F"
# green="#a6e3a1"
# teal="#8BD5CA"
# sky="#91D7E3"
# sapphire="#7DC4E4"
# blue="#8AADF4"
# lavender="#B7BDF8"
# text="#cdd6f4"
# subtext1="#bac2de"
# subtext0="#a6adc8"
# overlay2="#9399b2"
# overlay1="#7f849c"
# overlay0="#6c7086"
# surface2="#585b70"
# surface1="#45475a"
# surface0="#313244"
# base="#1E1E2E"
# mantle="#181825"
# crust="#11111b"
# spec_surface="#3C3D53"
# # ++++++++ COLORS ++++++++


# function preexec() {
#   cmd_start=$(($(print -P %D{%s%6.}) / 1000))
# }

# precmd_elapse() {
#   if [ $cmd_start ]; then
#     local now=$(($(print -P %D{%s%6.}) / 1000))
#     local d_ms=$(($now - $cmd_start))
#     local d_s=$((d_ms / 1000))
#     local ms=$((d_ms % 1000))
#     local s=$((d_s % 60))
#     local m=$(((d_s / 60) % 60))
#     local h=$((d_s / 3600))
#     if   ((h > 0)); then cmd_time=${h}h${m}m
#     elif ((m > 0)); then cmd_time=${m}m${s}s
#     elif ((s > 9)); then cmd_time=${s}.$(printf %03d $ms | cut -c1-2)s # 12.34s
#     elif ((s > 0)); then cmd_time=${s}.$(printf %03d $ms)s # 1.234s
#     else cmd_time=${ms}ms
#     fi
#     unset cmd_start
#   else
#     # Clear previous result when hitting Return with no command to execute
#     unset cmd_time
#   fi
#   # Required command to fetch git branch information
# }
# precmd_functions+=(precmd_elapse)

# precmd_git() {
#   vcs_info;
# }
# precmd_functions+=(precmd_git)


# separator_right=''
# separator_left='⏽'
# _newline=$'\n'
# _lineup=$'\e[1A'
# _linedown=$'\e[1B'
# left_start='█'
# right_start='█'

# branchName(){
#   part=${vcs_info_msg_0_#*\[}
#   branchName=${part%]*}
#   echo "$branchName"
# }

# elapsed() {
#   if [ $cmd_time ]; then
#       echo "%F{$subtext0} ⌛$cmd_time%f";
#   fi
# }
# elapsed_separator() {
#   if [ $cmd_time ]; then
#     if [ $vcs_info_msg_0_ ]; then
#       echo "%F{{$surface0}$separator_left%f"
#     fi
#   else
#     echo ""
#   fi
# }

# icon() {
#     case $PWD in
#         /Users/jorgebefan )
#             icon=" "
#             ;;
#         ~/Downloads* )
#             icon=" "
#             ;;
#         ~/Documents* )
#             icon=" "
#             ;;
#         */Dropbox* )
#             icon=" "
#             ;;
#         */Google\ Drive* )
#             icon=" "
#             ;;
#         ~/Dev* )
#             icon=" "
#             ;;
#         * )
#             icon=" "
#             ;;
#     esac
#     echo "%F{$pink}$left_start%f%K{$pink}%F{$base}$icon%f%k"
#   }

# icon_separator() {
#   echo "%F{$pink}%K{$spec_surface}${separator_right}%k%f"
# }

# branch() {
#   if [ $vcs_info_msg_0_ ]; then
#     if [[ "$(branchName)" == "dev" ]]; then
#       echo "%K{$sapphire}%F{$base} %B $(branchName)%b %f%k";
#       # echo "%F{$sapphire} %B $(branchName)%b %k";
#     else
#       echo "%K{$green}%F{$base} %B $(branchName)%b %f%k";
#       # echo "%F{$green} %B $(branchName)%b %k";
#     fi
#   fi
# }


# filepath() {
#     split_path=(${(@s|/|)PWD})
#     pwd_filtered="${PWD//\/Users\/jorgebefan/~}"
#     if [[ "${pwd_filtered}" == "~" ]]; then
#         pwd_rest=""
#         pwd_folder="~"
#     else
#         pwd_rest=$(dirname "${pwd_filtered}")
#         # add an extra "/" only if the directory is not already just "/"
#         if [[ "${pwd_rest}" != "/" ]]; then
#             pwd_rest="${pwd_rest}/"
#             # pwd_rest=".../"
#         fi
#         pwd_folder=$(basename "${pwd_filtered}")
#     fi
#     echo "%F{$overlay2}%K{$spec_surface} ${pwd_rest}%f%F{$text}%B${pwd_folder} %b%f%k"
# }

# PROMPT='${_newline}'
# PROMPT+='$(icon)$(icon_separator)$(filepath)$(branch)$(elapsed)'
# PROMPT+='${_newline}'
# PROMPT+='%(?:%F{$green} %f:%F{$red} %f)'

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=${surface2}"


DISABLE_AUTO_TITLE="true"

# precmd() {
#   # sets the tab title to current dir
#   echo -ne "\e]1;${PWD##*/}\a"
# }



# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# # # ====================================================================
# # # NVM autocompletes and loading script lazy loading
# # # The load is postponed until node npm or nvm commands are run
# # # ====================================================================
# lazy_load_nvm() {
#   unset -f node
#   export NVM_DIR="$HOME/.nvm"
#     [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
#     [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
# }

# node() {
#   lazy_load_nvm
#   node $@
#   npm $@
#   nvm $@
# }

# =================================================================
# Custom scripts to make Dropbox ignore the files that are passed to the command
# =================================================================
alias dropbignore="zsh ~/.custom-scripts/dropbignore.sh"
alias dropbunignore="zsh ~/.custom-scripts/dropbunignore.sh"
alias envtovercel="sh ~/.custom-scripts/env-to-vercel.sh"

alias dev='cd ~/Developer'
alias kekw='cd ~/Developer'
alias la="ls -laG"

ZSH_AUTOSUGGEST_STRATEGY=(history completion)

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
  autoload -Uz compinit
  compinit
fi


source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

eval "$(starship init zsh)"
