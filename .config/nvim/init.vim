" ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗
" ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║
" ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║
" ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║
" ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║
" ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝

" https://github.com/b4skyx/dotfiles

let mapleader =","
let maplocalleader = "\\"


" Vim-Plug init
if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ~/.config/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
endif

" Vim-Plug Plugins

call plug#begin('~/.config/nvim/plugged')
Plug 'b4skyx/serenade'
Plug 'ryanoasis/vim-devicons'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-refactor'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-media-files.nvim'

Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'scrooloose/nerdtree'
Plug 'liuchengxu/vista.vim'
Plug 'mbbill/undotree'

Plug 'godlygeek/tabular'
Plug 'rbgrouleff/bclose.vim'
Plug 'b3nj5m1n/kommentary'
Plug 'junegunn/goyo.vim'

Plug 'TimUntersberger/neogit'
Plug 'lewis6991/gitsigns.nvim'
Plug 'vimwiki/vimwiki'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'honza/vim-snippets'
Plug 'pechorin/any-jump.vim'
Plug 'sheerun/vim-polyglot'
Plug 'norcalli/nvim-colorizer.lua'
call plug#end()

augroup RELOAD
	autocmd!
	" Close vim when Nerdtree is last window
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

	" Disables automatic commenting on newline:
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

	" Automatically deletes all trailing whitespace on save.
	autocmd BufWritePre * %s/\s\+$//e

augroup END

" Sudo on files that require root permission
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

lua << EOF
require('telescope').load_extension('media_files')
local neogit = require('neogit')
neogit.setup {}
require('gitsigns').setup()
require('kommentary.config').use_extended_mappings()
EOF
