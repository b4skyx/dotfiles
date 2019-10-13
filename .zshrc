#{{{ Base config, Plugins, modules, programs config
source $HOME/.zsh-plugins/vi-mode.zsh/vi-mode.plugin.zsh
source $HOME/.zsh-plugins/wbase.zsh/wbase.zsh

# Virtualenv Wrapper
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/workspace
check_prog "virtualenvwrapper_lazy.sh" && maybe_source "$(which virtualenvwrapper_lazy.sh)"

# Enable fish-shell like autosuggestion
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=247'
ZSH_AUTOSUGGEST_USE_ASYNC=1
source $HOME/.zsh-plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# command not found on Arch Linux
maybe_source /usr/share/doc/pkgfile/command-not-found.zsh

# fzf keybindings and completion
if check_prog fzf; then
    source $HOME/.zsh-plugins/fzf/completion.zsh
    source $HOME/.zsh-plugins/fzf/key-bindings.zsh
fi

# Prompt: git status, hostname for ssh sessions, vi mode indicator
source $HOME/.zsh-plugins/git-prompt.zsh/git-prompt.zsh
source $HOME/.zsh-plugins/git-prompt.zsh/examples/default.zsh

# Enable syntax highlighting. Must be loaded after all `zle -N` calls (see
# https://github.com/zsh-users/zsh-syntax-highlighting#faq)
source $HOME/.zsh-plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh

# Enable fish-shell like history searching. Must be loaded after zsh-syntax-highlighting.
source $HOME/.zsh-plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
#}}}


#{{{ Keybindings
# substring search plugin
bindkey -M main '^[OA' history-substring-search-up
bindkey -M main '^[OB' history-substring-search-down
bindkey -M main '^[[A' history-substring-search-up
bindkey -M main '^[[B' history-substring-search-down
bindkey -M vicmd '^k' history-substring-search-up
bindkey -M vicmd '^j' history-substring-search-down
bindkey '^k' history-substring-search-up
bindkey '^j' history-substring-search-down

# autosuggest plugin
bindkey '^ ' autosuggest-accept
bindkey '^f' autosuggest-accept

# edit-command-line module
bindkey -M vicmd 'V' edit-command-line
#}}}

#{{{ Aliases
alias ...='cd ../..'
alias cpstat='rsync -haP'
alias datea='date +%F'
alias g='git'
alias d='sudo docker'
alias grep='grep --color=auto'
alias ip='ip -c'
alias la='ls -lah --color=auto'
alias lh='ls -lh --color=auto'
alias ls='ls --color=auto'
alias l='ls --color=auto'
alias pacu='pikaur -Syu'
alias :q='exit'
alias del='trash'
alias ssh-public-key='cat ~/.ssh/id_rsa.pub'
alias vim='nvim'
alias whoneeds='pacman -Qi'
alias T="$TERMCMD 2>&1 > /dev/null &!"
alias o="rifle"
alias mdstat='cat /proc/mdstat'
#}}}

# vim:foldmethod=marker
