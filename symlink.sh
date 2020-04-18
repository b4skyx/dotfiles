cwd="$PWD"


# Vim/Nvim
ln -sfn "$cwd"/nvim/init.vim ~/.config/nvim/init.vim
ln -snf ~/.config/nvim/init.vim ~/.vimrc

ln -sfn "$cwd"/alacritty ~/.config/alacritty
ln -sfn "$cwd"/.fonts ~/.fonts
ln -sfn "$cwd"/conky ~/.config/conky
ln -sfn "$cwd"/mpv ~/.config/mpv
ln -sfn "$cwd"/ranger ~/.config/ranger

# Zsh
ln -sfn "$cwd"/zsh/.zsh-plugins ~/.zsh-plugins
ln -sfn "$cwd"/zsh/.zdirs ~/.zdirs
ln -sfn "$cwd"/zsh/.zprofile ~/.zprofile
ln -sfn "$cwd"/zsh/.zshenv ~/.zsenv
ln -sfn "$cwd"/zsh/.zshrc ~/.zshrc

ln -sfn "$cwd"/redshift.conf ~/.config/redshift.conf
