cwd="$PWD"


# Vim/Nvim
ln -sfn "$cwd"/.config/nvim/init.vim ~/.config/nvim/init.vim
ln -snf ~/.config/nvim/init.vim ~/.vimrc

# ln -sfn "$cwd"/.config/alacritty ~/.config/alacritty
ln -sfn "$cwd"/.config/kitty ~/.config/kitty


ln -sfn "$cwd"/.fonts ~/.fonts
ln -sfn "$cwd"/.config/conky ~/.config/conky
ln -sfn "$cwd"/.config/mpv ~/.config/mpv
ln -sfn "$cwd"/.config/ranger ~/.config/ranger

# Zsh
ln -sfn "$cwd"/zsh/.zsh-plugins ~/.zsh-plugins
ln -sfn "$cwd"/zsh/.zprofile ~/.zprofile
ln -sfn "$cwd"/zsh/.zshenv ~/.zsenv
ln -sfn "$cwd"/zsh/.zshrc ~/.zshrc

ln -sfn "$cwd"/.config/picom ~/.config/picom
ln -sfn "$cwd"/.config/rofi ~/.config/rofi

ln -sfn "$cwd"/redshift.conf ~/.config/redshift.conf
