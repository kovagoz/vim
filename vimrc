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
set smartcase
set backspace=start,indent,eol
set noswapfile
set wildignore+=*/.git/*,*/node_modules/*,*/assets/*
set listchars=tab:>-,trail:.,extends:>,precedes:<
set list
set ruler
set undolevels=100
set laststatus=2

let mapleader = ","

"---------------------------------------------
"  Load plugins
"---------------------------------------------

call plug#begin('~/.vim/plugged')

Plug 'kien/ctrlp.vim'
Plug 'tacahiroy/ctrlp-funky'
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'Align'
Plug 'terryma/vim-multiple-cursors'
Plug 'tomtom/tcomment_vim'
Plug 'airblade/vim-gitgutter'
Plug 'Shougo/neocomplete.vim'
Plug 'tpope/vim-fugitive'
Plug 'kwbdi.vim'
"Plugin 'puppetlabs/puppet-syntax-vim'
Plug 'xsbeats/vim-blade', {'for': 'blade'}
Plug 'extradite.vim'
Plug 'itchyny/lightline.vim'
"Plug 'localvimrc'
Plug 'scrooloose/syntastic'
Plug 'rayburgemeestre/phpfolding.vim', {'for': 'php'}
Plug 'SirVer/ultisnips'
"Plug 'joonty/vdebug'
Plug 'daylerees/colour-schemes', {'rtp': 'vim/'}
Plug 'chase/vim-ansible-yaml', {'for': 'ansible'}
Plug 'smerrill/vcl-vim-plugin', {'for': 'vcl'}
Plug 'tommcdo/vim-exchange'
" Plugin 'zenorocha/dracula-theme', {'rtp': 'vim/'}
Plug 'NLKNguyen/papercolor-theme'
Plug 'tobyS/vmustache' " Required by pdv
Plug 'tobyS/pdv', {'for': 'php'}
Plug 'adoy/vim-php-refactoring-toolbox', {'for': 'php'}

call plug#end()
"filetype plugin indent on    " required

syntax on

if has('gui_running')
    set background=light
    colorscheme PaperColor
    set guifont=Osaka-Mono:h15
    set linespace=6
    set guioptions-=r " disable right-hand scrollbar
    set guioptions-=L " disable left-hand scrollbar
    set guioptions+=c " console prompts instead of dialogs
    hi clear Directory
    hi clear VertSplit
    hi link Directory StorageClass
    hi link VertSplit Comment
endif

hi SignColumn ctermbg=none guibg=bg
hi LineNr ctermbg=none
hi FoldColumn ctermbg=none
" hi GitGutterAdd ctermbg=none ctermfg=green guifg=green
" hi GitGutterChange ctermbg=none ctermfg=yellow guifg=yellow
" hi GitGutterChangeDelete ctermbg=none ctermfg=yellow guifg=yellow
" hi GitGutterDelete ctermbg=none ctermfg=red guifg=red
hi Pmenu ctermbg=black ctermfg=lightgray guibg=Black guifg=LightGray
hi Search ctermfg=black
hi Visual ctermfg=black
hi Folded ctermfg=Black ctermbg=DarkGray guifg=Black

au BufNewFile,BufRead *.pp set filetype=puppet
au BufNewFile,BufRead *.blade.php set filetype=blade
au BufNewFile,BufRead *.conf set filetype=conf

" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

"---------------------------------------------
"  Plugin settings
"---------------------------------------------

let Tlist_Show_One_File = 1
let Tlist_Sort_Type = "name"

let g:vim_php_refactoring_use_default_mapping = 0
let g:vim_php_refactoring_auto_validate_visibility = 1
let g:vim_php_refactoring_default_property_visibility = 'protected'
let g:vim_php_refactoring_default_method_visibility = 'protected'

let g:pdv_template_dir = $HOME . "/.vim/doc_snips"

let g:ctrlp_match_window = 'top,order:ttb,min:1,max:20'
let g:ctrlp_map = '<c-f>'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '(vendor|\.(git|hg|svn))$',
  \ }

let g:neocomplete#enable_at_startup = 1

let g:fugitive_git_executable = 'git -c color.status=false'

let g:localvimrc_ask = 0
let g:localvimrc_sandbox = 0

let g:lightline = {
    \ 'colorscheme': 'PaperColor',
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

let g:UltiSnipsExpandTrigger="<s-tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
"let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

let g:vdebug_options= {
\    "port" : 9025,
\    "server" : '',
\    "timeout" : 20,
\    "break_on_open" : 0,
\    "ide_key" : 'vagrant',
\    "path_maps": {"/vagrant/www": "/home/kovi/Development/jeti-vm/www"}
\}

let g:NERDTreeWinSize = 40
let g:NERDTreeShowBookmarks = 1
let g:NERDTreeBookmarksSort = 1
let g:NERDTreeChDirMode = 2

let g:syntastic_php_php_exec = '/usr/local/php5/bin/php'

"---------------------------------------------
"  Key bindings
"---------------------------------------------

nnoremap <Leader>rlv :call PhpRenameLocalVariable()<CR>
nnoremap <Leader>rcv :call PhpRenameClassVariable()<CR>
nnoremap <Leader>eu :call PhpExtractUse()<CR>
nnoremap <Leader>rm :call PhpRenameMethod()<CR>
vnoremap <Leader>ec :call PhpExtractConst()<CR>
nnoremap <Leader>ep :call PhpExtractClassProperty()<CR>
vnoremap <Leader>em :call PhpExtractMethod()<CR>
nnoremap <Leader>np :call PhpCreateProperty()<CR>
nnoremap <Leader>du :call PhpDetectUnusedUseStatements()<CR>
nnoremap <Leader>sg :call PhpCreateSettersAndGetters()<CR>

nnoremap <c-p> :call pdv#DocumentWithSnip()<CR>
nnoremap <c-m> :CtrlPBuffer<CR>
nnoremap <c-t> :CtrlPFunky<CR>
nnoremap <c-h> :CtrlPMRUFiles<CR>
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

nnoremap <Leader>b :call Codebug()<CR>

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

fun! Codebug()
    let current_file = expand('%:p')
    let current_line = line(".")
    exec 'silent !open "codebug://send?file=' . current_file . '&line=' . current_line . '&op=add&open=0"'
endfun
