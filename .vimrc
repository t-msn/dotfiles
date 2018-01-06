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
let s:toml = expand('~/.config/vim/dein.toml')
let s:toml_lazy = expand('~/.config/vim/dein_lazy.toml')
let s:toml_misc = expand('~/.config/vim/dein_misc.toml')
set runtimepath+=~/.cache/repos/github.com/Shougo/dein.vim

if dein#load_state(s:dein_base)
	call dein#begin(s:dein_base)
	call dein#load_toml(s:toml, {'lazy': 0})
	call dein#load_toml(s:toml_lazy, {'lazy': 1})
	"call dein#load_toml(s:toml_misc, {'lazy': 0})
	
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
set textwidth=75
                    
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

set guioptions-=R
set guioptions-=L
set guioptions-=T

" enable backspace
set backspace=indent,eol,start

" list
set lcs=tab:>.,eol:$,trail:_,extends:\

" yank
set clipboard=unnamedplus,unnamed

if exists('+macmeta')
	set macmeta
endif

" status line (now using lightline instead of this)
" set statusline=%<%F\ %m\ %r%h%w%{'['.(&fenc!=''?&fenc:&enc).(&bomb?':BOM':'').']['.&ff.']'}%=\ %v,%l\ %L\%8P\ 

""""" key remap
nnoremap ,<space> :e ~/.vimrc<CR> 
nnoremap ,s :source ~/.vimrc<CR>

nnoremap : ;
nnoremap ; :

vnoremap ; :
vnoremap : ;

nnoremap <Space>m :messages<CR>
nnoremap <Space>c :changes<CR>
nnoremap <Space>ln :nmap<CR>
nnoremap <Space>lv :vmap<CR>
nnoremap <Space>d :DiffOrig<CR>

nnoremap j gj
nnoremap k gk
nnoremap <Space> <C-D>
nnoremap <S-Space> <C-U>

" tags
" nnoremap tw <C-]>
" nnoremap tt <C-w>]
nnoremap tw :tjump <C-R><C-W><CR>
nnoremap tt :stjump <C-R><C-W><CR>
nnoremap tn :tag<CR>
nnoremap tp :pop<CR>
nnoremap tl :tags<CR>
" nnoremap ts :tjump <C-R><C-W><CR>
set tags+=tags;

nnoremap <F3> <C-W><C-W>
nnoremap <F2> <C-W><C-P>
nnoremap _ <C-W>
nnoremap <D-_> <C-W>-
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
" nmap sj <C-W>j<C-w>_
" nmap sk <C-W>k<C-w>_
" nmap sh <C-w>h<C-w>_
" nmap sl <C-w>l<C-w>_
" nnoremap ,, <C-W>>
" nnoremap .. <C-W><
" nnoremap , <NOP>
" nnoremap . <NOP>
nnoremap ,o :only<CR>
                    
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

" tab
nnoremap <C-t>n :tabnew<CR>
nnoremap sn :tabnext<CR><C-t>
nnoremap sp :tabprevious<CR><C-t>

" buffer
nnoremap bn :bNext<CR>
nnoremap bp :bprevious<CR>
"nnoremap ,b :Buffer<Space>

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
" automatically change carrent directory
au BufEnter * execute ":lcd " . expand("%:p:h")

augroup vimrcEx
	autocmd!
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line('$') |
    \   exe "normal! g`\"" |
    \ endif
augroup END

" syntastic
let g:syntastic_mode_map = {
      \  'mode': 'passive',
      \ 'active_filetypes': [],
      \ 'passive_filetypes': []
      \ }
nnoremap ]a :lnext!<CR>
nnoremap ]q :lprev!<CR>
nnoremap ]e :Errors<CR><C-W><C-W>
nnoremap ]t :SyntasticToggleMode<CR>
nnoremap ]g :SyntasticCheck<CR>
" auto jump to first error
"let g:syntastic_auto_jump=1
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open=1
let g:syntastic_stl_format = '[%E{Err: %fe #%e}%B{, }%W{Warn: %fw #%w}]'

""""" encoding settings for Japanese
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconvがeucJP-msに対応しているかをチェック
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  " iconvがJISX0213に対応しているかをチェック
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " fileencodingsを構築
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = &fileencodings .','. s:fileencodings_default
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
			set fileencodings+=cp932
			set fileencodings-=euc-jp
			set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  " 定数を処分
  unlet s:enc_euc
  unlet s:enc_jis
endif
" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
 function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif
" 改行コードの自動認識
set fileformats=unix,dos,mac
" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif

""""" language settings
"" python
if has("python")
	python from vim import current as c
endif

" use ';' for inserting new line
autocmd Filetype py,rb inoremap <buffer> ; <CR>
autocmd Filetype py,rb inoremap <buffer> <D-_> ;

"" go
set rtp+=$GOROOT/misc/vim
exe "set rtp+=".globpath($GOPATH, "src/github.com/nsf/gocode/vim")
set completeopt=menu,preview

"" markdown
autocmd BufRead,BufNewFile *.mkd  setfiletype mkd
autocmd BufRead,BufNewFile *.md  setfiletype mkd

"" scheme
" autocmd FileType scheme inoremap 7 '
" autocmd FileType scheme inoremap 8 (
" autocmd FileType scheme inoremap 9 )
" autocmd FileType scheme inoremap ) 9
" autocmd FileType scheme inoremap ( 8
" autocmd FileType scheme inoremap ' 7

"" javascript
let $JS_CMD='node'
