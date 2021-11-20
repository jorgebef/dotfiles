test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
# Path to your oh-my-zsh installation.
export ZSH="${HOME}/.oh-my-zsh"
export EDITOR="nvim"
export VISUAL="nvim" 

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME=""

setopt promptsubst

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# ++++++++++++++++++++++ CUSTOM PROMPT ++++++++++++++++++++++++++++++++
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Load version control information
autoload -Uz vcs_info
# load helper function to manipulate hook arrays
autoload -Uz add-zsh-hook

function preexec() {
  cmd_start=$(($(print -P %D{%s%6.}) / 1000))
}

precmd_elapse() {
  if [ $cmd_start ]; then
    local now=$(($(print -P %D{%s%6.}) / 1000))
    local d_ms=$(($now - $cmd_start))
    local d_s=$((d_ms / 1000))
    local ms=$((d_ms % 1000))
    local s=$((d_s % 60))
    local m=$(((d_s / 60) % 60))
    local h=$((d_s / 3600))
    if   ((h > 0)); then cmd_time=${h}h${m}m
    elif ((m > 0)); then cmd_time=${m}m${s}s
    elif ((s > 9)); then cmd_time=${s}.$(printf %03d $ms | cut -c1-2)s # 12.34s
    elif ((s > 0)); then cmd_time=${s}.$(printf %03d $ms)s # 1.234s
    else cmd_time=${ms}ms
    fi
    unset cmd_start
  else
    # Clear previous result when hitting Return with no command to execute
    unset cmd_time
  fi
  # Required command to fetch git branch information
}
precmd_functions+=(precmd_elapse)

precmd_git() {
  vcs_info;
}
precmd_functions+=(precmd_git)


os_icon='%F{#e2e2e3}%B   %b%f'
separator='%F{#7f8490}|%f'

elapsed() {
    if [ $cmd_time ]; then
        echo " %F{#c4c4c6}$cmd_time 羽$separator%f";
    fi
}

branch() {
    if [ $vcs_info_msg_0_ ]; then
        echo " %F{green}$vcs_info_msg_0_ $separator%f";
    fi
}

cur_time() {
    echo " %F{#c4c4c6}%T  %f "
}

filepath() {
    case $PWD in
        /Users/jorgebefan )
            icon="  "
            ;;
        /Users/jorgebefan/Documents/Github* )
            icon="  "
            ;;
        /Users/jorgebefan/Downloads* )
            icon="  "
            ;;
        /Users/jorgebefan/Documents* )
            icon="  "
            ;;
        * )
            icon="ﱮ  "
            ;;
    esac
    split_path=(${(@s|/|)PWD})
    pwd_filtered="${PWD//\/Users\/jorgebefan/~}"
    if [[ "${pwd_filtered}" == "~" ]]; then
        pwd_rest=""
        pwd_folder="~"
    else
        pwd_rest=$(dirname "${pwd_filtered}")
        # add an extra "/" only if the directory is not already just "/"
        if [[ "${pwd_rest}" != "/" ]]; then
            pwd_rest="${pwd_rest}/"
        fi
        pwd_folder=$(basename "${pwd_filtered}")
    fi
    echo " %F{#6bb5c9}%B${icon}%b${pwd_rest}%f%F{blue}%B${pwd_folder}%b%f "
}

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats " %b"

# middle_space() {
#     pwdsize=${#${(%):-%~}} # +3 to adjust for the icon and 2 spaces
#     leftsize=$((pwdsize+4+6)) # +3+6 to adjust for the icons and separators
#     timesize=${#${(%):-%T}}
#     separatorsize=3
#     if [ $cmd_time ]; then
#         elapsedsize=${#cmd_time}
#         elapsedsize=$((elapsedsize+separatorsize))
#     else
#         elapsedsize=0
#     fi
#     if [ $vcs_info_msg_0_ ]; then
#         gitsize=${#vcs_info_msg_0_}
#         gitsize=$((gitsize+separatorsize))
#     else
#         gitsize=0
#     fi
#     rightsize=$((timesize+5+elapsedsize+gitsize))
#     repeat_count=$COLUMNS-$leftsize-$rightsize
#     printf "%0.s " {1..$((repeat_count))}
# }
# precmd_functions+=(middle_space)

_newline=$'\n'
_lineup=$'\e[1A'
_linedown=$'\e[1B'

PROMPT='%K{#414550}${os_icon}${separator}$(filepath)%k'
# PROMPT+='$(middle_space)'
# PROMPT+='%K{#414550}%F{blue}$(elapsed)%F{green}$(branch)%F{#e2e2e3}$(cur_time)%k%f'
PROMPT+='${_newline}'
# blue prompt if successful previous command, red if unsuccessful
PROMPT+='%(?:%F{blue} %f:%F{red} %f)'

RPROMPT='%{${_lineup}%}%K{#414550}$(elapsed)$(branch)$(cur_time)%k%{${_linedown}%}'

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#7f8490"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

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

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
