typeset -U PATH path
path=(~/.bin ~/.local/bin ~/.local/scripts ~/.local/scripts/bspwm $path[@] )
fpath=(~/.zsh-plugins/zsh-completions/src $fpath)
export PATH

export EDITOR='/usr/bin/nvim'
export BROWSER='firefox'
export TERM='st'
export QT_QPA_PLATFORMTHEME='gtk2'
export FZF_CTRL_T_COMMAND='fd --type f --hidden --exclude .git --exclude .cache'
export FZF_ALT_C_COMMAND='fd --type d --hidden --exclude .git'
export FZF_DEFAULT_OPTS='--color=16,hl:4,hl+:4,bg+:15,fg+:8,spinner:5,info:2'
export QT_QPA_PLATFORMTHEME='qt5ct'
export NPM_PACKAGES="${HOME}/.npm-packages"
export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
