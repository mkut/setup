# autocomplete
autoload -Uz compinit
compinit

# language
export LANG=ja_JP.UTF-8

# prompt
setopt prompt_subst

 # git
autoload -Uz vcs_info
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}"
zstyle ':vcs_info:git:*' formats " %F{green}%c%u[%b]"
zstyle ':vcs_info:git:*' actionformats '%F{red}[%b|%a]'
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )

case ${UID} in
0)
	PROMPT='%F{red}%39<..<%/%#vcs_info_msg_0_ %f'
	PROMPT2="%F{yellow}%39<..<%_%# %f"
	SPROMPT="%r is correct? [n,y,a,e]: " 
	[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && PROMPT="%F{cyan}${HOST%%.*} ${PROMPT}"
	;;
*)
	PROMPT='%F{green}%39<..<%/%#$vcs_info_msg_0_ %f'
	PROMPT2="%F{yellow}%39<..<%_%# %f"
	SPROMPT="%r is correct? [n,y,a,e]: " 
	[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && PROMPT="%F{cyan}${HOST%%.*} ${PROMPT}"
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
