# autocomplete
autoload -U compinit
compinit

# language
export LANG=ja_JP.UTF-8

# prompt
local RED=$'%{\e[1;31m%}'
local GREEN=$'%{\e[1;32m%}'
local YELLOW=$'%{\e[1;33m%}'
local BLUE=$'%{\e[1;34m%}'
local LBLUE=$'%{\e[1;36m%}'
local DEFAULT=$'%{\e[1;m%}'
case ${UID} in
0)
	PROMPT="${RED}%39<..<%/%# ${DEFAULT}"
	PROMPT2="${RED}%39<..<%_%# "${DEFAULT}
	SPROMPT="%r is correct? [n,y,a,e]: " 
	[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && PROMPT="${LBLUE}${HOST%%.*} ${PROMPT}"
	;;
*)
	PROMPT="${GREEN}%39<..<%/%# ${DEFAULT}"
	PROMPT2="${GREEN}%39<..<%_%# "${DEFAULT}
	SPROMPT="%r is correct? [n,y,a,e]: " 
	[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && PROMPT="${LBLUE}${HOST%%.*} ${PROMPT}"
	;;
esac

# vi keybind
bindkey -v

# history
autoload history-search-end
HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000000
SAVEHIST=100000000
setopt hist_ignore_dups
setopt share_history
setopt hist_ignore_space
zle -N history-beginning-search-backward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^N" history-beginning-search-forward-end

# cd
setopt auto_cd
setopt auto_pushd
export D1='..'
export D2='../..'
export D3='../../..'
export D4='../../../..'
export D5='../../../../..'
export D6='../../../../../..'
export D7='../../../../../../..'
export D8='../../../../../../../..'
export D9='../../../../../../../../..'
alias ...='cd $D2'
alias ....='cd $D3'
alias .....='cd $D4'
alias ......='cd $D5'
alias .......='cd $D6'
alias ........='cd $D7'
alias .........='cd $D8'
alias ..........='cd $D9'

# ls
autoload colors
colors
export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'
zstyle ':completion:*default' list-colors ${(s.:.)LS_COLORS}

# grep
alias grep='grep --color=auto'

# emacs
alias emacs='emacs -nw'

# tmux
alias tmux='tmux -2'

# local settings
source ${HOME}/.zshrc.d/local.zsh
