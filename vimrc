set nocompatible             " be iMproved, required
filetype off                 " required

syntax on

set t_Co=256
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set encoding=utf8
set incsearch
set ignorecase
set backspace=start,indent,eol
set noswapfile
set wildignore+=*/.git/*,*/vendor/*,*/node_modules/*,*/assets/*
set listchars=tab:>-,trail:.,extends:>,precedes:<
set list
set ruler

let mapleader = ","

"---------------------------------------------
"  Load plugins
"---------------------------------------------

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Bundle 'sjl/badwolf.git'
Bundle 'kien/ctrlp.vim.git'
Bundle 'scrooloose/nerdtree.git'
Bundle 'Align'
Bundle 'terryma/vim-multiple-cursors.git'
Bundle 'airblade/vim-rooter.git'
Bundle 'tomtom/tcomment_vim.git'
Bundle 'airblade/vim-gitgutter.git'
Bundle 'Shougo/neocomplete.vim.git'
Bundle 'tpope/vim-fugitive.git'
Bundle 'kwbdi.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"---------------------------------------------
"  Plugin settings
"---------------------------------------------

silent! colorscheme badwolf

let g:ctrlp_match_window = 'top,order:ttb,min:1,max:20'
let g:ctrlp_map = '<c-f>'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ }

let g:neocomplete#enable_at_startup = 1

let g:fugitive_git_executable = 'git -c color.status=false'

"---------------------------------------------
"  Key bindings
"---------------------------------------------

nnoremap <c-b> :CtrlPBuffer<CR>
nnoremap <c-t> :CtrlPBufTag<CR>
nnoremap <c-o> :NERDTreeToggle<CR>
nnoremap <silent> <leader>x :bw<CR>
nnoremap <space> /
nnoremap <up>   <C-Y>
nnoremap <down> <C-E>
nnoremap <silent> <left>  :bNext<CR>
nnoremap <silent> <right> :bnext<CR>
nnoremap <leader>p :set invpaste paste?<CR>
nnoremap <leader>n :set nonumber!<CR>
nnoremap <leader>v V`]
nnoremap <Leader>gb :Gblame<CR>
nnoremap <leader>gs :Gstatus<CR><C-w>20+
nnoremap <leader>gc :Gcommit<CR>
nmap <leader>cc gcc
map <Leader>x <Plug>Kwbd

vnoremap aa :Align =><CR>
vnoremap ae :Align =<CR>
vmap <leader>cc gc

inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
