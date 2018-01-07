""""" load plugin using dein.vim
if &compatible
  set nocompatible
endif

" fetch dein if not exists
if !isdirectory(expand('~/.cache/repos/github.com/Shougo/dein.vim'))
  let s:dein_repo_dir = '~/.cache/repos/github.com/Shougo/dein.vim'
	execute '!mkdir -p ' . s:dein_repo_dir
	execute '!git clone https://github.com/Shougo/dein.vim ' . s:dein_repo_dir
endif

let s:dein_base = expand('~/.cache')
let s:toml = expand('~/.config/nvim/dein_nvim.toml')
let s:toml_lazy = expand('~/.config/nvim/dein_nvim_lazy.toml')
set runtimepath+=~/.cache/repos/github.com/Shougo/dein.vim

if dein#load_state(s:dein_base)
	call dein#begin(s:dein_base)
	call dein#load_toml(s:toml, {'lazy': 0})
	call dein#load_toml(s:toml_lazy, {'lazy': 1})
	
	call dein#end()
	call dein#save_state()
endif

filetype plugin indent on
syntax enable

if dein#check_install()
	call dein#install()
endif

""""" color settings
colorscheme molokai
let g:molokai_original = 1
let g:rehash256 = 1
" set background=dark

let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"
   
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=reverse ctermfg=15 gui=reverse guibg=#FFFFFF
endfunction

if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme       * call ZenkakuSpace()
        autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
    augroup END
    call ZenkakuSpace()
endif

if has('multi_byte_ime') || has('xim')
	highlight CursorIM guibg=Purple guifg=NONE
endif

""""" set options 
set number        
set ruler  
set showcmd
set autowrite
set autoindent      
set smartindent     
set vb t_vb=

set tabstop=2
set softtabstop=2   
set shiftwidth=2    
set noexpandtab     
set textwidth=0     
set cmdheight=1
                    
syntax on
set hlsearch
set hidden
set wrap            
set wrapscan        
set incsearch       
set showmatch 
set ignorecase      
set smartcase       
set wildignorecase
set wildmode=list:full
set wildmenu

" enable backspace
set backspace=indent,eol,start

" list
set lcs=tab:>.,eol:$,trail:_,extends:\

" yank
set clipboard=unnamedplus,unnamed

""""" key remap
nnoremap ,<space> :e ~/.config/nvim/init.vim<CR> 
nnoremap ,s :source ~/.config/nvim/init.vim<CR>

nnoremap : ;
nnoremap ; :

vnoremap ; :
vnoremap : ;

nnoremap <Space>m :messages<CR>
nnoremap <Space>c :changes<CR>
nnoremap <Space>ln :nmap<CR>
nnoremap <Space>lv :vmap<CR>

nnoremap j gj
nnoremap k gk
nnoremap <Space> <C-D>
nnoremap <S-Space> <C-U>

nnoremap <F3> <C-W><C-W>
nnoremap <F2> <C-W><C-P>
nnoremap _ <C-W>
nnoremap <D-_> <C-W>-
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

map g<Space> Gzz
nnoremap g_ g_a
nnoremap g0 g0i
nnoremap + +$a
nnoremap - -$a

nnoremap gn g;zz
nnoremap gm g,zz
nnoremap gb '.zz

set virtualedit=block
vnoremap < <gv
vnoremap > >gv

" buffer
nnoremap bn :bNext<CR>
nnoremap bp :bprevious<CR>
"nnoremap ,b :Buffer<Space>

" tab
nnoremap tn :tabNext<CR>
nnoremap tp :tabpevious<CR>

" help
nnoremap <C-u> :help<Space>

" reopen
nnoremap E :e!<CR>
" add Rename command
command! -nargs=1 -complete=file Rename f <args>|call delete(expand('#'))
" overwrite with sudo
cnoremap w!! w !sudo tee %

nnoremap w :write<CR>
nnoremap qq :quit<CR>
nnoremap <ESC><ESC> :nohlsearch<CR>

set cmdwinheight=15
nnoremap q; q:
autocmd CmdwinEnter * nnoremap <silent> <buffer> <C-C> <C-C><C-E>
autocmd CmdwinEnter * nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
autocmd CmdwinEnter * inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

" visual mode settings
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v,'\/'),"\n",'\\n','g')<CR><CR>
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`['

" commandline mode settings
cnoremap <C-L> <Del>
cnoremap <C-A> <HOME>
cnoremap <C-E> <End>
cnoremap <C-B> <Left>
cnoremap <C-F> <Right>

""""" other settings
" automatically change current directory
autocm BufEnter * if expand('%:p') !~ '://' | :lchdir %:p:h | endif

" remember last edit position
augroup vimrcEx
	autocmd!
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line('$') |
    \   exe "normal! g`\"" |
    \ endif
augroup END
