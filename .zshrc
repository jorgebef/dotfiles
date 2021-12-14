source $HOME/.zsh/antigen.zsh

# bundles to use
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
# antigen bundle zsh-users/zsh-history-substring-search

# Tell Antigen that you're done.
antigen apply


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
flamingo='#ECBFBD'
magenta='#C6AAE8'
pink='#F0AFE1'
red='#E28C8C'
peach='#F7C196'
yellow='#EADDA0'
green='#B3E1A3'
blue='#A4B9EF'
black1='#15121C'
black2='#1B1923'
black3='#1E1E28'
black4='#2D293B'
black5='#3e4058'
gray='#6E6C7C'
lightgray='#9E9EA9'
white='#D7DAE0'
teal='#9DDDCB'

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


os_icon='%F{$white}%B   %b%f'
separator='%F{$lightgray}● %f'

elapsed() {
    if [ $cmd_time ]; then
        echo " %F{$lightgray}$cmd_time 羽 $separator%f";
    fi
}

branch() {
    if [ $vcs_info_msg_0_ ]; then
        echo " %F{$green}$vcs_info_msg_0_ $separator%f";
    fi
}

cur_time() {
    echo " %F{$lightgray}%T  %f "
}

filepath() {
    case $PWD in
        /Users/jorgebefan )
            icon="  "
            ;;
        /Users/jorgebefan/Documents/Github* )
            icon="  "
            ;;
        /Users/jorgebefan/Downloads* )
            icon="  "
            ;;
        /Users/jorgebefan/Documents* )
            icon="  "
            ;;
        * )
            icon="  "
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
    echo " %F{$blue}${icon} %F{$lightgray}${pwd_rest}%f%F{$blue}%B${pwd_folder}%b%f "
}

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats " %b"


_newline=$'\n'
_lineup=$'\e[1A'
_linedown=$'\e[1B'

end_left='%F{$black5}%f'
end_right='%F{$black5}%f'

# PROMPT='$end_left%K{$black5}$os_icon$separator$(filepath)%k$end_right'
PROMPT='$end_left%K{$black5}$(filepath)%k$end_right'
# PROMPT+='$(middle_space)'
# PROMPT+='%K{#414550}%F{blue}$(elapsed)%F{green}$(branch)%F{#e2e2e3}$(cur_time)%k%f'
PROMPT+='${_newline}'
# blue prompt if successful previous command, red if unsuccessful
PROMPT+='%(?:%F{$blue} %f:%F{$red} %f)'

RPROMPT='%{$_lineup%}$end_left%K{$black5}$(elapsed)$(branch)$(cur_time)%k$end_right%{$_linedown%}'

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#7f8490"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
export CLICOLOR=1
# export LSCOLORS="ln=1;31:"
export LSCOLORS="Gxfxcxdxbxegedabagacad"

alias la="ls -laG"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
