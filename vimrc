set nocompatible             " be iMproved, required
filetype off                 " required

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
set undolevels=100
set laststatus=2

let mapleader = ","

hi SignColumn ctermbg=none
hi LineNr ctermbg=none
hi FoldColumn ctermbg=none
hi GitGutterAdd ctermbg=none ctermfg=green
hi GitGutterChange ctermbg=none ctermfg=yellow
hi GitGutterDelete ctermbg=none ctermfg=red
hi Pmenu ctermbg=black ctermfg=lightgray
hi Search ctermfg=black
hi Visual ctermfg=black

"---------------------------------------------
"  Load plugins
"---------------------------------------------

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'kien/ctrlp.vim.git'
Plugin 'scrooloose/nerdtree.git'
Plugin 'Align'
Plugin 'terryma/vim-multiple-cursors.git'
Plugin 'airblade/vim-rooter.git'
Plugin 'tomtom/tcomment_vim.git'
Plugin 'airblade/vim-gitgutter.git'
Plugin 'Shougo/neocomplete.vim.git'
Plugin 'tpope/vim-fugitive.git'
Plugin 'kwbdi.vim'
Plugin 'puppetlabs/puppet-syntax-vim.git'
Plugin 'xsbeats/vim-blade.git'
Plugin 'extradite.vim'
Plugin 'itchyny/lightline.vim.git'
Plugin 'localvimrc'
Plugin 'scrooloose/syntastic.git'
Plugin 'rayburgemeestre/phpfolding.vim.git'
"Plugin 'SirVer/ultisnips.git'
Plugin 'honza/vim-snippets.git'
Plugin 'joonty/vdebug.git'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

syntax on

au BufNewFile,BufRead *.pp set filetype=puppet
au BufNewFile,BufRead *.blade.php set filetype=blade

"---------------------------------------------
"  Plugin settings
"---------------------------------------------

let g:ctrlp_match_window = 'top,order:ttb,min:1,max:20'
let g:ctrlp_map = '<c-f>'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ }

let g:neocomplete#enable_at_startup = 1

let g:fugitive_git_executable = 'git -c color.status=false'

let g:localvimrc_ask = 0
let g:localvimrc_sandbox = 0

let g:lightline = {
    \ 'colorscheme': 'wombat',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ],
    \   'right': [ [ 'syntastic', 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
    \ },
      \ 'component_function': {
      \   'fugitive': 'MyFugitive',
      \ },
    \ 'component_expand': {
    \   'syntastic': 'SyntasticStatuslineFlag',
    \ },
    \ 'component_type': {
    \   'syntastic': 'error',
    \ },
    \ }

let g:DisableAutoPHPFolding = 1

let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<c-b>'
let g:UltiSnipsJumpBackwardTrigger = '<c-z>'

let g:vdebug_options= {
\    "port" : 9025,
\    "server" : '',
\    "timeout" : 20,
\    "break_on_open" : 0,
\    "ide_key" : 'vagrant',
\    "path_maps": {"/vagrant/www": "/home/kovi/Development/jeti-vm/www"}
\}

"---------------------------------------------
"  Key bindings
"---------------------------------------------

nnoremap <c-b> :CtrlPBuffer<CR>
nnoremap <c-t> :CtrlPBufTag<CR>
nnoremap <c-m> :CtrlPMRUFiles<CR>
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
nnoremap gb :Gblame<CR>
nnoremap <silent> gs :call TigStatus()<CR>
nnoremap gc :Gcommit<CR>
"nmap <leader>cc gcc
map <Leader>x <Plug>Kwbd

vnoremap aa :Align =><CR>
vnoremap ae :Align =<CR>
vmap <leader>cc gc

inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" Switch windows with Shift+Arrow keys
map <Esc>[1;2A <S-Up>
map <Esc>[1;2B <S-Down>
map <Esc>[1;2C <S-Right>
map <Esc>[1;2D <S-Left>
map <S-Up> :lprev<CR>
map <S-Down> :lnext<CR>
map <S-Right> <C-W>w
map <S-Left> <C-W>W

nnoremap zf :EnablePHPFolds<CR>zz

map <Leader>1 <F1>
map <Leader>2 <F2>
map <Leader>3 <F3>
map <Leader>4 <F4>
map <Leader>5 <F5>
map <Leader>6 <F6>
map <Leader>7 <F7>
map <Leader>8 <F8>
map <Leader>9 <F9>
map <Leader>10 <F10>
map <Leader>11 <F11>
map <Leader>12 <F12>

"---------------------------------------------
"  Functions
"---------------------------------------------

function! MyFugitive()
  try
    if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
      let _ = fugitive#head()
      return strlen(_) ? '('._.')' : ''
    endif
  catch
  endtry
  return ''
endfunction

function! Multiple_cursors_before()
    exe 'NeoCompleteLock'
endfunction

function! Multiple_cursors_after()
    exe 'NeoCompleteUnlock'
endfunction

function! TigStatus()
    silent !tig status
    redraw!
endfunction

function! TigShow()
    silent !tig show HEAD -- file
    redraw!
endfunction
