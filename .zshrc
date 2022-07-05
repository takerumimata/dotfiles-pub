# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Lines configured by zsh-newuser-install
export EDITORP=vim #エディタをvimに設定
export LANG=ja_JP.UTF-8 #文字コードをUTF-8に設定

# プロンプト設定
#PROMPT=$'%{\e[30;48;5;082m%}%{\e[38;5;001m%}[%n@%m]%{\e[0m%}'
# PROMPT="%F{0117}[%n:%~] $ %f"
# PROMPT="%F{0117}%~ $ %f"
# PROMPT="%F{0117}%~ %F{0196}❯%F{214}❯%F{041}❯%f "
eval "$(starship init zsh)"

# ビープ音を鳴らさない
setopt no_beep

# history
HISTFILE=~/work/dotfils/zsh/.zsh_hist
HISTSIZE=1000
SAVEHIST=1000
setopt extended_history #ヒストリに実行時間も保存
setopt hist_ignore_dups #直前と同じコマンドはヒストリに追加しない

# emacsのキーバインド
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall

autoload -Uz compinit
compinit

# cdした先のディレクトリをディレクトリスタックに追加
setopt auto_pushd

# pushdしたとき、ディレクトリがすでにスタックに含まれていればスタックに追加しない
setopt pushd_ignore_dups

# コマンドのスペルを訂正する
setopt correct

#エイリアス
alias la='ls -aG'
alias ll='ls -lG'
alias vz='vim ~/work/dotfiles/zsh/.zshrc'

# cdの後にlsを実行
#chpwd() { ls -ltrG  }

# 補完候補のメニュー選択で、矢印キーの代わりにhjklで移動出来るようにする。
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# ls
# export LSCOLORS=gxfxcxdxbxegedabagacag
export LS_COLORS='di=34;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;46'

# <Tab>でパス名の補完候補を表示したあと、
# 続けて<Tab>を押すと候補からパス名を選択することができるようになる
zstyle ':completion:*:default' menu select=1

autoload colors
zstyle ':completion:*' list-lolors "${LS_COLORS}"

# 補完候補もLS_COLORSに合わせて色が付くようにする
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# lsがカラー表示になるようエイリアスを設定
case "${OSTYPE}" in
darwin*)
  # Mac
  alias ls="ls -GF"
  ;;
linux*)
  # Linux
  alias ls='ls -F --color'
  ;;
esac

# End of lines added by compinstall

# go
export GOPATH=$HOME/gocode
export GOROOT=/usr/local/opt/go/libexec
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="refined"

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

source <(kubectl completion zsh)

# brew complition
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi

# Dockerの補完
if [ -e ~/.zsh/completions ]; then
    fpath=(~/.zsh/completions $fpath)
fi

# goenv init
export GOENV_ROOT=$HOME/.goenv
export PATH=$GOENV_ROOT/bin:$PATH
eval "$(goenv init -)"

# nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH

# bazel
export PATH="$PATH:$HOME/bin"

export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/mimatatakeru/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/mimatatakeru/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/mimatatakeru/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/mimatatakeru/google-cloud-sdk/completion.zsh.inc'; fi

# コマンド（関数）の作成
function work {
    cd ~/works/$1;
}

function _work {
    _files -W ~/works/ && return 0;
    return 1;
}

compdef _work work

# pythonのデフォルトをpython3にする
alias python=python3

source /Users/mimatatakeru/.config/broot/launcher/bash/br

# for aws cli
export AWS_DEFAULT_PROFILE=takeru-m1-max
# aws completion
complete -C '/usr/local/bin/aws_completer' aws


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
### End of Zinit's installer chunk

# syntax highlight for shell command
zinit light zsh-users/zsh-syntax-highlighting

# auto suggestion
zinit light zsh-users/zsh-autosuggestions

