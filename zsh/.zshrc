export LC_CTYPE=en_US.UTF-8
# export TERM='alacritty'
#{{{ Base config, Plugins, modules, programs config
source $HOME/.zsh-plugins/vi-mode.zsh/vi-mode.plugin.zsh
source $HOME/.zsh-plugins/wbase.zsh/wbase.zsh

# Enable fish-shell like autosuggestion
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=247'
ZSH_AUTOSUGGEST_USE_ASYNC=1
source $HOME/.zsh-plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# fzf keybindings and completion
if check_prog fzf; then
    source $HOME/.zsh-plugins/fzf/completion.zsh
    source $HOME/.zsh-plugins/fzf/key-bindings.zsh
fi

# Prompt: git status, hostname for ssh sessions, vi mode indicator
source $HOME/.zsh-plugins/git-prompt.zsh/git-prompt.zsh
source $HOME/.zsh-plugins/git-prompt.zsh/examples/pure.zsh

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
bindkey '^H' backward-kill-word

# autosuggest plugin
bindkey '^ ' autosuggest-accept
bindkey '^f' autosuggest-accept

# edit-command-line module
bindkey -M vicmd 'V' edit-command-line
#}}}

cc() python3 -c "from math import *; print($*);"
alias calc='noglob cc'
#{{{ Aliases
alias ...='cd ../..'
alias g='git'
alias p='prime-run'
alias grep='grep --color=auto'
alias la='exa -lah --color=auto'
alias lh='exa -lh --color=auto'
alias ls='exa --color=auto'
alias l='exa --color=auto'
alias :q='exit'
alias ssh-public-key='cat ~/.ssh/id_rsa.pub'
alias vim='nvim'
alias whoneeds='pacman -Qi'
alias notes='nvim /data/workspace/notes/index.md'
alias rmorphans='sudo pacman -Rns $(pacman -Qdtq)'
#}}}

source $HOME/.config/broot/launcher/bash/br
export PATH=$HOME/.config/nvcode/utils/bin:$PATH
