typeset -U PATH path
path=(~/.local/bin $(find $HOME/.local/scripts/ -type d -printf "%p ") $path[@] )
fpath=(~/.zsh-plugins/zsh-completions/src $fpath)
export PATH

export EDITOR='/usr/bin/nvim'
export BROWSER='firefox'
export QT_QPA_PLATFORMTHEME='gtk2'
export FZF_TMUX=1
export FZF_CTRL_T_COMMAND='fd --type f --hidden --exclude .git --exclude .cache'
export FZF_CTRL_T_OPTS='--preview "bat --style=numbers --color=always --line-range :500 {}"'
export FZF_ALT_C_COMMAND='fd --type d --hidden --exclude .git'
export FZF_DEFAULT_OPTS='--layout=reverse'
export QT_QPA_PLATFORMTHEME='qt5ct'
export NPM_PACKAGES="${HOME}/.npm-packages"
export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
export MOZ_USE_XINPUT2=1

export VIMWIKI_PATH="/data/sync/Documents/vimwiki"
export VIMWIKI_COMPLETE_MARK="✓"
