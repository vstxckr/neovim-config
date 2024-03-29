"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set mouse=a 				" Enable mouse
set tabstop=4 				" 
set shiftwidth=4 			" 
set listchars=tab:\¦\ 		" Tab charactor 
set list
set foldmethod=syntax 		" 
set foldlevelstart=99 		"  
set number 					" Show line number
set ignorecase 				" Enable case-sensitive 

set textwidth=0 wrapmargin=0



" Disable backup
set nobackup
set nowb
set noswapfile
syntax on

" Enable copying from vim to clipboard
" Remember to disable Ctrl + v of Windows Terminal Preview
" Use Shift + Insert 

" Auto reload content changed outside
au CursorHold,CursorHoldI * checktime
au FocusGained,BufEnter * :checktime
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
		\ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == ''
			\ | checktime 
		\ | endif
autocmd FileChangedShellPost *
		\ echohl WarningMsg 
		\ | echo "File changed on disk. Buffer reloaded."
		\ | echohl None

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin list
" (used for Vim-plug - https://github.com/junegunn/vim-plug)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin(stdpath('config').'/plugged')
	Plug 'octol/vim-cpp-enhanced-highlight'
	Plug 'neoclide/coc.nvim' ", {'branch': 'release'}
"PHP
	Plug 'tobyS/pdv'                        " Auto generating php docblocks
	Plug 'stephpy/vim-php-cs-fixer'         " Coding standards fixer
	Plug 'StanAngeloff/php.vim'             " Improved syntax highlighting for phpo
	Plug 'phpactor/phpactor', {'do': 'composer install', 'for': 'php'} " PHP introspection and refactor tools
	Plug 'phpactor/ncm2-phpactor'           " Phpactor integration for ncm2 (autocomplete)
" Theme
	Plug 'joshdick/onedark.vim', 					" Dark theme
	Plug 'sainnhe/gruvbox-material'

" File browser
	Plug 'preservim/nerdTree' 						" File browser  
	Plug 'Xuyuanp/nerdtree-git-plugin' 				" Git status
	Plug 'ryanoasis/vim-devicons' 					" Icon
	Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
	Plug 'unkiwii/vim-nerdtree-sync' 				" Sync current file 

