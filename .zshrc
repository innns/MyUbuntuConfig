# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set up the prompt

autoload -Uz promptinit
promptinit
prompt adam1

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

zinit light romkatv/powerlevel10k
zinit light zsh-users/zsh-autosuggestions
# >>>>>> This speeds up pasting w/ autosuggest
# https://github.com/zsh-users/zsh-autosuggestions/issues/238

pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}

pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish
# https://github.com/zsh-users/zsh-autosuggestions/issues/351
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(bracketed-paste accept-line)
# <<<<<< Paste
# 加载 OMZ 的 git 库
zinit snippet OMZ::lib/git.zsh
# 加载 OMZ 的 git 插件
zinit snippet OMZ::plugins/git/git.plugin.zsh
zinit ice blockf
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"

# DISPLAY
# export DISPLAY=$(grep -m 1 nameserver /etc/resolv.conf | awk '{print $2}'):0.0
# export DISPLAY=':0.0'
# export XDG_SESSION_TYPE=x11

export WIN_USER_DIR=/mnt/c/Users/urein
alias cdWinUserDir='cd $WIN_USER_DIR'

showAllColor(){
        for i in {0..255}; do print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}; done
}

# acConda(){
#   __conda_setup="$('/home/xiz/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
#   if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
#   else
#     if [ -f "/home/xiz/anaconda3/etc/profile.d/conda.sh" ]; then
#       . "/home/xiz/anaconda3/etc/profile.d/conda.sh"
#     else
#       export PATH="/home/xiz/anaconda3/bin:$PATH"
#     fi
#   fi
# unset __conda_setup
# }

# acConda

export PATH="/home/xiz/.local/bin:$PATH"

alias github=". /usr/bin/github"

gitcl() {
  # 不含有 'com/' 或者 'com:'
  # 例如: gc innns/junkcar
  if [ ${1:0:4} = "git@" -o ${1:0:6} = "https:" ]; then
    git clone $1
    return 0
  fi

  if [ ${1%'.com/'*} = $1 -o ${1%'.com:'*} = $1 ]; then
    # 不含有 '/' 则有问题啊
    if [ ${1%'/'*} = $1 ]; then
      echo "WRONG!!!"
      return 1
    else
      git clone "git@github.com:"$1
      return 0
    fi
  fi
}

ac() {
  if [ -f "/home/xiz/py_env/$1/bin/activate" ]; then
    . ~/py_env/$1/bin/activate
    echo "activate ~/py_env/$1/bin/activate"
  else
    echo "available env: "
    ls ~/py_env
  fi
}

alias deac="deactivate"
