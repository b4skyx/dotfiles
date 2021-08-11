" Clipboard Remap
	vnoremap  <leader>y  "+y
	nnoremap  <leader>Y  "+yg_
	nnoremap  <leader>y  "+y
	nnoremap  <leader>yy  "+yy
	nnoremap <leader>p "+p
	nnoremap <leader>P "+P
	vnoremap <leader>p "+p
	vnoremap <leader>P "+P

" Split Navigation shortcuts
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l

"Buffer Navigation
	noremap <Tab> :bn<CR>
	noremap <S-Tab> :bp<CR>
	noremap <Leader><Tab> :Bw<CR>
	noremap <Leader><S-Tab> :Bw!<CR>
	noremap <C-t> :tabnew split<CR>


" Keep selection after shift
	vnoremap < <gv
	vnoremap > >gv

" Spell-check set to <leader>o, 'o' for 'orthography':
	map <leader>o :setlocal spell! spelllang=en_us<CR>

" Replace all is aliased to S.
	nnoremap S :%s//g<Left><Left>

" Vista
	nmap <leader>t :Vista!!<CR>

" Goyo
	noremap <leader>g :Goyo<CR>

" UndoTree
	nnoremap <F5> :UndotreeToggle<CR>

" Telescope remaps using lua functions
	nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
	nnoremap <leader>fp <cmd>lua require('telescope').extensions.media_files.media_files()<cr>
	nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
	nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
	nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
