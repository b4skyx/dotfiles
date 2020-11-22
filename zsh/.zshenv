autoload -U path
path=(~/.bin ~/.local/bin ~/.gem/ruby/2.5.0/bin $path[@])
fpath=(~/.zsh-plugins/zsh-completions/src $fpath)

export EDITOR='nvim'
export BROWSER='firefox'
export TERMCMD='alacritty'
export QT_QPA_PLATFORMTHEME='gtk2'
export FZF_CTRL_T_COMMAND='fd --type f --hidden --exclude .git --exclude .cache'
export FZF_ALT_C_COMMAND='fd --type d --hidden --exclude .git'
export FZF_DEFAULT_OPTS='--color=16,hl:4,hl+:4,bg+:15,fg+:8,spinner:5,info:2'
export QT_QPA_PLATFORMTHEME='qt5ct'
