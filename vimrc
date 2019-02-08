" ==================
"  General Settings
" ==================
set nocompatible

" Enable color syntaxing
syntax on

" Show line numbers
set number

" Display long lines as just one line
set nowrap

" Indicates input or replace mode at bottom
set showmode

" Set the text width for automatic word wrapping to 80 characters
set tw=80

set smartcase
set smarttab
set smartindent
set autoindent

" Use 2 spaces to indent
set softtabstop=2
set shiftwidth=2
set expandtab

" Incremental search
set incsearch

" Highlight search results
set hlsearch

" Make backspace 'work' as expected
set backspace=indent,eol,start

set mouse=a
set history=1000

set completeopt=menuone,menu,longest

set wildignore+=*\\tmp\\*,*.swp,*.swo,*.zip,.git,.cabal-sandbox
set wildmode=longest,list,full
set wildmenu
set completeopt+=longest

set t_Co=256

set cmdheight=1
set noswapfile

" Disable annoying beeping
set noerrorbells
set vb t_vb=

" Show trailing whitespace as an error
match Error /s\s+$/

set omnifunc=syntaxcomplete#Complete

" ==================
"  Plugins (Vundle)
" ==================

filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Precision colorscheme for the vim text editor
Plugin 'altercation/vim-colors-solarized'

" A tree explorer plugin for vim.
Plugin 'scrooloose/nerdtree'

" A plugin of NERDTree showing git status
Plugin 'Xuyuanp/nerdtree-git-plugin'

" Vim plugin for intensely orgasmic commenting
Plugin 'scrooloose/nerdcommenter'

" NERDTree and tabs together in Vim, painlessly
Plugin 'jistr/vim-nerdtree-tabs'

" Lean & mean status/tabline for vim that's light as air
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" Full path fuzzy file, buffer, mru, tag, ... finder for Vim.
Plugin 'ctrlpvim/ctrlp.vim'

" Syntax checking hacks for vim
Plugin 'scrooloose/syntastic.git'

" Support for textual snippets
Plugin 'garbas/vim-snipmate'

" Vim script for text filtering and alignment
Plugin 'godlygeek/tabular'

" Perform all your vim insert mode completions with Tab
Plugin 'ervandew/supertab'

" A Vim plugin which shows a git diff in the gutter
Plugin 'airblade/vim-gitgutter'

" A Git wrapper so awesome, it should be illegal
Plugin 'tpope/vim-fugitive'
map <silent> <Leader>b :Gblame<CR>

" Vim plugin for Haskell development powered by the lightning fast hdevtools
" background server.
Plugin 'bitc/vim-hdevtools'

au FileType haskell nnoremap <buffer> <Leader>t :HdevtoolsType<CR>
au FileType haskell nnoremap <buffer> <Leader>tt :HdevtoolsClear<CR>

" Utility
" -------

" Some utility functions for VIM
Plugin 'tomtom/tlib_vim'

" Interpret a file by function and cache file automatically
Plugin 'MarcWeber/vim-addon-mw-utils'

" Interactive command execution in Vim
Plugin 'Shougo/vimproc.vim'

" Next generation completion framework after neocomplcache
Plugin 'Shougo/neocomplete.vim'

" Haskell + Idris
" ---------------

" Happy Haskell programming on Vim
" Plugin 'eagletmt/ghcmod-vim'
"
" " A completion plugin for Haskell, using ghc-mod
" Plugin 'eagletmt/neco-ghc'

" TODO: Sort out binding conflicts
" Idris mode for vim
Plugin 'idris-hackers/idris-vim'

" Purescript syntax colouring
Plugin 'purescript-contrib/purescript-vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" =================
"  Plugin Settings
" =================

" syntastic
map <Leader>s :SyntasticToggleMode<CR>

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

" ghc-mod
map <silent> tw :GhcModTypeInsert<CR>
map <silent> ts :GhcModSplitFunCase<CR>
map <silent> tq :GhcModType<CR>
map <silent> te :GhcModTypeClear<CR>

" supertab
let g:SuperTabDefaultCompletionType = '<c-x><c-o>'

if has("gui_running")
  imap <c-space> <c-r>=SuperTabAlternateCompletion("\<lt>c-x>\<lt>c-o>")<cr>
else " no gui
  if has("unix")
    inoremap <Nul> <c-r>=SuperTabAlternateCompletion("\<lt>c-x>\<lt>c-o>")<cr>
  endif
endif

" neco-ghc
let g:haskellmode_completion_ghc = 1
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

" nerdtree
map <Leader>n :NERDTreeToggle<CR>

" tabularize
let g:haskell_tabular = 1

vmap a= :Tabularize /=<CR>
vmap a; :Tabularize /::<CR>
vmap a- :Tabularize /-><CR>

" ctrl-p
map <silent> <Leader>p :CtrlP()<CR>
noremap <leader>b<space> :CtrlPBuffer<cr>
let g:ctrlp_custom_ignore = '\v[\/]dist$'
nnoremap <leader>. :CtrlPTag<cr>

let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<2-LeftMouse>'],
    \ 'AcceptSelection("t")': ['<cr>'],
    \ }

" vim-nerdtree-tabs
" Shortcut to toggle nerdtree
noremap <C-\> :NERDTreeTabsToggle<CR>

" vim airline
" Get airline to show when nerdtree isn't visible
set laststatus=2

" Solarized
set background=dark
let g:solarized_termcolors=256
colorscheme solarized

" https://stackoverflow.com/questions/356126/how-can-you-automatically-remove-trailing-whitespace-in-vim
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" https://vi.stackexchange.com/questions/12275/how-to-go-back-to-beginning-of-the-line-in-ex-command-mode
cnoremap <C-a> <C-b>

" Liyang's conflict
nmap <Leader>c /^[<\|=>]\{7\}\%( .*\)\?$<cr>

" Sort Haskell+PureScript imports
nmap <Leader>i  vip:sort i /^import \+\%(qualified \+\)\?\\|^{-# *LANGUAGE \+/<cr>

" Search for current visual selection
vnoremap // y/<C-R>"<CR>