" File search
	Plug 'junegunn/fzf', 
		\ { 'do': { -> fzf#install() } } 			" Fuzzy finder 
	Plug 'junegunn/fzf.vim'

" Status bar
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'

" Terminal
	Plug 'voldikss/vim-floaterm' 					" Float terminal

" Code intellisense
	Plug 'neoclide/coc.nvim', {'branch': 'release'} " Language server 
	Plug 'jiangmiao/auto-pairs' 					" Parenthesis auto 
	Plug 'alvan/vim-closetag'
	Plug 'mattn/emmet-vim' 
	Plug 'preservim/nerdcommenter' 					" Comment code 
	Plug 'liuchengxu/vista.vim' 					" Function tag bar 
	Plug 'alvan/vim-closetag' 						" Auto close HTML/XML tag 

" Code syntax highlight
	Plug 'yuezk/vim-js' 							" Javascript
	Plug 'MaxMEllon/vim-jsx-pretty' 				" JSX/React
	Plug 'jackguo380/vim-lsp-cxx-highlight'			" C++ syntax
	Plug 'uiiaoo/java-syntax.vim' 					" Java
  
" Debugging
	Plug 'mfussenegger/nvim-dap'
	Plug 'rcarriga/nvim-dap-ui'

" Source code version control 
	Plug 'tpope/vim-fugitive' 						" Git
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =>                     Key mappings                                     
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Resize pane
nnoremap <M-a> :vertical resize +1<CR> 		
nnoremap <M-f> :vertical resize -1<CR>
nnoremap <M-s> :resize +1<CR>
nnoremap <M-d> :resize -1<CR>

" Search a hightlighted text
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

"set font
set guifont=FiraCode\ NF:h9

set splitright

" config to compile and linking nasm file
autocmd filetype asm nnoremap <leader>asm :w <CR>:!nasm -f elf32 % -o %<.o && ld -m elf_i386 %<.o -o %< <CR>:vsp <bar> te ./%< <CR>
autocmd filetype asm nnoremap <leader>gm  :set ft=nasm <CR>

autocmd filetype cpp nnoremap <leader>cpf :vsplit <bar> te g++ -std=c++11 % -o %< && ./%< < inp.txt <CR>

autocmd filetype cpp nnoremap <leader>cpp :vsplit <bar> te g++ -std=c++11 % -o %< && ./%< <CR>

autocmd filetype c nnoremap <leader>cnn :vsplit <bar> te gcc % -o %< && ./%< <CR>

autocmd filetype c nnoremap <leader>cnf :vsplit <bar> te gcc % -o %< && ./%< < inp.txt <CR>

" Disable highlight unused code of cocnvim
nnoremap <leader>dc :highlight CocUnusedHighlight ctermbg=NONE guibg=NONE<CR>

nnoremap <leader>cus :vsplit <bar> te gcc % -no-pie -o  %< && ./%< <CR>
nnoremap <leader>3py :vsplit <bar> te python3 % <CR>
nnoremap <leader>3ph :vsplit <bar> te php % <CR>


" config some control key
nnoremap <S-h> :bprevious<CR>
nnoremap <S-l> :bnext<CR>

nnoremap <C-h> <C-W>h 
nnoremap <C-j> <C-W>j 
nnoremap <C-k> <C-W>k 
nnoremap <C-l> <C-W>l 

nnoremap <leader>vw :buffers <CR>:vsplit<space>
nnoremap <leader>hw :buffers <CR>:split<space>
nnoremap <leader>cs :close <CR>
nnoremap <leader>cr :cd %:p:h <CR>

nnoremap <leader>nt :buffers<CR>:tabnew<space>
nnoremap <leader>nb :!ls<CR>:e<space>
nnoremap <leader>bd :bd<CR>
nnoremap <leader>bf :bd!<CR>
nnoremap <C-o> :tabNext<CR>
nnoremap <C-i> :tabprevious<CR>

" change to default cwd when open nvim
command Cwdsu nnoremap <leader>cdh :cd ~/Code/C<CR>
autocmd Vimenter * Cwdsu
" Arrowkeys mapping
nnoremap 1 <Left>

" cpy (write) highlighted text to .vimbuffer
" vmap <C-c> y:new ~/.vimbuffer<CR>VGp:x<CR> \| :!cat ~/.vimbuffer \| clip.exe <CR><CR>

"new copy
vmap <C-c> "+y

let g:clipboard = {
                        \   'name': 'win32yank-wsl',
                        \   'copy': {
                        \      '+': 'win32yank.exe -i --crlf',
                        \      '*': 'win32yank.exe -i --crlf',
                        \    },
                        \   'paste': {
                        \      '+': 'win32yank.exe -o --lf',
                        \      '*': 'win32yank.exe -o --lf',
                        \   },
                        \   'cache_enabled': 0,
                        \ }


" general config
set relativenumber
set fillchars=fold:\ ,vert:\│,eob:\ ,msgsep:‾

" WSL yank support
"let s:clip = '/mnt/c/Windows/System32/clip.exe'
"if executable(s:clip)
"    augroup WSLYank
"        autocmd!
"        autocmd TextYankPost * call system(s:clip, join(v:event.regcontents,"\<CR>"))
"    augroup END
"end

" Mapping keys for cocnvim

inoremap <silent><expr> <C-n> coc#pum#visible() ? coc#pum#next(1) : "\<C-n>"              
inoremap <silent><expr> <C-p> coc#pum#visible() ? coc#pum#prev(1) : "\<C-p>"              
inoremap <silent><expr> <down> coc#pum#visible() ? coc#pum#next(0) : "\<down>"            
inoremap <silent><expr> <up> coc#pum#visible() ? coc#pum#prev(0) : "\<up>"                


inoremap <silent><expr> <PageDown> coc#pum#visible() ? coc#pum#scroll(1) : "\<PageDown>"  
inoremap <silent><expr> <PageUp> coc#pum#visible() ? coc#pum#scroll(0) : "\<PageUp>"      

inoremap <silent><expr> <C-e> coc#pum#visible() ? coc#pum#cancel() : "\<C-e>"   

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin Setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" (*) THEMES

" For dark version.
" 	set background=dark
" For light version.
" 	set background=light
" Set contrast.
" This configuration option should be placed before `colorscheme gruvbox-material`.
" Available values: 'hard', 'medium'(default), 'soft'
" 	let g:gruvbox_material_background = 'soft'
" For better performance
" 	let g:gruvbox_material_better_performance = 1
" 	colorscheme gruvbox-material

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set theme 
" 	One Dark
 		colorscheme onedark
" 	Gruv-Box
		" colorscheme gruvbox-material
		" set background=dark
" Fix wrong colorscheme
set termguicolors
"set term=screen-256color

" overwrite some color highlight 
if (has("autocmd"))
    augroup colorextend
        autocmd ColorScheme
            \ * call onedark#extend_highlight("Comment",{"fg": {"gui": "#728083"}})
        autocmd ColorScheme
            \ * call onedark#extend_highlight("LineNr", {"fg": {"gui": "#728083"}})
    augroup END
endif

" Disable automatic comment in newline
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Other setting
for setting_file in split(glob(stdpath('config').'/settings/*.vim'))
	execute 'source' setting_file
endfor


" Save fold 
augroup remember_folds
  autocmd!
  autocmd BufWinLeave * mkview
  autocmd BufWinEnter * silent! loadview
augroup END

" enable tabline
let g:airline#extensions#tabline#enabled = 1
