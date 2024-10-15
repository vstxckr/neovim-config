set mouse=a            " Enable mouse
set tabstop=4          
set shiftwidth=4       
set listchars=tab:\¦\  " Tab charactor
set list
set foldmethod=syntax  
set foldlevelstart=99 
set number             " Show line number
set ignorecase         " Enable case-sensitive
set textwidth=0 wrapmargin=0
set nobackup
set nowb
set noswapfile
syntax on
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
call plug#begin(stdpath('config').'/plugged')
" one dark
        Plug 'joshdick/onedark.vim',                                    " Dark theme
" python
        Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins' }
" File browser
        Plug 'preservim/nerdTree'                                               " File browser
        Plug 'Xuyuanp/nerdtree-git-plugin'                              " Git status
        Plug 'ryanoasis/vim-devicons'                                   " Icon
        Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
        Plug 'unkiwii/vim-nerdtree-sync'                                " Sync current file
" File search
        Plug 'junegunn/fzf',
                \ { 'do': { -> fzf#install() } }                        " Fuzzy finder
        Plug 'junegunn/fzf.vim'
" Status bar
        Plug 'vim-airline/vim-airline'
        Plug 'vim-airline/vim-airline-themes'
" Code intellisense
        Plug 'jiangmiao/auto-pairs'                                     " Parenthesis auto
        Plug 'alvan/vim-closetag'
        Plug 'liuchengxu/vista.vim'                                     " Function tag bar
" Source code version control
        Plug 'tpope/vim-fugitive'                                               " Git
call plug#end()
nnoremap <M-a> :vertical resize +1<CR>
nnoremap <M-f> :vertical resize -1<CR>
nnoremap <M-s> :resize +1<CR>
nnoremap <M-d> :resize -1<CR>
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>
set splitright
" config to compile and linking nasm file
autocmd filetype asm nnoremap <leader>asm :w <CR>:!nasm -f elf32 % -o %<.o && ld -m elf_i386 %<.o -o %< <CR>:vsp <bar> te ./%< <CR>
autocmd filetype asm nnoremap <leader>gm  :set ft=nasm <CR>
autocmd filetype cpp nnoremap <leader>cpf :vsplit <bar> te g++ -std=c++11 % -o %< && ./%< < inp.txt <CR>
autocmd filetype cpp nnoremap <leader>cpp :vsplit <bar> te g++ -std=c++11 % -o %< && ./%< <CR>
autocmd filetype c nnoremap <leader>cnn :vsplit <bar> te gcc % -o %< && ./%< <CR>
autocmd filetype c nnoremap <leader>cnf :vsplit <bar> te gcc % -o %< && ./%< < inp.txt <CR>
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
" copy
vmap <C-c> "+y
" general config
set relativenumber
set fillchars=fold:\ ,vert:\│,eob:\ ,msgsep:‾
" Fix wrong colorscheme
colorscheme onedark
set termguicolors
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
" enable tabline
let g:airline#extensions#tabline#enabled = 1
function MyCustomHighlights()
        autocmd FileType python call MyCustomHighlights()
        hi semshiLocal           ctermfg=209 guifg=#ff875f
        hi semshiGlobal          ctermfg=214 guifg=#ffaf00
        hi semshiImported        ctermfg=214 guifg=#ffaf00 cterm=bold gui=bold
        hi semshiParameter       ctermfg=75  guifg=#5fafff
        hi semshiParameterUnused ctermfg=117 guifg=#87d7ff cterm=underline gui=underline
        hi semshiFree            ctermfg=218 guifg=#ffafd7
        hi semshiBuiltin         ctermfg=207 guifg=#ff5fff
        hi semshiAttribute       ctermfg=49  guifg=#00ffaf
        hi semshiSelf            ctermfg=249 guifg=#b2b2b2
        hi semshiUnresolved      ctermfg=226 guifg=#ffff00 cterm=underline gui=underline
        hi semshiSelected        ctermfg=231 guifg=#ffffff ctermbg=161 guibg=#d7005f

        hi semshiErrorSign       ctermfg=231 guifg=#ffffff ctermbg=160 guibg=#d70000
        hi semshiErrorChar       ctermfg=231 guifg=#ffffff ctermbg=160 guibg=#d70000
        sign define semshiError text=E> texthl=semshiErrorSign
endfunction
autocmd FileType python call MyCustomHighlights()
nnoremap <leader>f :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>r :Rg<CR>
nnoremap <leader>t :NERDTreeToggle<CR>
