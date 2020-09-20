# zsh, oh-my-zsh, antigen setup for mac
# on mac you need to install:
# brew install zsh antigen zsh-completions
# find more information @ https://meabed.com/zsh-oh-my-zsh-up-and-running

source /usr/local/share/antigen/antigen.zsh

export PATH="/Applications/MacPorts/Emacs.app/Contents/MacOS:$PATH"
export LSCOLORS='exfxcxdxbxegedabagacad'
export CLICOLOR=true

# =====================
# Default text editor
# =====================
export EDITOR="emacsclient -c"

export PAGER='less'
export LESS='-giAMR'

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Load local sh, export, for example export GOPATH, export JAVA_HOME, export ANDROID_SDK, etc...
[[ -s "$HOME/.export" ]] && source "$HOME/.export"

# autojump setup:
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# Load the oh-my-zsh's library
antigen use oh-my-zsh

# bundle antigen zsh plugins @ https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins
antigen bundles <<EOBUNDLES
	common-aliases
	history 
	git 
	docker 
	zsh_reload 
	autojump 
	zsh-users/zsh-completions
	zsh-users/zsh-autosuggestions
  unixorn/autoupdate-antigen.zshplugin
EOBUNDLES

# Load the theme @ https://github.com/robbyrussell/oh-my-zsh/tree/master/themes/
# Load the theme
# simple and fast
# antigen theme agnoster
antigen theme avit
# cool but slow
# antigen theme https://github.com/denysdovhan/spaceship-zsh-theme spaceship

# syntax highlighting must come below the bundle to set the correct paths/variables with history search
antigen bundle zdharma/fast-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search

# Tell antigen that you're done
antigen apply

# emacs vterm shell config, see: https://github.com/akermu/emacs-libvterm
vterm_printf(){
    if [ -n "$TMUX" ]; then
        # Tell tmux to pass the escape sequences through
        # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
        printf "\ePtmux;\e\e]%s\007\e\\" "$1"
    elif [ "${TERM%%-*}" = "screen" ]; then
        # GNU screen (screen, screen-256color, screen-256color-bce)
        printf "\eP\e]%s\007\e\\" "$1"
    else
        printf "\e]%s\e\\" "$1"
    fi
}

# LOAD CUSTOM COLORS FOR NVIM/TMUX GRUVBOX THEME ONLY
#source "$HOME/.vim/bundle/gruvbox/gruvbox_256palette.sh"
source "$HOME/.local/share/nvim/plugged/gruvbox/gruvbox_256palette.sh"
# bind keys
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

# Extra zsh variables - history, auto-completion etc...
HISTFILE=~/.zsh_history         # where to store zsh config
HISTSIZE=10240000               # big history
SAVEHIST=10240000               # big history
LISTMAX=999999

# auto-completion with selection / menu / error correction / cache / etc...
zstyle ':completion:*:*:*:*:*' menu select

zstyle ':completion:*' verbose true
zstyle ':completion:*' menu yes select=1
zstyle ':completion:*' substitute 0
zstyle ':completion:*' max-errors 2 not-numeric
zstyle ':completion:*' original true
zstyle ':completion:*' use-cache true
zstyle ':completion:*' cache-path ~/.zsh/cache              
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' file-sort links reverse
zstyle ':completion:*:commands' rehash true
zstyle ':completion:*:functions' ignored-patterns '_*'

zstyle ':completion:*' completer _expand _complete _approximate
zstyle ':completion:*' completions 1
zstyle ':completion:*' glob 1
zstyle ':completion:*' group-name ''
zstyle ':completion:*' ignore-parents parent pwd ..
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' matcher-list '' '+m:{a-z}={A-Z} r:|[._-]=* r:|=*' '' 'l:|=* r:|=*'
zstyle ':completion:*:messages' format $'\e[00;31m%d'
zstyle ':completion:*:descriptions' format "- %d -"
zstyle ':completion:*:corrections' format "- %d - (errors %e})"
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)*==36=36}:${(s.:.)LS_COLORS}")';

zstyle ':filter-select:highlight' matched fg=red
zstyle ':filter-select' max-lines 1000
zstyle ':filter-select' rotate-list yes
zstyle ':filter-select' case-insensitive yes # enable case-insensitive search

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
