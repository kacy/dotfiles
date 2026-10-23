" Plugin-free vim setup that works on any machine with vim 8 or newer.

set nocompatible
filetype plugin indent on
syntax on

set background=dark
if has('termguicolors')
  set termguicolors
endif
silent! colorscheme habamax

" ---------------------------------
" General
" ---------------------------------

set encoding=utf-8
set fileencodings=ucs-bom,utf-8,latin1,default
set backspace=indent,eol,start
set mouse=a
set shortmess=atI
set laststatus=2
set hidden
set cursorline
set nowrap
set virtualedit=block
set formatoptions+=n
set isk+=_,$,@,%,#,-
set list
set listchars=tab:>·,trail:·

" ---------------------------------
" Indentation
" ---------------------------------

set autoindent
set smartindent
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2

set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=1

" ---------------------------------
" Search and completion
" ---------------------------------

set ignorecase
set smartcase
set hlsearch
set incsearch
set showmatch
set matchtime=5

set completeopt=longest,menu
set wildmenu
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.class

" ---------------------------------
" Files
" ---------------------------------

set nobackup
set nowritebackup
set noswapfile
if has('persistent_undo')
  let s:undodir = expand('~/.vim/undo')
  if !isdirectory(s:undodir)
    call mkdir(s:undodir, 'p')
  endif
  let &undodir = s:undodir
  set undofile
endif

" ---------------------------------
" Mappings
" ---------------------------------

let mapleader = ","

map <S-Enter> O<Esc>
map <Enter> o<Esc>
imap jj <Esc>
nnoremap Y y$
nnoremap <leader><leader> <C-^>

" keep the selection when indenting
vnoremap < <gv
vnoremap > >gv

" window splitting
nmap <leader>swh :topleft vnew<CR>
nmap <leader>swl :botright vnew<CR>
nmap <leader>swk :topleft new<CR>
nmap <leader>swj :botright new<CR>
nmap <leader>sh :leftabove vnew<CR>
nmap <leader>sl :rightbelow vnew<CR>
nmap <leader>sk :leftabove new<CR>
nmap <leader>sj :rightbelow new<CR>

" window movement
map <C-h> <C-w>h
map <C-l> <C-w>l
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-q> <C-w>q

" tag navigation
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" open the URL on the current line in a browser
map <leader>w :call OpenURL()<CR>

" todo lists
map <leader>A o<Esc>:r!date +'\%A, \%B \%d, \%Y'<CR>:r!date +'\%A, \%B \%d, \%Y' \| sed 's/./-/g'<CR>A<CR><Esc>
map <leader>o o[ ]
map <leader>O O[ ]
map <leader>x :s/^\[ \]/[x]/<CR>
map <leader>X :s/^\[x\]/[ ]/<CR>

" use Q for formatting instead of Ex mode
map Q gq

" save even if the file was opened without sudo
cmap w!! %!sudo tee > /dev/null %

" ---------------------------------
" File types
" ---------------------------------

autocmd FileType gitcommit setlocal textwidth=68 spell
autocmd FileType javascript,php,sh,bash,zsh setlocal tabstop=4 softtabstop=4 shiftwidth=4
autocmd FileType go setlocal noexpandtab tabstop=4 shiftwidth=4

" ---------------------------------
" Functions
" ---------------------------------

function! OpenURL()
  let url = matchstr(getline('.'), 'https\?://[^ )>"]*')
  if empty(url)
    echo 'No URL on this line'
    return
  endif
  let opener = has('mac') ? 'open' : 'xdg-open'
  call system(opener . ' ' . shellescape(url) . ' &')
endfunction
