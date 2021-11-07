" Avoid headache
set nocompatible

call plug#begin('~/.vim/plugged')
    Plug 'neoclide/coc.nvim', {'branch': 'release'} " Autocompletion
    Plug 'jiangmiao/auto-pairs' " Complete brackets
    Plug 'airblade/vim-gitgutter' " Integrate git
    Plug 'preservim/nerdtree' " File explorer
    Plug 'tpope/vim-fugitive' " Show diff
    Plug 'ryanoasis/vim-devicons' " Pretty icons in file explorer
    Plug 'Xuyuanp/nerdtree-git-plugin' " Git changes in nerdtree
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight' " Add syntax for nerdtree
    Plug 'sheerun/vim-polyglot' " Language packs
    Plug 'morhetz/gruvbox' " Color theme
    Plug 'itchyny/lightline.vim' " Line with info
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " Quick file finder
    Plug 'junegunn/fzf.vim' " Quick file finder
    Plug 'Yggdroot/indentLine' " Show connecting vertical indent lines
    Plug 'heavenshell/vim-jsdoc', { 
        \ 'for': ['javascript', 'javascript.jsx','typescript'],
        \ 'do': 'make install'
    \} " Generate jsdoc
call plug#end()

syntax on "Turn on syntax highlighting
filetype plugin indent on "Detection, plugins and indenting
colorscheme gruvbox "Set the best color scheme in the world

set noerrorbells
set tabstop=4
set softtabstop=4
set shiftwidth=4
set ruler
set expandtab
set nohlsearch
set smartindent
set nu
set nowrap
set smartcase
set smarttab
set autoindent
set ignorecase
set noswapfile
set nobackup
set nowritebackup
set cmdheight=1
set shortmess+=c
set undodir=~/.vim/undodir
set undofile
set incsearch
set updatetime=100
set cul
set encoding=UTF-8
set colorcolumn=120
set hidden
set relativenumber
set termguicolors
set scrolloff=8
set signcolumn=yes
set background=dark
set laststatus=2 
set noshowmode
set sc
set sol
set foldtext=gitgutter#fold#foldtext()
set clipboard=unnamedplus

" Highlight vertical column
highlight ColorColumn ctermbg=0 guibg=#689d6a

" Hide colored spaces left to numbers
highlight! link SignColumn LineNr

" Coc extensions
let g:coc_global_extensions = [
            \ 'coc-css',
            \ 'coc-browser',
            \ 'coc-html',
            \ 'coc-json',
            \ 'coc-prettier',
            \ 'coc-cssmodules',
            \ 'coc-emmet',
            \ 'coc-eslint',
            \ 'coc-html',
            \ 'coc-htmldjango',
            \ 'coc-htmlhint',
            \ 'coc-html-css-support',
            \ 'coc-stylelint',
            \ 'coc-yaml',
            \ 'coc-vetur',
            \ 'coc-tsserver']

" Resolve django html bug
let g:coc_filetype_map = {
    \ 'htmldjango': 'html',
    \ }

" Lightline config
let g:lightline = {
      \ 'colorscheme': 'one',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'relativepath', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

" Tweak tabs to use lightline theme colors
let s:palette = g:lightline#colorscheme#one#palette
let s:palette.tabline.tabsel = [ [ '#000000', '#98c379', 255, 255, 'bold' ] ]
unlet s:palette

" Show gitgutter symbols colored bg
let g:gitgutter_highlight_linenrs=1

" Nerdtree settings
let g:NERDTreeShowHidden=1
let g:NERDTreeMinimalUI=1
let g:NERDTreeWinSize=40

" Set leader to space 
let mapleader=" "

" Remaps

" Toggle nerd tree 
nnoremap <silent><C-n> :NERDTreeToggle<CR>

" Show file explorer according to git files
nnoremap <silent><C-f> :GFiles --cached --others --exclude-standard<CR>

" Show file eplorer according to string match
nnoremap <silent><C-p> :Rg<CR>

" Show buffers
nnoremap <silent><C-b> :Buffers<CR>

" Jump between windows easily
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Toggle between tabs
nnoremap <silent><C-Left> :tabprevious<CR>
nnoremap <silent><C-Right> :tabnext<CR>

nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Git hunk remaps
nmap gs <Plug>(GitGutterPreviewHunk)
nmap gu <Plug>(GitGutterUndoHunk)
nmap gn <Plug>(GitGutterNextHunk)
nmap gp <Plug>(GitGutterPrevHunk)

" Git merge conflicts
nnoremap <silent><leader>gs :Gvdiffsplit!<CR>
nnoremap <silent><leader>gh :diffget //2<CR>
nnoremap <silent><leader>gl :diffget //3<CR> 

" Fix scss problems
" autocmd FileType scss setl iskeyword+=@-@

" Exit Vim if NERDTree is the only window left
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

" Start NERDTree when Vim starts with a directory argument.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
\ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif
