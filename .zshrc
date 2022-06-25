# Using OhMyZSH instead of Antigen

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export PATH=$PATH:$HOME/.local/bin

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"

# bindkey -v

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
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

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
  macos
  zsh-autosuggestions
  zsh-syntax-highlighting
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
alias lvim='/Users/jorgebefan/.local/bin/lvim'


export EDITOR="nvim"
export VISUAL="nvim" 

setopt promptsubst

# Vi Mode for ZSH
bindkey -v

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# ++++++++++++++++++++++ CUSTOM PROMPT ++++++++++++++++++++++++++++++++
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Load version control information
autoload -Uz vcs_info
# load helper function to manipulate hook arrays
autoload -Uz add-zsh-hook

# ++++++++ COLORS ++++++++

rosewater="#F4DBD6"
flamingo="#F0C6C6"
pink="#F5BDE6"
mauve="#C6A0F6"
red="#ED8796"
maroon="#EE99A0"
peach="#F5A97F"
yellow="#EED49F"
green="#A6DA95"
teal="#8BD5CA"
sky="#91D7E3"
sapphire="#7DC4E4"
blue="#8AADF4"
lavender="#B7BDF8"
text="#CAD3F5"
subtext1="#B8C0E0"
subtext0="#A5ADCB"
overlay2="#939AB7"
overlay1="#8087A2"
overlay0="#6E738D"
surface2="#5B6078"
surface1="#494D64"
surface0="#363A4F"
base="#24273A"
mantle="#1E2030"
crust="#181926"

# ++++++++ COLORS ++++++++


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


separator_left=''
separator_right=''

_newline=$'\n'
_lineup=$'\e[1A'
_linedown=$'\e[1B'

left_start=''
right_start=''

branchName(){
  part=${vcs_info_msg_0_#*\[}
  branchName=${part%]*}
  echo "$branchName"
}

elapsed() {
  if [ $cmd_time ]; then
      echo "%F{$surface1}$separator_left%f%K{$surface1}%F{$subtext0} $cmd_time 羽%f%k";
  fi
}
elapsed_separator() {
  if [ $cmd_time ]; then
    if [ $vcs_info_msg_0_ ]; then
      if [[ "$(branchName)" == "dev" ]]; then
        echo "%F{$yellow}%K{$surface1}$separator_left%k%f";
      else
        echo "%F{$green}%K{$surface1}$separator_left%k%f";
      fi
    fi
  else
    if [ $vcs_info_msg_0_ ]; then
      if [[ "$(branchName)" == "dev" ]]; then
        echo "%F{$yellow}%K{$base}$separator_left%k%f";
      else
        echo "%F{$green}%K{$base}$separator_left%k%f";
      fi
    fi
  fi
}

branch() {
  if [ $vcs_info_msg_0_ ]; then
    if [[ "$(branchName)" == "dev" ]]; then
      echo "%K{$yellow}%F{$base} %B $(branchName)%b %f%k";
    else
      echo "%K{$green}%F{$base} %B $(branchName)%b %f%k";
    fi
  fi
}
branch_separator() {
  if [ $vcs_info_msg_0_ ]; then
    if [[ "$(branchName)" == "dev" ]]; then
      echo "%F{$surface2}%K{$yellow}$separator_left%k%f";
    else
      echo "%F{$surface2}%K{$green}$separator_left%k%f";
    fi
  else
    if [ $cmd_time ]; then
      echo "%F{$surface2}%K{$surface1}$separator_left%k%f";
    else
      echo "%F{$surface2}%K{$base}$separator_left%k%f";
    fi
  fi
}

cur_time() {
    echo "%B%K{$surface2} %F{$text}%T  %f%b%K{$base}%F{$surface2}$right_start%f%k"
}

icon() {
    case $PWD in
        /Users/jorgebefan )
            icon=" "
            ;;
        /Users/jorgebefan/Dropbox/JORGE/git* )
            icon=" "
            ;;
        /Users/jorgebefan/Downloads* )
            icon="  "
            ;;
        /Users/jorgebefan/Documents* )
            icon="  "
            ;;
        /Users/jorgebefan/Dropbox* )
            icon="  "
            ;;
        * )
            icon=" "
            ;;
    esac
    echo "%F{$pink}$left_start%f%K{$pink}%F{$base} $icon %f%k"
  }

filepath() {
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
    echo "%F{$overlay2}%K{$surface1} ${pwd_rest}%f%F{$text}%B${pwd_folder} %b%f%k"
}

# Format the vcs_info_msg_0_ variable
# zstyle ':vcs_info:git:*' formats " %b"

PROMPT='${_newline}'
PROMPT+='$(icon)%F{$pink}%K{$surface1}${separator_right}%k%f$(filepath)%F{$surface1}$separator_right%f'
PROMPT+='${_newline}'
PROMPT+='%(?:%F{$green} %f:%F{$red} %f)'
RPROMPT='%{$_lineup%}$(elapsed)$(elapsed_separator)$(branch)$(branch_separator)$(cur_time)%k%{$_linedown%}'

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=${surface2}"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# export CLICOLOR=1
# export LSCOLORS="ln=1;31:"
# export LSCOLORS="Gxfxcxdxbxegedabagacad"

DISABLE_AUTO_TITLE="true"

precmd() {
  # sets the tab title to current dir
  echo -ne "\e]1;${PWD##*/}\a"
}

# alias la="ls -laG"

# =================================================================
# Custom scripts to make Dropbox ignore the files that are passed to the command
# =================================================================
alias dropbignore="zsh ~/.custom-scripts/dropbignore.sh"
alias dropbunignore="zsh ~/.custom-scripts/dropbunignore.sh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
