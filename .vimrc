set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'scrooloose/syntastic'
Bundle 'airblade/vim-gitgutter'
Bundle 'tpope/vim-vinegar'
Bundle 'scrooloose/nerdtree'
Bundle 'altercation/vim-colors-solarized'
Bundle 'tpope/vim-obsession'
Bundle 'junegunn/vim-easy-align'
Bundle 'guns/vim-clojure-static'
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'tpope/vim-fireplace'
Bundle 'fatih/vim-go'


set background=dark 
syntax on " syntax highlighting
"colorscheme solarized
set expandtab
set tabstop=2
set showmatch
"set number
set mouse=a
set backspace=indent,eol,start
set shortmess=atI
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,latin1,default
set isk+=_,$,@,%,#,-
set listchars=tab:▸\ ,eol:¬
filetype plugin indent on

"autocmd VimEnter * NERDTree
call pathogen#infect()


colorscheme molokai_dark
if has("gui_running")
   set transparency=5
   "colorscheme inkpot
   "colorscheme railscasts
   "set guifont=Monaco:h11
   set guifont=Menlo:h11
   set guioptions=egmrt
   set lines=40 columns=120
   set go-=T
   set go-=r
end

"set nocompatible " Disable vi-compatibility
set laststatus=2 " Always show the statusline
set t_Co=256 " Explicitly tell vim that the terminal has 256 colors

" ---------------------------------
" Text Formatting
" ---------------------------------

set binary
set autoindent
set smartindent
set smarttab
set nowrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set nosmarttab
set formatoptions+=n
set virtualedit=block
set cursorline
set list
set listchars=tab:>·,trail:·

set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "don't fold by default
set foldlevel=1

"omnifunc=syntaxcomplete#Complete 
au FileType cs set foldmethod=marker 
au FileType cs set foldmarker={,} 
au FileType cs set foldtext=substitute(getline(v:foldstart),'{.*','{...}',) 
au FileType cs set foldlevelstart=2 

" ---------------------------------
" Completion
" ---------------------------------

set completeopt=longest,menu
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*
set wildmenu
set complete=.,t
"set wildignore=*~


" ---------------------------------
" Buffers
" ---------------------------------

set hidden
set nobackup
set nowritebackup
set noswapfile
if has("undofile")
  set undofile
  set undodir=~/.undo
end

" ---------------------------------
" Plugins
" ---------------------------------

let g:syntastic_enable_signs = 1
let g:syntastic_disabled_filetypes = ['html']


" ---------------------------------
" Visual Cues
" ---------------------------------

set ignorecase
set hlsearch
set incsearch
set showmatch
set mat=5


" ---------------------------------
" Mappings
" ---------------------------------

let mapleader = ","

" feature toggles
" MapToggle <F1> hlsearch
" MapToggle <F2> wrap
" MapToggle <F3> number
" MapToggle <F4> paste

" new line creation with return
map <S-Enter> O<ESC>
map <Enter> o<ESC>
imap jj <Esc>

map <leader>a :Ack -i 

" indentation
vnoremap < <gv
vnoremap > >gv

nmap <leader>nt :NERDTree<CR>
nmap <leader>tb :TagbarToggle<CR>

" Fugitive
nmap <leader>gb :Gblame<CR>
nmap <leader>gs :Gstatus<CR>
nmap <leader>gd :Gdiff<CR>
nmap <leader>gl :Glog<CR>
nmap <leader>gc :Gcommit<CR>
nmap <leader>gp :Git push<CR>

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

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

" fuzzyfinder
map <leader>F :FufFile<CR>
map <leader>/ :FufFile **/<CR>
map <leader>f :FufFileWithCurrentBufferDir<CR>
map <leader>d :FufDir<CR>
map <leader>b :FufBuffer<CR>
map <leader>t :FufTaggedFile<CR>
map <leader>T :FufTag<CR>
nnoremap <leader><leader> <c-^>

" tag navigation
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
 
nnoremap Y y$

" open a url on the current line in browser
map ,w :call Browser()<CR>

map <C-U> :DockSend<CR>

" todo
map ,A o<ESC>:r!date +'\%A, \%B \%d, \%Y'<CR>:r!date +'\%A, \%B \%d, \%Y' \| sed 's/./-/g'<CR>A<CR><ESC>
map ,o o[ ] 
map ,O O[ ] 
map ,x :s/^\[ \]/[x]/<CR>
map ,X :s/^\[x\]/[ ]/<CR>

" Ex Mode is annoying. 
" Use this for formatting instead.
map Q gq

" Save even if we forgot to open the file with sudo
cmap w!! %!sudo tee > /dev/null %


" ---------------------------------
" Auto Commands
" ---------------------------------

" set filetype
autocmd BufRead *.css.php set filetype=css
autocmd BufRead *.less set filetype=css
autocmd BufRead *.js.php set filetype=javascript
autocmd BufRead *.jsx set filetype=javascript
autocmd BufRead *.mkd set filetype=mkd
autocmd BufRead *.markdown set filetype=mkd
autocmd BufRead *.god set filetype=ruby
autocmd BufRead *.as set filetype=actionscript
autocmd BufRead *.spark set filetype=html

" set completion
autocmd FileType ruby set omnifunc=rubycomplete#Complete
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd Filetype spark set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

autocmd Filetype gitcommit set tw=68 spell

autocmd Filetype javascript,php,sh,bash,zsh set ts=4 sts=4 sw=4 expandtab

" don't use cindent for javascript
autocmd FileType javascript setlocal nocindent

" keyword help files
autocmd FileType php set keywordprg=pman

autocmd FileType php set iskeyword-=-



" ---------------------------------
" Functions
" ---------------------------------

"{{{ Open URL in browser

function! Browser()
    let line0 = getline(".")
    let line = matchstr(line0, "http[^ )]*")
    let line = escape(line, "#?&;|%")
    exec ':silent !open ' . "\"" . line . "\""
endfunction

"}}}
