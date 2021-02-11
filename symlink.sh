## Symlink my dotfiles

cwd="$PWD"


# Wm/Env
ln -sfn "$cwd"/.config/bspwm ~/.config/bspwm
ln -sfn "$cwd"/.config/polybar ~/.config/polybar
ln -sfn "$cwd"/.config/sxhkd ~/.config/sxhkd

# Vim/Nvim
ln -sfn "$cwd"/.config/nvim/init.vim ~/.config/nvim/init.vim
ln -snf ~/.config/nvim/init.vim ~/.vimrc
ln -sfn "$cwd"/.config/nvim/plugin ~/.config/nvim/plugin

ln -sfn "$cwd"/.config/conky ~/.config/conky
ln -sfn "$cwd"/.config/mpv ~/.config/mpv
ln -sfn "$cwd"/.config/mpd ~/.config/mpd
ln -sfn "$cwd"/.config/dunst ~/.config/dunst
ln -sfn "$cwd"/.config/gtk-3.0 ~/.config/gtk-3.0
ln -sfn "$cwd"/.ncmpcpp ~/.ncmpcpp

# Zsh
ln -sfn "$cwd"/zsh/.zsh-plugins ~/.zsh-plugins
ln -sfn "$cwd"/zsh/.zprofile ~/.zprofile
ln -sfn "$cwd"/zsh/.zshenv ~/.zshenv
ln -sfn "$cwd"/zsh/.zshrc ~/.zshrc

ln -sfn "$cwd"/.config/picom ~/.config/picom
ln -sfn "$cwd"/.config/rofi ~/.config/rofi
ln -sfn "$cwd"/.config/zathura ~/.config/zathura

ln -sfn "$cwd"/.config/redshift.conf ~/.config/redshift.conf
ln -sfn "$cwd"/.Xresources ~/.Xresources

